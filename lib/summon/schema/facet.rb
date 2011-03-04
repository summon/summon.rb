
class Summon::Facet < Summon::Schema
  attr :page_size
  attr :display_name
  attr :field_name
  attr :combine_mode
  attr :page_number
  attr :counts, :transform => :FacetCount
  attr :remove_command
  attr :remove_value_filters_command    


  def to_s
    "Facet(#{display_name}, #{field_name})"
  end

  def range?
    false
  end
  
  def empty?
    @counts.empty?
  end
  
end

class Summon::FacetCount < Summon::Schema
  attr :value
  attr :count
  attr :negated?
  attr :applied?
  attr :further_limiting?
  attr :apply_command
  attr :apply_negated_command
  attr :remove_command

  def escaped_value
    Summon.escape(@value)
  end
  
  def excluded?
    negated?
  end
  
  def included?
    applied? && !excluded?
  end
 
  def abs_value
    value.sub /^-/, ''
  end

end
