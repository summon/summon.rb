require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::RecommendationList do
  it "should map" do    
    Summon::RecommendationList.new(nil, {
      "database" => [
        {
          "title" => "World Bank",
          "link" => "http://www.asme.org/pubs/journals/",
          "description" => "Digital library of the American Society of Mechanical Engineers publications."
        },
        {
          "title" => "ASME",
          "link" => "http://www.worldbank.icebox.ingenta.com/jsp/worldbank/home/librarians",
          "description" => "Digital library of the American Society of Mechanical Engineers publications."
        }
      ]
      
    }).tap do |list|
      list.databases.length.should == 2
      list.databases.first.tap do |wbank|
        wbank.title.should == "World Bank"
        wbank.link.should == "http://www.asme.org/pubs/journals/"
        wbank.description.should == "Digital library of the American Society of Mechanical Engineers publications."
      end
      
      list.databases.last.tap do |asme|
        asme.title.should == "ASME"
      end
    end
  end
end
