
module Summon
  class Service
    
    attr_reader :transport, :url, :access_id, :client_key
    
    def initialize(options = {})
      @url        = options[:url] || "https://api.summon.serialssolutions.com/2.0.0"
      @access_id  = options[:access_id]
      @secret_key = options[:secret_key]
      @client_key = options[:client_key]
      @log        = Log.new(options[:log])
      @benchmark  = options[:benchmark] || Pass.new
      @transport  = options[:transport] || Summon::Transport::Http.new(:url => @url, :access_id => @access_id, :secret_key => @secret_key, :client_key => @client_key, :session_id => options[:session_id], :log => @log, :benchmark => @benchmark)
    end

    def version
      connect("/version") {|result| result["version"] }
    end

    def search(params = {})
      connect("/search", params) do |result|
        Summon::Search.new(self,result)
      end
    end

    def modify_search(original_search, command)
      search original_search.query.to_hash.merge("s.cmd" => command)
    end

    #clone a service with overridden options
    def [](options)
      self.class.new({:url => @url, :access_id => @access_id, :secret_key => @secret_key, :client_key => @client_key, :log => @log.impl, :benchmark => @benchmark}.merge(options))
    end

    private

    def connect(path, params = {})
      yield @transport.get(path, params)
    end

    class Pass
      def report(*args)
        yield
      end
    end
  end
end


