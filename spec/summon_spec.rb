require File.dirname(__FILE__) + '/spec_helper'

describe "Summon Gem Integration Test" do
  it "maps an api request correctly" do
    service = Summon::Service.new(:transport => Summon::Transport::Canned.new)
    search = service.search
    search.should_not be_nil
    search.record_count.should == 553016530
    search.page_count.should == 55301653
    search.total_request_time.should == 380
    search.query_time.should == 360
    search.suggestions.should_not be_nil
    search.suggestions.length.should == 1
    dym = search.suggestions.first
    dym.original_query.should == "louis rmstrong"
    dym.suggested_query.should == "louis armstrong"
    
    documents = search.documents
    documents.should_not be_nil
    documents.length.should == 10
    d = documents[0]
    d.id.should == 'proquest_dll_1839009301'
    d.content_type.should == 'Newspaper Article'
    d.authors.map{|a| a.name}.should == ["Hunter, Lisa"]
    d.open_url.should == "ctx_ver=Z39.88-2004&rfr_id=info:sid/summon.serialssolutions.com&rft_val_fmt=info:ofi/fmt:kevLmtx:journal&rft.genre=article&rft.atitle=OBITUARIES&rft.jtitle=Arizona+Republic&rft.date=2002-03-16&rft.issn=0892-8711&rft.spage=B.5&rft.externalDBID=AREP&rft.externalDocID=1839009301"
    d.fulltext?.should be(false)
    
    
    facets = search.facets
    facets.should_not be_nil
    facets.length.should >= 5
    ctype = facets[2]
    ctype.display_name.should == "Language"
    ctype.combine_mode.should == 'or'
  end
  
  it "should now how to escape values" do
    check_escape("the quick, brown, fox", 'the quick\, brown\, fox')
    Summon.escape(': everything (else) and $1 or {is} it\ ').should == '\: everything \(else\) and \$1 or \{is\} it\\ '
  end
  
  def check_escape(unescaped, escaped)
    Summon.escape(unescaped).should == escaped
    Summon.unescape(escaped).should == unescaped
    Summon.unescape(Summon.escape(unescaped)).should == unescaped
    Summon.escape(Summon.unescape(escaped)).should == escaped
  end
  
  it "should have a default locale" do
    Summon::DEFAULT_LOCALE.should == 'en'
  end
end