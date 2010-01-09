require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Facet do
  it "should map" do
    facet = Summon::Facet.new(@service, JSON.parse(EXAMPLE_FACET_JSON))
    facet.remove_src
    facet.counts.each {|f| f.remove_src }
    facet.to_yaml.should == EXPECTED_FACET_YAML

    first = facet.counts.first
    first.apply_command.should == "addFacetValueFilter(ContentType_sfacet,Book,false)"
    first.apply_negated_command.should == "addFacetValueFilter(ContentType_sfacet,Book,true)"
    first.remove_command.should == "eatMyShorts()"
  end
  
  describe "translate display name" do
    it "should return the default value" do
      mock(:service, :locale => 'en').tap do |service|
        @facet = Summon::Facet.new(service, JSON.parse(EXAMPLE_FACET_JSON))
        @facet.local_name.should == @facet.display_name
      end
    end
    
    it "should return the Frech locale" do
      mock(:service, :locale => 'fr').tap do |service|
        @facet = Summon::Facet.new(service, JSON.parse(EXAMPLE_FACET_JSON))
      
        @facet.display_name.should == "ContentType"
        @facet.local_name.should == "Type de la Contente"
      end
    end
  end
  
  
  it "should now how to escape values" do
    service = mock(:service, :locale => 'en')
    
    count = Summon::FacetCount.new(service, :value => "the quick, brown, fox")
    count.value.should == "the quick, brown, fox"
    count.escaped_value.should == 'the quick\, brown\, fox'
    
    Summon::FacetCount.new(service, :value => ': everything (else) and $1 or {is} it\ ').escaped_value.should == 
                                     '\: everything \(else\) and \$1 or \{is\} it\\ '
  end
  
  EXAMPLE_FACET_JSON = <<-JSON
  {
    "pageSize": 10,
    "displayName": "ContentType",
    "combineMode": "or",
    "pageNumber": 1,
    "listValuesCommand": "listFacetValues(ContentType_sfacet,or)",
    "hasAppliedValue": false,
    "fieldName": "ContentType_sfacet",
    "hasLimitingValue": true,
    "removeCommand": "removeFacetField(ContentType_sfacet)",
    "removeValueFiltersCommand": "removeFacetValueFilters(ContentType)",
    "counts": [
      {
        "isFurtherLimiting": true,
        "isNegated": false,
        "value": "Book",
        "count": 799602,
        "applyCommand": "addFacetValueFilter(ContentType_sfacet,Book,false)",
        "removeCommand": "eatMyShorts()",
        "applyNegatedCommand": "addFacetValueFilter(ContentType_sfacet,Book,true)",
        "isApplied": false
      },
      {
        "isFurtherLimiting": true,
        "isNegated": false,
        "value": "JournalArticle",
        "count": 49765,
        "applyCommand": "addFacetValueFilter(ContentType_sfacet,JournalArticle,false)",
        "removeCommand": "eatMyShorts()",
        "applyNegatedCommand": "addFacetValueFilter(ContentType_sfacet,JournalArticle,true)",
        "isApplied": false
      },
      {
        "isFurtherLimiting": true,
        "isNegated": false,
        "value": "Journal Article",
        "count": 179002,
        "removeCommand": "eatMyShorts()",
        "applyCommand": "addFacetValueFilter(ContentType_sfacet,Journal Article,false)",
        "applyNegatedCommand": "addFacetValueFilter(ContentType_sfacet,Journal Article,true)",
        "isApplied": false
      }
    ]
  }
  JSON
  
  EXPECTED_FACET_YAML = <<-YAML
--- !ruby/object:Summon::Facet 
combine_mode: or
counts: 
- !ruby/object:Summon::FacetCount 
  applied: false
  apply_command: addFacetValueFilter(ContentType_sfacet,Book,false)
  apply_negated_command: addFacetValueFilter(ContentType_sfacet,Book,true)
  count: 799602
  further_limiting: true
  negated: false
  remove_command: eatMyShorts()
  service: 
  src: 
  value: Book
- !ruby/object:Summon::FacetCount 
  applied: false
  apply_command: addFacetValueFilter(ContentType_sfacet,JournalArticle,false)
  apply_negated_command: addFacetValueFilter(ContentType_sfacet,JournalArticle,true)
  count: 49765
  further_limiting: true
  negated: false
  remove_command: eatMyShorts()
  service: 
  src: 
  value: JournalArticle
- !ruby/object:Summon::FacetCount 
  applied: false
  apply_command: addFacetValueFilter(ContentType_sfacet,Journal Article,false)
  apply_negated_command: addFacetValueFilter(ContentType_sfacet,Journal Article,true)
  count: 179002
  further_limiting: true
  negated: false
  remove_command: eatMyShorts()
  service: 
  src: 
  value: Journal Article
display_name: ContentType
field_name: ContentType_sfacet
page_number: 1
page_size: 10
remove_command: removeFacetField(ContentType_sfacet)
remove_value_filters_command: removeFacetValueFilters(ContentType)
service: 
src: 
  YAML
end
