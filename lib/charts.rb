def remove_all_charts
  Chart.all.each { |c| c.destroy }
end

def create
  Chart.names.each do |name|
    Chart.create :name => name unless Chart.all.map(&:name).include? name
  end
end
