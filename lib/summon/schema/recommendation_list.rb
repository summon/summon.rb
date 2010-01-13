class Summon::RecommendationList < Summon::Schema
  attr :database

  def description
    @database['description']
  end

  def link
    @database['link']
  end

  def title
    @database['title']
  end
end