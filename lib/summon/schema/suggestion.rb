class Summon::Suggestion < Summon::Schema
  attr :original_query
  attr :suggested_query
  attr :apply_suggestion_command
end