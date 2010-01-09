class Summon::Availability < Summon::Schema
  attr :token
  attr :status
  attr :status_message
  attr :location
  attr :location_string
  attr :call_number

  def self.parse_results(results)
    results["Result"]["RecordSummary"].map do |record| 
      new(@service, record["Record"].merge(:token => record["ID"]))
    end
  end
end
