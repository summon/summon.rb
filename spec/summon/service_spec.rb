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

  it "allows cloning a service with overridden settings" do
    options = {:url => "http://google.com", :access_id => "Bob", :secret_key => "Happiness", :session_id => "foo", :client_key => "Justice"}
    service = Summon::Service.new(options)
    another = service[{:access_id => "John"}]
    another.access_id.should == "John"
    another.client_key.should == options[:client_key]
    another.url.should == options[:url]
    another.instance_variable_get(:@secret_key).should == options[:secret_key]
  end

  
  describe "Locale" do
  
    it "has a default" do
      Summon::Service.new.locale.should == 'en'
    end
  
    it "doesn't matter whether you pass it a symbol or not for the locale" do
      Summon::Service.new(:locale => :nl).locale.should == 'nl'
    end
  
  end
      
end
