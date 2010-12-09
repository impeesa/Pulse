class ChartGroup < ActiveRecord::Base

  belongs_to :chart
  belongs_to :group

end
