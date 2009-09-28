require File.expand_path(File.dirname(__FILE__) + '/../lib/summon')
gem 'rspec'
require 'spec'

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
    