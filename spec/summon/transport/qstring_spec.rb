# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Transport::Qstring do
  before(:each) do
    extend Summon::Transport::Qstring
  end

  it "can decode a query string into hash parameters" do
    from_query_string("foo=bar&baz=bang").should == {"foo" => "bar", "baz" => "bang"}
  end

  it "stuffs multiple keys into the same value as a list" do
    from_query_string("foo=bar&foo=baz&bar=bang").should == {"foo" => ["bar", "baz"], "bar" => "bang"}
  end

  it "url decodes keys and values" do
    from_query_string("foo=bar%20bar&baz=bang+bang").should == {"foo" => "bar bar", "baz" => "bang bang"}
  end

  it "returns an empty hash if the query string is blank" do
    from_query_string(nil).should be_empty
    from_query_string("").should be_empty
  end

  it "encodes strings properly" do
    to_query_string("foo" => "bar").should == "foo=bar"
    to_query_string("foo" => "/").downcase.should == "foo=%2f"
  end

  it "encodes UTF-8 strings" do
    to_query_string("s.q"=> "らしさ」を失わな").downcase.should eql "s.q=%e3%82%89%e3%81%97%e3%81%95%e3%80%8d%e3%82%92%e5%a4%b1%e3%82%8f%e3%81%aa"
  end

end
