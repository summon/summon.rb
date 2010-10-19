require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Document do
  it "should map LibGuideTab" do
    doc = Summon::Document.new(@service, JSON.parse(EXAMPLE_LIBGUIDE_DOCUMENT_JSON))
    doc.lib_guide_tabs.size.should == 10
    doc.lib_guide_tabs[0].tap do |tab|
      tab.name.should == "Find Articles"
      tab.uri.should == "http://libguides.usc.edu/content.php?pid=52179&sid=382704"
    end
    doc.lib_guide_tabs[9].tap do |tab|
      tab.name.should == "Find Books"
      tab.uri.should == "http://libguides.usc.edu/content.php?pid=52179&sid=382703"
    end
  end
  
  it "should map an empty LibGuideTab to an empty array" do
    doc = Summon::Document.new(@service, JSON.parse(EXAMPLE_WITHOUT_LIBGUIDE_DOCUMENT_JSON))
    doc.lib_guide_tabs.should be_empty
  end

  EXAMPLE_LIBGUIDE_DOCUMENT_JSON = <<-LIBGUIDE_JSON
{
  "hasFullText": false,
  "inHoldings": true,
  "openUrl": "ctx_ver=Z39.88-2004&ctx_enc=info%3Aofi%2Fenc%3AUTF-8&rfr_id=info:sid/summon.serialssolutions.com&rft_val_fmt=info:ofi/fmt:kev:mtx:dc&rft.title=LibGuides.+Music+.+Home&rft.creator=Stephanie+Bonjack&rft.date=2010-10-13&rft.pub=University+of+Southern+California+Libraries&rft.externalDBID=5VO&rft.externalDocID=libguides_usc_edu_music",
  "URI": ["http://libguides.usc.edu/music"],
  "Author": ["Stephanie Bonjack"],
  "IsScholarly": ["false"],
  "Copyright": ["Copyright University of Southern California 2010"],
  "DBID": ["5VO"],
  "ID": ["usc_libguide_libguides_usc_edu_music"],
  "PublicationDate": ["2010-10-13"],
  "PublicationDate_xml": [{
      "day": "13",
      "month": "10",
      "text": "2010-10-13",
      "year": "2010"
  }],
  "PublicationCentury": ["2000"],
  "LibGuideTab_xml": [{
      "name": "Find Articles",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382704"
  },
  {
      "name": "Find Scores",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382709"
  },
  {
      "name": "Find Historic Materials",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382708"
  },
  {
      "name": "Getting Started",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=478038"
  },
  {
      "name": "Find Dissertations",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382706"
  },
  {
      "name": "Check This Out!",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=473799"
  },
  {
      "name": "Home",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382702"
  },
  {
      "name": "Find Videos",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=385139"
  },
  {
      "name": "Find Sound Recordings",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382705"
  },
  {
      "name": "Find Books",
      "uri": "http://libguides.usc.edu/content.php?pid=52179&sid=382703"
  }],
  "Copyright_xml": [{
      "notice": "Copyright University of Southern California 2010"
  }],
  "Publisher": ["University of Southern California Libraries"],
  "PublicationDecade": ["2010"],
  "Publisher_xml": [{
      "name": "University of Southern California Libraries"
  }],
  "Snippet": ["Library Resources in the Field of Music"],
  "Abstract": ["Library Resources in the Field of Music"],
  "SubjectTerms": ["core subject guides"],
  "Author_xml": [{
      "fullname": "Stephanie Bonjack"
  }],
  "ContentType": ["Research Guide"],
  "Title": ["LibGuides. Music . Home"],
  "thumbnail_m": ["http://api.test.summon.serialssolutions.com:8093/image/custom?url=http%3A%2F%2Flibguides.usc.edu%2Fdata%2Fprofiles%2F6369%2FDixie.jpg"],
  "url": ["http://libguides.usc.edu/music"]
}
LIBGUIDE_JSON

  EXAMPLE_WITHOUT_LIBGUIDE_DOCUMENT_JSON = <<-WITHOUT_LIBGUIDE_JSON
{
  "hasFullText": false,
  "inHoldings": true,
  "openUrl": "ctx_ver=Z39.88-2004&ctx_enc=info%3Aofi%2Fenc%3AUTF-8&rfr_id=info:sid/summon.serialssolutions.com&rft_val_fmt=info:ofi/fmt:kev:mtx:dc&rft.title=LibGuides.+Music+.+Home&rft.creator=Stephanie+Bonjack&rft.date=2010-10-13&rft.pub=University+of+Southern+California+Libraries&rft.externalDBID=5VO&rft.externalDocID=libguides_usc_edu_music",
  "URI": ["http://libguides.usc.edu/music"],
  "Author": ["Stephanie Bonjack"],
  "IsScholarly": ["false"],
  "Copyright": ["Copyright University of Southern California 2010"],
  "DBID": ["5VO"],
  "ID": ["usc_libguide_libguides_usc_edu_music"],
  "PublicationDate": ["2010-10-13"],
  "PublicationDate_xml": [{
      "day": "13",
      "month": "10",
      "text": "2010-10-13",
      "year": "2010"
  }],
  "PublicationCentury": ["2000"],
  "Copyright_xml": [{
      "notice": "Copyright University of Southern California 2010"
  }],
  "Publisher": ["University of Southern California Libraries"],
  "PublicationDecade": ["2010"],
  "Publisher_xml": [{
      "name": "University of Southern California Libraries"
  }],
  "Snippet": ["Library Resources in the Field of Music"],
  "Abstract": ["Library Resources in the Field of Music"],
  "SubjectTerms": ["core subject guides"],
  "Author_xml": [{
      "fullname": "Stephanie Bonjack"
  }],
  "ContentType": ["Research Guide"],
  "Title": ["LibGuides. Music . Home"],
  "thumbnail_m": ["http://api.test.summon.serialssolutions.com:8093/image/custom?url=http%3A%2F%2Flibguides.usc.edu%2Fdata%2Fprofiles%2F6369%2FDixie.jpg"],
  "url": ["http://libguides.usc.edu/music"]
}
WITHOUT_LIBGUIDE_JSON

end
