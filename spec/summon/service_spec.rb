require File.dirname(__FILE__) + '/../spec_helper'

describe Summon::Service do
  
  it "can be configured" do
    Object.new.tap do |log|
      Summon::Transport::Http.should_receive(:new).with(hash_including(:url => "http://google.com", :access_id => "Bob", :session_id => "foo", :client_key => "Justice", :secret_key => "Happiness"))
      @service = Summon::Service.new :url => "http://google.com", :access_id => "Bob", :secret_key => "Happiness", :session_id => "foo", :client_key => "Justice"
      @service.url.should == "http://google.com"
      @service.access_id.should == "Bob"
    end
  end
  
  it "has a default url which is the public production summon url" do
    Summon::Service.new.url.should == "http://api.summon.serialssolutions.com"
  end
  
  it "should have a locale set to the locale specified" do
    Summon::Service.new.locale.should == 'en'
  end
      
end
