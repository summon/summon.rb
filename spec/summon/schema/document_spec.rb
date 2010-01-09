require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Document do
  it "should map" do
    doc = Summon::Document.new(@service, JSON.parse(EXAMPLE_DOCUMENT_JSON))
    doc.remove_src
    doc.publication_date.remove_src
    doc.authors.each {|a| a.remove_src }
    doc.to_yaml.should == EXPECTED_DOCUMENT_YAML
  end
    
  EXAMPLE_DOCUMENT_JSON = <<-JSON
{
  "Publisher_xml": [
    {
      "name": "Spirulina Records"
    },
    {
      "name": "Swingsistersound"
    }
  ],
  "Abstract": ["This is the most awesome document ever"],
  "DOI": [ "10.1109\/CBMS.2008.1"],
  "ISSN": ["1063-7125", "0000-1111"],
  "Issue": ["7"],
  "PublicationTitle": ["Batman Books"],
  "StartPage": ["pp23"],
  "SubjectTerms": [
    "Women's music",
    "Popular music",
    "Rock music"
  ],
  "EndPage": ["i"],
  "TableOfContents": [
    "The very thing -- Dark night -- 2 truths & uh lie -- Reckless -- Spin -- Free -- Real of you -- Fire -- Purple hair -- Ghost -- Nuthin' -- Faith."
  ],
  "XQueryRevision": [
    "Rev: 6229"
  ],
  "inHoldings": false,
  "DBID": [
    "GXQ"
  ],
  "Notes": [
    "Compact disc."
  ],
  "PublicationDateYear": [
    "2000"
  ],
  "hasFullText": false,
  "timestamp": [
    "Thu Jul 09 19:44:12 EDT 2009"
  ],
  "Author": [
    "Hunter, Lisa"
  ],
  "CorporateAuthor": [
    "Hunter, Rick",
    "Crusher, Beverly"
  ],
  "PublicationDate": [
    "c2000."
  ],
  "Subtitle": [
    "the life and death of Joey Stefano"
  ],
  "Title": [
    "Lisa Hunter -- alive"
  ],
  "ID": [
    "gvsu_catalog_b16644323"
  ],
  "LCCallNum": [
    "M1630.18 .H95 2000",
    "M1630.20 .H95 2000"
  ],
  "GovDocClassNum": [
    "A 57.38/42:M 45",
    "A 57.38/42:M 45"
  ],
  "Language": [
    "English"
  ],
  "PublicationDateCentury": [
    "2000"
  ],
  "PublicationDateDecade": [
    "2000"
  ],
  "openUrl": "ctx_ver=Z39.88-2004&rfr_id=info:sid\/summon.serialssolutions.com&rft_val_fmt=info:ofi\/fmt:kev:mtx:dc&rft.title=Lisa+Hunter+--+alive&rft.creator=Hunter%2C+Lisa&rft.date=c200-0.&rft.pub=Spirulina+Records&rft.externalDBID=n%2Fa&rft.externalDocID=b16644323",
  "Author_xml": [
    {
      "fullname": "Hunter, Lisa",
      "surname": "Hunter",
      "givenname": "Lisa"
    }
  ],
  "Library": [
    "Women's Center Library"
  ],
  "PublicationDate_xml": [
    {
      "month": "01",
      "text": "c2000.",
      "day": "02",
      "year": "2000"
    }
  ],
  "PublicationPlace": [
    "S.l.",
    "Ann Arbor, Mich"
  ],
  "TemporalSubjectTerms": [
    "1991-2000"
  ],
  "PublicationPlace_xml": [
    {
      "name": "S.l."
    },
    {
      "name": "Ann Arbor, Mich"
    }
  ],
  "DocumentTitleAlternate": [
    "Alive"
  ],
  "score": [
    "1.0"
  ],
  "Snippet": [
    "This is the snippet"
  ],
  "availabilityId": "b16644323",
  "ContentType": [
    "Audio Recording"
  ],
  "Publisher": [
    "Spirulina Records",
    "Swingsistersound"
  ],
  "PageCount": [
    "xxviii, 140 p."
  ],
  "Genre": [
    "Biography",
    "Congress"
  ],
  "ISBN": [
    "0849343763 (v. 1)",
    "0849343771 (v. 2)"
  ],
  "PublicationSeriesTitle": [
    "A Bantam book"
  ],
  "DissertationAdvisor": [
    "Claudio Friedmann"
  ],
  "DissertationCategory": [
    "Education"
  ],
  "DissertationDegree": [
    "M.S.J."
  ],
  "DissertationDegreeDate": [
    "2001"
  ],
  "DissertationDegreeDateCentury": [
    "2000"
  ],
  "DissertationDegreeDateDecade":[
    "2000"
  ],
  "DissertationDegreeDateYear": [
    "2001"
  ],
  "DissertationSchool": [
    "West Virginia University"
  ],
  "thumbnail_s": [
    "http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/small"
  ],
  "thumbnail_l": [
    "http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/large"
  ],
  "thumbnail_m": [
    "http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/medium"
  ]
}
  JSON
  
  EXPECTED_DOCUMENT_YAML = <<-YAML
--- !ruby/object:Summon::Document 
abstract: This is the most awesome document ever
authors: 
- Hunter, Lisa
availability_id: b16644323
call_numbers: 
- M1630.18 .H95 2000
- M1630.20 .H95 2000
content_type: Audio Recording
corporate_authors: 
- Hunter, Rick
- Crusher, Beverly
dissertation_advisor: Claudio Friedmann
dissertation_category: Education
dissertation_degree: M.S.J.
dissertation_degree_date: "2001"
dissertation_degree_date_century: "2000"
dissertation_degree_date_decade: "2000"
dissertation_degree_date_year: "2001"
dissertation_school: West Virginia University
doi: 10.1109\/CBMS.2008.1
end_page: i
fulltext: false
genres: 
- Biography
- Congress
gov_doc_class_nums: 
- A 57.38/42:M 45
- A 57.38/42:M 45
id: gvsu_catalog_b16644323
isbns: 
- 0849343763 (v. 1)
- 0849343771 (v. 2)
issns: 
- 1063-7125
- 0000-1111
issue: "7"
languages: 
- English
library: Women's Center Library
open_url: ctx_ver=Z39.88-2004&rfr_id=info:sid/summon.serialssolutions.com&rft_val_fmt=info:ofi/fmt:kev:mtx:dc&rft.title=Lisa+Hunter+--+alive&rft.creator=Hunter%2C+Lisa&rft.date=c200-0.&rft.pub=Spirulina+Records&rft.externalDBID=n%2Fa&rft.externalDocID=b16644323
page_count: xxviii, 140 p.
patent_number: 
publication_date: !ruby/object:Summon::Date 
  day: "02"
  month: "01"
  service: 
  src: 
  text: c2000.
  year: "2000"
publication_series_title: A Bantam book
publication_title: Batman Books
publishers: 
- Spirulina Records
- Swingsistersound
service: 
snippet: This is the snippet
src: 
start_page: pp23
subject_terms: 
- Women's music
- Popular music
- Rock music
subtitle: the life and death of Joey Stefano
thumbnail_large: http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/large
thumbnail_medium: http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/medium
thumbnail_small: http://api.test.summon.serialssolutions.com:8093/image/isbn/YX3FL6LB6P/9781864879094/small
title: Lisa Hunter -- alive
url: 
volume: 
  YAML
end
