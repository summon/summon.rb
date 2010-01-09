require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Date do
  it "should do stuff w/ date" do
    date = Summon::Date.new(@service, {"month"=>"01", "text"=>"c2000.", "day"=>"02", "year"=>"2000"})

    date.day.should == 2
    date.month.should == 1
    date.year.should == 2000
    date.text.should == "c2000."
  end
end
