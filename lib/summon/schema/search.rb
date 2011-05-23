class Summon::Search < Summon::Schema
  attr :version
  attr :session_id
  attr :page_count
  attr :record_count

  attr :query_time
  attr :total_request_time

  attr :query, :transform => :Query
  attr :recommendations, :transform => :RecommendationList, :json_name => "recommendationLists"
  attr :suggestions, :transform => :Suggestion, :json_name => :didYouMeanSuggestions
  attr :documents, :transform => :Document
  attr :facets, :transform => :Facet, :json_name => "facetFields"
  attr :range_facets, :transform => :RangeFacet, :json_name => "rangeFacetFields"
  
  attr :errors, :transform => :Error  
  
  def empty?
    documents.empty?
  end
  
  def record_count
    @record_count || 0
  end
  
  def query
    @query || Summon::Query.new
  end
  
  def suggestions?
    !@suggestions.empty?
  end          

  def to_s(options = {})
    "<Summon::Search>{records: #{record_count}, pages: #{page_count}, query_time: #{query_time}ms, request_time: #{total_request_time}ms}"
  end
end
