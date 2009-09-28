require File.dirname(__FILE__) + '/../spec/spec_helper'
require 'cgi'
require 'summon/cli'

describe "summon" do
  attr_reader :summon
  
  before :all do 
    @config = Summon::CLI::Config.load
    @summon = Summon::Service.new(@config.options)
  end

  describe "search" do
    it "should do an empty query" do
      search = summon.search
    
      search.record_count.should > 0
      search.should_not be_empty
    end

    it "should do a text query" do
      search = summon.search "s.q" => "Probability models of recidivism\\\\\\: an exploration"
      search.should_not be_empty
      query(search).should == "s.q=Probability models of recidivism\\\\\\: an exploration"
    end
  
    it "should do one command" do
      search = summon.search "s.cmd" => "addTextFilter(Author\\:\\(Linster\\, Richard L\\))"    
      query(search).should == "s.fq=Author:(Linster, Richard L)"
      search.should_not be_empty
    end
  
    it "should do an interesting search by pieces" do
      text_query = "Probability models of recidivism\\: an exploration"
      command = "addTextFilter(Author_t\\:\\(Linster\\, Richard L\\))"
    
      search = summon.search "s.q" => text_query, "s.cmd" => command
    
      query(search).should == "s.fq=Author:(Linster, Richard L)&" +
                              "s.q=Probability models of recidivism\\: an exploration"
    end
    
    it "should modify a search" do
      search = summon.search "s.q" => "Probability models of recidivism\\: an exploration"
      search = summon.modify_search search, "addTextFilter(Author\\:\\(Linster\\, Richard L\\))"
      
      query(search).should == "s.fq=Author:(Linster, Richard L)&" +
                              "s.q=Probability models of recidivism\\: an exploration"
    end
  end
    
  def find(list, search_by, value)
    item = list.find{|i| i.send(search_by) == value}
    item.should_not be_nil
    item
  end
  
  def query(search)
    CGI::unescape(search.query.query_string)
  end
end