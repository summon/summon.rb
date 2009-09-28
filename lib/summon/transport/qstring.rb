
require 'cgi'

module Summon::Transport
  module Qstring
  
    def to_query_string(hash, urlencode = true)
      hash.reject {|k,v| v.nil? || v == ''}.inject([]) do |qs,pair|
        qs.tap do
          k,v = pair
          if v.is_a?(Array)
            for el in v
              qs << encode_param(k, el, urlencode)
            end
          else
            qs << encode_param(k, v, urlencode)
          end
        end
      end.reject{|o| o.nil? || o.empty?}.sort.join('&')        
    end
    
    def urlencode(str)
      str.gsub(/[^a-zA-Z0-9_\.\-]/n) {|s| sprintf('%%%02x', s[0]) }
    end
    
    def urldecode(str)
      CGI.unescape(str)
    end
  
    def encode_param(k, v, do_urlencode)
      "#{k.to_s}=#{do_urlencode ? urlencode(v.to_s) : v.to_s}"
    end
    
    def from_query_string(qstr)
      qstr ||= ""
      {}.tap do |result|
        for param in qstr.split('&')
          m,k,v = *param.match(/^(.*?)=(.*?)$/)
          if current = result[k]
            result[k] = current.to_a
            result[k] << urldecode(v)
          else
            result[k] = urldecode(v)
          end
        end        
      end
    end
  end 
end