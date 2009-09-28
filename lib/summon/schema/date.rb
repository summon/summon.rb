
class Summon::Date < Summon::Schema
  attr :day
  attr :month
  attr :text
  attr :year
  
  def day
    @day.to_i if @day
  end
  
  def month
    @month.to_i if @month
  end
  
  def year
    @year.to_i if @year
  end

  def to_s(options = {})
    "Date: #{text}"
  end
end