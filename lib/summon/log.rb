require 'logger'

module Summon
  class Log
    
    attr_reader :impl
    
    def initialize(spec = nil)
      @impl = create spec
    end
    
    def method_missing(name, *args, &block)
      @impl.respond_to?(name) ? @impl.send(name, *args, &block) : super(name, *args, &block)
    end
    
    def respond_to?(name)
      @impl.respond_to?(name) || super(name)
    end
    
    private
    
    def create(spec)
      case spec
      when nil
        Logger.new($stderr).tap do |this|
          this.level = Logger::WARN
        end
      when Hash
        level = spec[:level] || "warn"
        init = spec[:initialize] || [$stderr]
        Logger.new(*init).tap do |this|
          this.level = Logger.const_get(level.to_s.upcase)
        end
      else
        spec
      end
    end
    
  end
end
