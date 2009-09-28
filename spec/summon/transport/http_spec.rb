require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Transport::Http do
  attr_reader :http
  
  before do
    @http = Summon::Transport::Http.new
  end
  
  describe "parse" do
    it "should parse json" do
      response = stub("response", :content_type => "application/json", 
                                  :body => '{"some":"json","foo":[1,2],"bar":3}')
      http.parse(response).should == {"some" => "json", "foo" => [1,2], "bar" => 3}
    end
  
    it "should parse text" do
      response = stub("response", :content_type => "text/plain", 
                                  :body => "some string\r\nand another one\r\n")
      http.parse(response).should == "some string\r\nand another one\r\n"
    end
  
    it "should raise error on anything else" do
      response = stub("response", :content_type => "text/xml", 
                                  :body => "<some>xml</some>")
      proc {http.parse(response)}.should raise_error(Summon::Transport::ServiceError, "service returned unexpected text/xml : <some>xml</some>")
    end
  end
end
