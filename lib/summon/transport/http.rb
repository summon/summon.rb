require 'socket'
require 'net/http'

module Summon::Transport
  class Http
    include Qstring

    DEFAULTS = {:url => "https://api.summon.serialssolutions.com"}

    def initialize(options = {:url => nil, :access_id => nil, :secret_key => nil, :client_key => nil, :session_id => nil, :log => nil})
      @options    = DEFAULTS.merge options
      @access_id  = @options[:access_id]
      @secret_key = @options[:secret_key]
      @client_key = @options[:client_key]
      @session_id = @options[:session_id] || "SUMMON-SESSION-#{Socket.gethostname}-#{$$}-#{sidalloc}"
      @url        = @options[:url]
      @log        = Summon::Log.new(options[:log])
      @benchmark  = @options[:benchmark] || Summon::Service::Pass.new
    end

    def get(path, params = {})
      session_id = params["s.session.id"]
      params.delete "s.session.id"
      urlget "#{@url}#{path}?#{to_query_string(params, true)}", params, session_id
    end

    def urlget(url, params = nil, session_id = nil)
      @benchmark.report("total:") do
        uri = URI.parse url
        params ||= from_query_string(uri.query)
        request_id = params["__request_id"] || ""
        session_id ||= @session_id
        headers = @benchmark.report("calculate headers") do
          Headers.new(
            :url => url,
            :params => params,
            :access_id => @access_id,
            :secret_key => @secret_key,
            :client_key => @client_key,
            :session_id => session_id,
            :request_id => request_id,
            :log => @log
          )
        end
        @log.info("ruby-summon:transport") {
          "GET: #{url}"
        }
        result = nil
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.scheme == "https"
          http.start do
            get = Net::HTTP::Get.new("#{uri.path}#{'?' + uri.query if uri.query && uri.query != ''}")
            get.merge! headers
            response = @benchmark.report("http request") do
              http.request(get)
            end
            case response
              when Net::HTTPSuccess
                @benchmark.report("parse response") do
                  result = parse(response)
                end
              when Net::HTTPUnauthorized
                raise AuthorizationError, status(response)
              when Net::HTTPClientError
                raise RequestError, error(response)
              when Net::HTTPServerError
                raise ServiceError, error(response)
              else
                raise UnknownResponseError, "Unknown response: #{response}"
            end
          end

        ###
        result
      end
    end

    def parse(response)
      case response.content_type
      when "application/json"
        JSON.parse(response.body).tap do |json|
          @log.debug("ruby-summon::transport") { "JSON RESPONSE: #{json.inspect}" }
        end

      when "text/plain"
        response.body.tap do |text|
          @log.debug("ruby-summon::transport") { "TEXT RESPONSE: #{text.inspect}" }
        end

      else
        raise ServiceError, "service returned unexpected #{response.content_type} : #{response.body}"
      end
    end

    def error(response)
      case response.content_type
      when "application/json"
        JSON.parse(response.body)["errors"].first["message"]
      else
        status(response)
      end
    end

    def status(response)
      "#{response.code}: #{response.message}"
    end

    private

    @sessions = 0

    def sidalloc
      self.class.instance_eval do
        @sessions += 1
      end
    end

  end
end


module Net::HTTPHeader
  def merge!(hash)
    for k, v in hash
      self[k] = v
    end
  end
end
