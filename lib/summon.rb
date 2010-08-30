$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'cgi'
require 'json'

module Summon
  VERSION = "1.1.10"
  DEFAULT_LOCALE = 'en'
  
  locale_dir = File.dirname(__FILE__) + '/summon/locales'
  Dir["#{locale_dir}/*.rb"].each { |file| 
    require file
  }

  require 'summon/log'
  require 'summon/service'
  require 'summon/transport'
  require 'summon/schema'
  require 'summon/schema/query'
  require 'summon/schema/search'
  require 'summon/schema/facet'
  require 'summon/schema/range'
  require 'summon/schema/document'
  require 'summon/schema/date'
  require 'summon/schema/suggestion'
  require 'summon/schema/availability'
  require 'summon/schema/citation'
  require 'summon/schema/error'
  require 'summon/schema/recommendation_list'
  
  def self.escape(value)
    value.gsub(/(,|\(|\)|\{|\}|\$|\:)/, '\\\\\1').gsub("\\", '\\')
  end

  def self.unescape(value)
    value.gsub(/\\(.)/, '\1')
  end
end

unless Object.method_defined?(:tap)
  class Object
    def tap(&block)
      yield self
      return self
    end
  end
end
