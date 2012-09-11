class Summon::RecommendationList < Summon::Schema
  attr :databases, :transform => :DatabaseRecommendation, :single => false, :json_name => "database"
  attr :query_suggestions, :transform => :QuerySuggestionRecommendation, :single => false, :json_name => "querysuggestion"
end

class Summon::DatabaseRecommendation < Summon::Schema
  attr :title
  attr :link
  attr :description
end

class Summon::QuerySuggestionRecommendation < Summon::Schema
  attr :query
  attr :score
end