require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Transport::Headers do

  before(:each) do
    Time.httpdate("Tue, 30 Jun 2009 12:10:24 GMT").tap do |point|
      Time.stub!(:now).and_return(point)
    end
  end

  it "give the request parameters, it represents the correct headers" do
    Summon::Transport::Headers.new(
        :url => "http://magg1.beta.projectmagnolia.net:8083/summon-search-api/search2",
        :access_id => "test",
        :client_key => "PX3FK6GB6M",
        :secret_key => "ed2ee2e0-65c1-11de-8a39-0800200c9a66",
        :accept => "xml",
        :request_id => "d217713c7ca744dfa5ccec572286c0f9",
        :params => {'s.ff' => 'ContentType,or,1,15', 's.q' => 'forest'}
      ).should == {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=utf8',
        'Accept' => 'application/xml',
        'x-summon-date' => 'Tue, 30 Jun 2009 12:10:24 GMT',
        'x-summon-request-id' => 'd217713c7ca744dfa5ccec572286c0f9',
        'Authorization' => 'Summon test;PX3FK6GB6M;g1SZb73Vg6bV7VhFQ2KkCLy98rE=',
        'Host' => 'magg1.beta.projectmagnolia.net:8083'
    }
  end

  it "successfully handles array parameters" do
    Summon::Transport::Headers.new(
        :url => "http://magg1.beta.projectmagnolia.net:8083/summon-search-api/search2",
        :access_id => "test",
        :client_key => "PX3FK6GB6M",
        :secret_key => "ed2ee2e0-65c1-11de-8a39-0800200c9a66",
        :session_id => "Session-3000!",
        :accept => "xml",
        :request_id => "d217713c7ca744dfa5ccec572286c0f9",
        :params => {'s.ff' => ['ContentType,or,1,15'], 's.q' => ['forest']}
      ).should == {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=utf8',
        'Accept' => 'application/xml',
        'x-summon-date' => 'Tue, 30 Jun 2009 12:10:24 GMT',
        'x-summon-request-id' => 'd217713c7ca744dfa5ccec572286c0f9',
        'x-summon-session-id' => "Session-3000!",
        'Authorization' => 'Summon test;PX3FK6GB6M;g1SZb73Vg6bV7VhFQ2KkCLy98rE=',
        'Host' => 'magg1.beta.projectmagnolia.net:8083'
    }

  end
end
