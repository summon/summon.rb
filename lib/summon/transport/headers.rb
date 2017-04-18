require 'time'
require 'uri'
require 'openssl'
require 'digest/sha1'
require 'base64'

module Summon::Transport
  class Headers < Hash
    include Qstring
    def initialize(options = {})
      @params       = options[:params] || {}
      @url          = options[:url]
      @uri          = URI.parse(@url)
      @access_id    = options[:access_id]
      @client_key   = options[:client_key]
      @secret_key   = options[:secret_key]
      @session_id   = options[:session_id]
      @request_id   = options[:request_id]
      @log          = Summon::Log.new(options[:log])
      @accept       = "application/#{options[:accept] || 'json'}"
      @time         = Time.now.httpdate
      validate!
      merge!({
        "Content-Type" => "application/x-www-form-urlencoded; charset=utf8",
        "Accept" => @accept,
        "x-summon-date" => @time,
        "x-summon-session-id" => @session_id,
        "x-summon-request-id" => @request_id,
        "Authorization" => "Summon #{[@access_id, @client_key, digest].reject {|o| o.nil?}.join(';')}",
        "Host" => "#{@uri.host}:#{@uri.port}"
      }).reject! {|k,v| v.nil?}
      @log.debug {
        "#{self.class.name}\n#{self.map {|k,v| "#{k}: #{v}"}.join("\n")}"
      }
    end

    def digest
      id = [@accept, @time, "#{@uri.host}:#{@uri.port}", @uri.path, qstr].join("\n") + "\n"
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, @secret_key, id)).chomp.tap {|digest|
        # @log.debug {"ID: #{id.inspect}"}
        # @log.debug {"DIGEST: #{digest}\n"}
      }
    end

    def qstr
      to_query_string(@params, false, lambda {|k,v| v.nil? })
    end

    private

    def validate!
      raise AuthorizationError, "No Access ID specified" if @access_id.nil?
      raise AuthorizationError, "Secret Key not provided for Access ID: #{@access_id}" if @secret_key.nil?
    end

  end
end
