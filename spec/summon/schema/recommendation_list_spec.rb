require File.dirname(__FILE__) + '/../../spec_helper'

describe Summon::RecommendationList do
  describe "database recommendations" do
    let(:list) {
      Summon::RecommendationList.new nil, {
        "database" => [
          {
            "title" => "World Bank",
            "link" => "http://www.asme.org/pubs/journals/",
            "description" => "Digital library of the American Society of Mechanical Engineers publications."
          },
          {
            "title" => "ASME",
            "link" => "http://www.worldbank.icebox.ingenta.com/jsp/worldbank/home/librarians",
            "description" => "Digital library of the American Society of Mechanical Engineers publications."
          }
        ]
      }
    }

    subject { list.databases }
    its(:length) { should eql 2 }

    describe "entries" do
      context "world bank" do
        subject { list.databases.first }
        its(:title) { should eql "World Bank" }
        its(:link) { should eql "http://www.asme.org/pubs/journals/" }
        its(:description) { should eql "Digital library of the American Society of Mechanical Engineers publications." }
      end
      context "ASME" do
        subject { list.databases.last }
        its(:title) { should eql "ASME" }
        its(:link) { should eql "http://www.worldbank.icebox.ingenta.com/jsp/worldbank/home/librarians" }
        its(:description) { should eql "Digital library of the American Society of Mechanical Engineers publications." }
      end
    end
  end

  describe "query suggestions" do
    let(:list) {
      Summon::RecommendationList.new nil, {
        "querysuggestion" => [
          {"query" => "friendly kids friendly classrooms", "score" => "1.0"},
          {"query" => "friendly persuasion", "score" => "1.0"},
          {"query" => "friendly societies history", "score" => "1.0"},
          {"query" => "friendly nurses", "score" => "1.0"},
          {"query" => "friendly fire", "score" => "1.0"},
          {"query" => "friendly visitors social work", "score" => "1.0"},
          {"query" => "friendly takeover", "score" => "1.0"},
          {"query" => "friendly societies", "score" => "1.0"},
          {"query" => "friendly house", "score" => "1.0"},
          {"query" => "friendly bacteria", "score" => "1.0"}
        ]
      }
    }

    subject { list.query_suggestions }
    its(:length) { should eql 10 }

    describe "entries" do
      it "parses the suggested queries" do
        subject.map { |s| s.query }.should eql [
          "friendly kids friendly classrooms", "friendly persuasion", "friendly societies history",
          "friendly nurses", "friendly fire", "friendly visitors social work", "friendly takeover",
          "friendly societies", "friendly house", "friendly bacteria"
        ]
      end
      it "parses the scores" do
        subject.map { |s| s.score }.uniq.should eql ["1.0"]
      end
    end
  end

  describe "best bet recommendations" do
    let(:list) {
      Summon::RecommendationList.new nil, {
        "bestBet" => [
          {
            "icon" => "Some Icon Link",
            "title" => "Library Hours",
            "description" => "M-F: 9am-10pm, Sat: 10am-10pm, Sun: 10am-6pm",
            "link" => "http://library.dartmouth.edu/libhours/oneDate.php",
          },
          {
            "icon" => "Another Icon Link",
            "title" => "Library Information",
            "description" => "Here are somethings you should know...",
            "link" => "",
          }
        ]
      }
    }

    subject { list.best_bets }
    its(:length) { should eql 2 }

    describe "entries" do
      context "Library Hours" do
        subject { list.best_bets.first }
        its(:icon) { should eql "Some Icon Link"}
        its(:title) { should eql "Library Hours" }
        its(:link) { should eql "http://library.dartmouth.edu/libhours/oneDate.php" }
        its(:description) { should eql "M-F: 9am-10pm, Sat: 10am-10pm, Sun: 10am-6pm" }
      end
      context "Library Information" do
        subject { list.best_bets.last }
        its(:icon) { should eql "Another Icon Link"}
        its(:title) { should eql "Library Information" }
        its(:link) { should eql "" }
        its(:description) { should eql "Here are somethings you should know..." }
      end
    end
  end
end
