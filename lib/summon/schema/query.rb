class Summon::Query < Summon::Schema

  attr :page_number
  attr :page_size
  attr :search_terms
  attr :query_string
  attr :facet_value_filters, :transform => :FacetValueFilter
  attr :inclusive_facet_value_filters, :transform => :FacetValueFilter
  attr :facet_value_group_filters, :transform => :FacetValueGroupFilter
  attr :text_queries
  attr :text_filters
  attr :range_filters, :transform => :RangeFilter
  attr :facet_fields
  attr :sorts, :transform => :Sort, :json_name => "sort"
  attr :params
  attr :holdings_only_enabled?

  def sort
    @sorts.first
  end
    
  def date_min
    date_filter do |f|
      val = f.range.min_value
      return val == "*" ? nil : val.to_i
    end
  end

  def date_max
    date_filter do |f|    
      val = f.range.max_value
      return val == "*" ? nil : val.to_i
    end
  end
  
  def date_filter
    range_filters.find {|f| f.field_name == "PublicationDate"}.tap do |this|
      yield this if this && block_given?
    end
  end
      
  def to_hash    
    # {}.tap do |params|
    #   for param in query_string.split("&") do
    #     name, value = param.split("=")
    #     next if value.nil?
    #     name = CGI.une
    #   end
    # end
    
    return {} if query_string.nil? || query_string == ""
    params = query_string.split("&").inject({}) do |params, param|
      name, value = param.split("=")
      next params if value.nil?
      name = CGI.unescape(name)
      value = CGI.unescape(value)
      params.tap do
        case params[name]
          when nil
            params[name] = value
          when String
            params[name] = [params[name], value]
          else
            params[name] << value
        end
      end
    end
  end
end

class Summon::Sort < Summon::Schema
  attr :field_name
  attr :sort_order
end

class Summon::FacetValueFilter < Summon::Schema
  attr :negated?
  attr :value
  attr :field_name
  attr :remove_command
  attr :negate_command
end

class Summon::FacetValueGroupFilter < Summon::Schema
  attr :combine_mode
  attr :tag
  attr :field_name
  attr :remove_command
  attr :values, :transform => :FacetValueGroupFilterValue
end

class Summon::FacetValueGroupFilterValue < Summon::Schema
  attr :value
  attr :remove_command
end

class Summon::RangeFilter < Summon::Schema
  attr :field_name
  attr :range, :transform => :Range
  attr :remove_command
end

class Summon::Range < Summon::Schema
  attr :min_value
  attr :max_value
end
