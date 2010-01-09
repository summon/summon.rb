class Summon::Citation < Summon::Schema
  attr :name
  attr :label
  attr :short_name
  attr :caption
  attr :text
  
  def self.parse_results(results)
    results["Results"]["Citations"]["Citation"].map {|result| new(@service, result) }
  end
end
