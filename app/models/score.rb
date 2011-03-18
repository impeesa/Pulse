class Score < ActiveRecord::Base
  def self.find_month(date)
    current_year_month = "#{date.year}-#{date.month}"
    all = Score.all
    all.each do |a|
      a_year_month = "#{Date.parse(a.week_id).year}-#{Date.parse(a.week_id).month}"
      return a if a_year_month.eql? current_year_month
    end
    return nil
  end
end
