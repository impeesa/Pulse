module ResultsHelper

  def chart_placeholder(name)
    charts << name
    content_tag :div, nil, :id => name
  end

  # instance variable to be used in application layout which will tell HighCharts which charts to render.
  def charts
    @chart_names ||= []
  end

end
