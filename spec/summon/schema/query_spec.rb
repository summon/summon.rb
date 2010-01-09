require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Query do
  it "maps" do
    raw = JSON.parse(<<-JSON)
    {
      "searchTerms": [1],
      "facetValueGroupFilters": [],
      "queryString": "4",
      "facetValueFilters": [],
      "textQueries": [6],
      "textFilters": [7],
      "rangeFilters": [],
      "facetFields": [8],
      "rangeFacetFields": [9],
      "sort": [
      {
        "fieldName": "PublicationDate",
        "sortOrder": "desc"
      }
    ],
      "params": [11]
    }
    JSON
    
    
    query(raw).with {
      search_terms.should == [1]
      range_filters.should == []
      facet_value_group_filters.should == []
      query_string.should == "4"
      facet_value_filters.should == []
      text_queries.should == [6]
      text_filters.should == [7]
      facet_fields.should == [8]
      sorts.length.should == 1
      sort.field_name.should == "PublicationDate"
      sort.sort_order.should == "desc"
    }
  end
  
  it "should map facet value fields and facet group fields" do
    q = query(
      "searchTerms"=>[], "rangeFilters"=>[], 
      "facetValueGroupFilters"=>[
        {
          "combineMode"=>"or", "tag"=>"3", 
          "values"=>[
            {"value"=>"history", "removeCommand"=>"removeFacetValueGroupFilter(3,history)"}, 
            {"value"=>"uk", "removeCommand"=>"removeFacetValueGroupFilter(3,uk)"}
          ], 
          "removeCommand"=>"removeFacetValueGroupFilter(3)", 
          "fieldName"=>"SubjectTerms"
        }
      ], 
      "facetValueFilters"=>[
        {
          "isNegated"=>false, 
          "value"=>"law", 
          "removeCommand"=>"removeFacetValueFilter(SubjectTerms,law)", 
          "fieldName"=>"SubjectTerms", 
          "negateCommand"=>"negateFacetValueFilter(SubjectTerms,law)"
        }
      ], 
      "queryString"=>"s.fvgf%3A3=SubjectTerms%2Cor%2Chistory%2Cuk&s.ff=SubjectTerms%2Cand%2C1%2C10&s.fvf=SubjectTerms%2Claw%2Cfalse", 
      "facetFields"=>[{
          "pageSize"=>10, "pageNumber"=>1, "combineMode"=>"and", "removeCommand"=>"removeFacetField(SubjectTerms)", "fieldName"=>"SubjectTerms"
      }], 
      "textFilters"=>[], "textQueries"=>[], "sort"=>[], "rangeFacetFields"=>[]
    )
    filter = q.facet_value_filters[0]
    filter.should_not be_negated
    filter.remove_command.should == "removeFacetValueFilter(SubjectTerms,law)"
    filter.field_name.should == "SubjectTerms"
    filter.negate_command.should == "negateFacetValueFilter(SubjectTerms,law)"
    
    group = q.facet_value_group_filters[0]
    group.combine_mode.should == "or"
    group.tag.should == "3"
    group.remove_command.should == "removeFacetValueGroupFilter(3)"
    group.field_name.should == "SubjectTerms"
    
    group.values[0].value.should == "history"
    group.values[0].remove_command.should == "removeFacetValueGroupFilter(3,history)"
  end
  
  it "should be able to deescape a string" do      
    query_hash("").should == {}
    query_hash("s.fq=Author_t%3A%28Linster%2C+Richard+L%29").should == {"s.fq" => "Author_t:(Linster, Richard L)"}
    query_hash("s.fq=Balthazar&s.fq=Author_t%3A%28Linster%2C+Richard+L%29").should == {"s.fq" => ["Balthazar", "Author_t:(Linster, Richard L)"]}
    query_hash("s.fq=Author_t%3A%28Linster%2C+Richard+L%29&s.q=Probability+models+of+recidivism%5C%3A+an+exploration").should == 
      {"s.fq" => "Author_t:(Linster, Richard L)", "s.q" => "Probability models of recidivism\\: an exploration"}
    query_hash("s.tl=&s.q=foo").should == {"s.q" => "foo"}
  end
  
  it "has params" do
    query({
      :params => [
        {
          "key" => "holdingsOnly",
          "value" => "t",
          "removeCommand" => "removeParameter(holdingsOnly)"
        }
      ]
    }).tap do |q|
      q.params.should_not be(nil)
      # what's the deal w/ holdings??? should we delete this test? - jl
      # q.should be_holdings_only_enabled
    end      
  end
  
  it "knows it's own date_min and date_max" do
    query({
      :rangeFilters => [
        {
          "fieldName" => "PublicationDate",
          "range" => {
            "minValue" => "2000",
            "maxValue" => "2008"
          }
        }
      ]
    }).tap do |q|
      q.date_min.should == 2000
      q.date_max.should == 2008
    end
  end
  
  it "doesn't get phased when one of the ranges in unbounded" do
    query({
      :rangeFilters => [
        {
          "fieldName" => "PublicationDate",
          "range" => {
            "minValue" => "*",
            "maxValue" => "2008"
          }
        }
      ]
    }).tap do |q|
      q.date_min.should be_nil
      q.date_max.should == 2008
    end
  end
  
  it "should know about holdings only" do
    query({}).should_not be_holdings_only_enabled
    query(:isHoldingsOnlyEnabled => true).should be_holdings_only_enabled
    query(:isHoldingsOnlyEnabled => false).should_not be_holdings_only_enabled
  end
  
  def query_hash(str)
    query(:queryString => str).to_hash
  end
  
  def query(params)
    Summon::Query.new(@service, params)
  end
  
end

class Object
  alias_method :with, :instance_eval
end
