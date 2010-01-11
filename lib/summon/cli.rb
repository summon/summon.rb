require 'optparse'
require 'json'
require 'fileutils'

module Summon
  class CLI
    def self.execute(stdout, arguments=[])
      config = Config.load
      options = {
        :log => {:level => :warn}
      }
      params = {
        "s.pn" => 1,
        "s.ps" => 10,
        "s.q" => [],
        "s.fq" => [],
        "s.st" => [],
        "s.cmd" => [],
        "s.ff" => [],
        "s.fvf" => [],
        "s.fvgf" => [],
        "s.rff" => [],
        "s.hs" => "*",
        "s.he" => "*",
        "s.role" => "none"
      }
      raw = nil

      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Summon Unified Discovery Service

          Usage: #{File.basename($0)} [options] [text query]*
          See: http://api.summon.serialssolutions.com/help for details

        BANNER
        opts.separator  "API query parameters"
        opts.on("--s.cmd=COMMAND", String, "Command: pass a command to the API") {|cmd| params["s.cmd"] << cmd}       
        opts.on("--s.q=QUERY", String, "Query Term: add an all-field text query to the search") {|q| params["s.q"] << q}
        opts.on("--s.fq=QUERY", String, "Filter Query: add a filter query which does not affect document relevance") {|fq| params["s.fq"] << fq}
        opts.on("--s.st=FIELD,VALUE", String, "Search Term: add a query term to a field") {|t| params["s.st"] << t}
        opts.on("--s.ff=FIELD,MODE,PAGE", String, "Facet Field: request facet counts for the given Field") {|f| params['s.ff'] << f}
        opts.on("--s.fvf=FIELD,VALUE,NEGATED", "Facet Value Filter: applies an exact-value filter for a facet value within a facetable field: e.g. ContentType,Book") {|fvf| params["s.fvf"] << fvf}
        opts.on("--s.fvgf=FIELD,MODE,VALUES", "Facet Value Group Filter: advanced functionality. see official api docs. e.g. 'SubjectTerms,or,northern+america,u.s.,canada'")
        opts.on("--s.rff=<facetField>, <minValue>:<maxValue>[:<inclusive>][, <minValue>:<maxValue>[:<inclusive>]]*", "Range Facet Field: e.g. PublicationDate,1971:1980,1981:1990,1991:2000,2001:2010") {|rff| params["s.rff"] << rff}
        opts.on("--s.rf=<fieldName>, <minValue>:<maxValue>[:<inclusive>]", "Range Filter: filter the result list to values lying within the range. e.g. PublicationDate,1971:1980")
        opts.on("--s.hl=BOOLEAN", "Highlight: turn highlighting on or off: e.g. --s.hl=false") {|hl| params["s.hl"] = hl}
        opts.on("--s.hs=DELIMITER", String, "Highlight Start: demarcate the beginning of a term hit. default is *") {|d| params["s.hs"] = d}
        opts.on("--s.he=DELIMITER", String, "Highlight End: demarcate the beginning of a term hit. default is *") {|d| params["s.he"] = d}
        opts.on("--s.ps=INT", Integer, "Page Size: number of documents to return per page") {|n| params["s.ps"] = n}
        opts.on("--s.pn=INT", Integer, "Page Number: start the results at this page, starting with 1") {|n| params["s.pn"] = n}
        opts.on("--s.ho=BOOLEAN", "Holdings Only: restrict this search to my institution's holdings only ") {|n| params["s.ho"] = n}
        opts.on("--s.sort=FIELD:DIRECTION", "Sort: specifiy sort order (e.g. PublicationDate:DESC)") {|s| params["s.sort"] = s}
        opts.on("--s.dym=BOOLEAN", "Did You Mean?: enables or disables search suggestions.") {|dym| params["s.dym"] = dym}
        opts.on("--s.role=VALUE", "API Authorization Role.  e.g. --s.role=none (default) or --s.role=authenticated") {|s| params["s.role"] = s}

        opts.separator ""
        opts.separator "Configuration Options"
        opts.on("-u", "--url=KEY", String, "Summon API Base URL", "Default: http://api.summon.serialssolutions.com",
                "Default: ~/.summonrc[url]") {|key| options[:url] = key}
        opts.on("-i", "--access-id=ID", String,
                "Summon API Access ID",
                "Default: ~/.summonrc[access_id]") { |id| options[:access_id] = id }
        opts.on("-k", "--secret-key=KEY", String, "Summon API Secret Key", "Default: ~/.summonrc[secret_key]") {|key| options[:secret_key] = key}
        opts.on("-c --sersol-client-id=CLIENT_HASH", String, "Specific Serials Solutions Client ID to use when making this query", 
          "Only useful when your access id is authorized to query multiple accounts") {|id| options[:client_key] = config.client_key(id)}
          
        opts.on("-g", "--get=URL", "Takes a raw summon url, and queries the api without first performing any encoding.") {|url| raw = url}
        opts.on("--verbose", "output more request information") {options[:log].merge! :level => :info }
        opts.on("--debug", "output very detailed information") {options[:log].merge! :level => :debug }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
                      
        begin
          opts.parse!(arguments)
        rescue OptionParser::ParseError => e
          puts e.message; exit
        end        
        
        params["s.q"] << ARGV.join(' ') unless ARGV.empty?

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end
      begin
        service = Summon::Service.new(config.options.merge options)
        puts JSON.pretty_generate(raw ? service.transport.urlget(raw) : service.transport.get("/search", params))
      rescue Summon::Transport::TransportError => e
        puts e.message
      end

    end
    
    
    class Config
      attr_reader :url, :access_id, :secret_key
      
      def initialize
        @clients = {}
      end
      
      def self.load
        summonrc = "#{ENV['HOME']}/.summonrc"
        FileUtils.touch summonrc unless File.exists?(summonrc)        
        new.tap do |this|
          this.instance_eval(File.read(summonrc), summonrc, 1)
        end
      end
          
      def url(url)
        @url = url
      end
      
      def access_id(access_id)
        @access_id = access_id
      end
      
      def secret_key(secret_key)
        @secret_key = secret_key
      end
      
      def clients(h)
        @clients = h
      end
      
      def client_key(name)              
        @clients[name.to_sym] || name
      end
      
      def options
        {:url => @url, :access_id => @access_id, :secret_key => @secret_key}
      end
    end
  end
end