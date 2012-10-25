class Summon::RecommendationList < Summon::Schema
  attr :databases, :transform => :DatabaseRecommendation, :single => false, :json_name => "database"
  attr :query_suggestions, :transform => :QuerySuggestionRecommendation, :single => false, :json_name => "querysuggestion"
  attr :best_bets, :transform => :BestBetRecommendation, :single => false, :json_name => "bestBet"
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

class Summon::BestBetRecommendation < Summon::Schema
  attr :icon
  attr :title
  attr :description
  attr :link
end