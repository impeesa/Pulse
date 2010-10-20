module ResultsHelper

  def chart_for(name)
    charts << name
    content_tag :div, nil, :id => name
  end

  def charts
    @chart_names ||= []
  end

end
