require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Search do
  it "maps" do
    search = Summon::Search.new(@service, JSON.parse(<<-JSON))
    {
      "pageCount": 0,
      "didYouMeanSuggestions": [

      ],
      "fullTextCount": 0,
      "queryTime": 124,
      "documents": [],
      "totalRequestTime": 129,
      "elapsedQueryTime": 126,
      "version": "1.0.0",
      "facetFields": [
      ],
      "rangeFacetFields": [

      ],
      "recordCount": 4589937,
      "sessionId": "cfaa4020-1abe-4a9d-ae6e-e433a36c1069",
      "query": {}
    }
JSON
    search.page_count.should == 0
    search.record_count.should == 4589937
    search.query_time.should == 124
    search.session_id.should == "cfaa4020-1abe-4a9d-ae6e-e433a36c1069"
    search.documents.should == []
    search.version.should == "1.0.0"
    search.query.should be_kind_of(Summon::Query)
  end
  
  it "should handle an error case" do
    search = Summon::Search.new(@service, 
      "version" => "1.0.0", 
      "errors" => [
        {
          "suggestion" => {
            "applySuggestionCommand" => "removeTextQuery(foo\:bar) addTextQuery(foo\\\:bar)",
            "suggestedQuery" => "foo\:bar",
            "originalQuery" => "foo:bar"
          },
          "message" => "Unknown search field(s): foo."
        }])
    search.version.should == "1.0.0"
    search.record_count.should == 0
    search.errors.size.should == 1
    search.errors.first.message.should == "Unknown search field(s): foo."
    search.errors.first.suggestion.apply_suggestion_command.should == "removeTextQuery(foo\:bar) addTextQuery(foo\\\:bar)"
    search.errors.first.suggestion.suggested_query.should == "foo\:bar"
    search.errors.first.suggestion.original_query.should == "foo:bar"
  end
  
  it "should be empty w/ no docs" do
    Summon::Search.new(@service, {}).should be_empty
    Summon::Search.new(@service, {"documents" => [{}]}).should_not be_empty
  end
    
end
