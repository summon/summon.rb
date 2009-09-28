require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Availability do
  it "should map" do
    availabilities = Summon::Availability.parse_results("Result"=>{"RecordSummary"=>[
      {
        "ID"=>"1038053",
        "RecordList"=>"http://api.staging.summon.serialssolutions.com:8093/status?key=HD3UV5FG9E&output=application%2Fjson&action=list&token=1038053", 
        "Record"=>{"Status"=>"unknown", "StatusMessage"=>"Available", "Location"=>"Architecture Library", "CallNumber"=>" 720.979 A534"}, 
        "RecordCount"=>1}, 
      {
        "ID"=>"1038082", 
        "RecordList"=>"http://api.staging.summon.serialssolutions.com:8093/status?key=HD3UV5FG9E&output=application%2Fjson&action=list&token=1038082", 
        "Record"=>{"Status"=>"unknown", "StatusMessage"=>"Available", "Location"=>"Main Library", "CallNumber"=>" 628.5 B6157"}, 
        "RecordCount"=>1}]})
        
    one, two = availabilities
    
    one.token.should == "1038053"
    one.status.should == "unknown"
    one.status_message.should == "Available"
    one.location.should == "Architecture Library"
    one.call_number.should == " 720.979 A534"
    
    two.token.should == "1038082"
    two.status.should == "unknown"
    two.status_message.should == "Available"
    two.location.should == "Main Library"
    two.call_number.should == " 628.5 B6157"
  end
end
