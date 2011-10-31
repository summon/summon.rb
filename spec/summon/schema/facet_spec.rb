require 'spec_helper'

describe Summon::Facet do
  before {@facet = Summon::Facet.new(@service, JSON.parse(EXAMPLE_FACET_JSON))}
  subject {@facet}

  its(:page_size) {should eql 10}
  its(:display_name) {should eql "ContentType"}
  its(:combine_mode) {should eql "or"}
  its(:list_values_command) {should eql "listFacetValues(ContentType_sfacet,or)"}
  it {should_not have_applied_value}
  its(:field_name) {should eql "ContentType_sfacet"}
  it {should have_limiting_value}
  its(:remove_command) {should eql "removeFacetField(ContentType_sfacet)"}

  describe "Summon::FacetCount" do
    subject {@facet.counts.first}
    it {should be_further_limiting}
    it {should be_negated}
    its(:value) {should eql "Book"}
    its(:count) {should eql 799602}
    its(:apply_command) {should eql "addFacetValueFilter(ContentType_sfacet,Book,false)"}
    its(:remove_command) {should eql "eatMyShorts()"}
    its(:apply_negated_command) {should eql "addFacetValueFilter(ContentType_sfacet,Book,true)"}
    it {should be_applied}
  end

  it "should now how to escape values" do
    service = mock(:service)

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
        "isNegated": true,
        "value": "Book",
        "count": 799602,
        "applyCommand": "addFacetValueFilter(ContentType_sfacet,Book,false)",
        "removeCommand": "eatMyShorts()",
        "applyNegatedCommand": "addFacetValueFilter(ContentType_sfacet,Book,true)",
        "isApplied": true
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

end
