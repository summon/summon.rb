require File.expand_path(File.dirname(__FILE__) + '/../lib/summon')

require 'rspec'
require 'yaml'

def pre(text)
  puts "<pre>" +
    text.to_s.
      gsub("&", "&amp;").
      gsub("<", "&lt;").
      gsub(">", "&gt;") +
    "</pre>"
end

class Object
  def remove_src
    @src = nil
  end
end
    
