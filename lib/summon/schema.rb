
module Summon
  class Schema
    def self.inherited(mod)            
      class << mod
        include Summon::Schema::Initializer
        include Summon::Schema::ClassMethods
      end
      mod.module_eval do
        include Summon::Schema::InstanceMethods
      end
      mod.summon!
    end

    module Initializer
      def new(service, values = {})
        dup = {}
        for k, v in values
          dup[k.to_s] = v
        end
        instance = allocate
        instance.instance_eval do
          @src = values
          @service = service
        end
        for attribute in @attrs
          instance.instance_variable_set("@#{attribute.name}", attribute.get(service, dup))
        end        
        instance
      end
    end
    
    module ClassMethods
      def attr(name, options = {})
        if name.to_s =~ /^(.*)\?$/
          name = $1
          options[:boolean] = true
        end
        symbol = name.to_sym
        @attrs << ::Summon::Schema::Attr.new(symbol, options)
        define_method(name) do |*args|
          self.instance_variable_get("@#{name}")  
        end
        if options[:boolean]
          define_method("#{name}?") do
            send(name)
          end
        end
      end
      
      def attrs
        @attrs
      end
      
      def summon!
        @attrs = []
        attr_reader :src
      end
    end
    
    module InstanceMethods
      def to_json(*a)
        self.class.attrs.inject({}) do |json, attr|
          json.merge attr.name => self.send(attr.name)
        end.to_json(*a)        
      end
      
      def locale
        @service.locale.gsub(/-/, "")
      end
      
      def translate(value)
        default = Summon::Locale.const_get(Summon::DEFAULT_LOCALE.upcase)
        translator = Summon::Locale.const_defined?(locale.upcase) ? Summon::Locale.const_get(locale.upcase) : default
        translator::TRANSLATIONS[value] ? translator::TRANSLATIONS[value] : default::TRANSLATIONS[value] ? default::TRANSLATIONS[value] : value
      end
    end
    
    class Attr
      attr_reader :name
      def initialize(name, options)
        @name = name
        @boolean = options[:boolean]
        @camel_name = camelize(name.to_s)
        @pascal_name = @camel_name.gsub(/^\w/) {|first| first.upcase}
        @transform = options[:transform]
        @json_name = options[:json_name].to_s if options[:json_name]
        @json_name = "is#{@pascal_name}" if @boolean unless @json_name
        @single = options[:single].nil? ? !(name.to_s.downcase =~ /s$/) : options[:single]
      end
      
      def get(service, json)
        raw = json[@json_name || @camel_name]
        raw = json[@pascal_name] if raw.nil?
        if raw.nil?
          @single ? nil : []
        else
          raw = @single && raw.kind_of?(Array) ? raw.first : raw
          transform(service, raw) || raw
        end
      end
      
      def camelize(str)
        str.gsub /(\w)_(\w)/ do
          "#{$1}#{$2.upcase}"
        end
      end

      def pascalize(str)
        str.gsub(/(_|^)(\w)/) {$2.upcase}
      end
      
      def transform(service, raw)
        if @transform
          case @transform
            when Class
              ctor = proc do |s,h|
                @transform.new(s, h)
              end

            when Array
              obj = ::Summon
              @transform.each do |ns|
                obj = obj.const_get(pascalize(ns.to_s))
              end
              ctor = proc do |s, h|
                obj.new(s, h)
              end

            else
              ctor = proc do |s,h|
                ::Summon.const_get(@transform).new(s,h)
              end
          end
          raw.kind_of?(Array) ? raw.map {|a| [service, a]}.map(&ctor) : ctor.call(service, raw)
        end
      end
    end
  end
 end
