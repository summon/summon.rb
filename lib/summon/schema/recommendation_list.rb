class Summon::RecommendationList < Summon::Schema
  attr :databases, :transform => :DatabaseRecommendation, :single => false, :json_name => "database"
end

class Summon::DatabaseRecommendation < Summon::Schema
  attr :title
  attr :link
  attr :description
end