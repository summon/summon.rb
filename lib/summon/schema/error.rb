class Summon::Error < Summon::Schema
  attr :code
  attr :suggestion, :transform => :Suggestion
  attr :message
end
