require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::Citation do
  it "should map" do
    results = {"Results"=>{"Citations"=>{"Citation"=>[
      {
        "Name"=>"American Medical Association, 10th Edition", 
        "Text"=>"Morrow BH, Price VB. <span class=\"italic\">Anasazi architecture and American design</span>. 1st ed. ed. Albuquerque: University of New Mexico Press; Wed. www.magnolia.com.", 
        "ShortName"=>"AMA"}, 
      {
        "Label"=>"Chicago 15th Edition (Notes & Bibliography)", 
        "Text"=>"Morrow, Baker H. and V. B. Price. Anasazi Architecture and American Design. 1st ed. ed. Albuquerque: University of New Mexico Press, Wed,  (accessed August 5, 2009).", 
        "ShortName"=>"Chicago NB"}, 
      {
        "Label"=>"MLA", 
        "Text"=>"Morrow, Baker H., and V. B. Price. Anasazi Architecture and American Design. 1st ed. ed. Albuquerque: University of New Mexico Press, Wed. .  5 Aug. 2009", 
        "Caption"=>"Modern Language Association, 6th Edition", 
        "ShortName"=>"MLA"}, 
      {
        "Label"=>"Vancouver", 
        "Text"=>"Morrow BH, Price VB. Anasazi architecture and American design. 1st ed. ed. Albuquerque: University of New Mexico Press; Wed.", 
        "ShortName"=>"Vancouver"}
    ]}, "Timing"=>{"ElapsedQueryTime"=>16, "TotalQueryTime"=>14, "TotalExecutionTime"=>1938}}}

    citations = Summon::Citation.parse_results(results)
    citations[0].name.should == "American Medical Association, 10th Edition"
    citations[0].text.should == "Morrow BH, Price VB. <span class=\"italic\">Anasazi architecture and American design</span>. 1st ed. ed. Albuquerque: University of New Mexico Press; Wed. www.magnolia.com."
    citations[0].short_name.should == "AMA"
    
    citations[2].name.should == nil
    citations[2].label.should == "MLA"
    
  end
end
