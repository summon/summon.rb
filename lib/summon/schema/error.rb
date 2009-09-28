class Summon::Error < Summon::Schema
  attr :suggestion, :transform => :Suggestion
  attr :message
end
