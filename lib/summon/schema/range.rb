
class Summon::RangeFacet < Summon::Schema
  attr :display_name
  attr :field_name
  attr :remove_command
  attr :counts, :transform => :RangeCount
  
  def clear_filters_command
    "removeRangeFilter(#{field_name})"
  end

  def range?
    true
  end

  def empty?
    false
  end
  
  def local_name
    translate(@display_name)
  end
  
  # #COMPATIBILITY
  # 
  # alias_method :name, :display_name
  # alias_method :label, :display_name
  # alias_method :facets, :counts
  # alias_method :ranges, :counts

end

class Summon::RangeCount < Summon::Schema
  attr :count
  attr :applied?
  attr :apply_command
  attr :range
  
  def min
    @range["minValue"]
  end
  
  def max
    @range["maxValue"]
  end

  def abs_value
    ""
  end
  
  def apply_negated_command
    ""
  end
  
  alias_method :included?, :applied?
   
  def excluded?
      false
    end
end