require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::RangeFacet do
  it "maps" do
    range = Summon::RangeFacet.new(@service, JSON.parse(<<-JSON))
    {
      "displayName": "PublicationDate",
      "removeCommand": "removeFacetField(PublicationDate)",
      "fieldName": "PublicationDate",
      "counts": [
        {
          "count": 119795,
          "applyCommand": "addRangeFilter(PublicationDate,1999:1999)",
          "range": {
            "minValue": "1999",
            "maxValue": "2000"
          },
          "isApplied": true
        },
        {
          "count": 122712,
          "applyCommand": "addRangeFilter(PublicationDate,2000:2000)",
          "range": {
            "minValue": "2000",
            "maxValue": "2001"
          },
          "isApplied": false
        }
      ]
    }
    JSON
    range.display_name.should == "PublicationDate"
    range.remove_command.should == "removeFacetField(PublicationDate)"
    range.field_name.should == "PublicationDate"
    range.counts.should_not be_nil
    range.counts.length.should be(2)
    range.counts[0].tap do |c|
      c.count.should == 119795
      c.apply_command.should == "addRangeFilter(PublicationDate,1999:1999)"
      c.min.should == "1999"
      c.max.should == "2000"
      c.should be_applied
    end
  end
end
