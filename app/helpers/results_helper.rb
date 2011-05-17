module ResultsHelper

  def chart_placeholder(name, index=nil)
    charts << name
    if index
      content_tag :div, nil, :id => "#{name}-#{index}", :style => "float:left"
    else
      content_tag :div, nil, :id => name
    end
  end

  # instance variable to be used in application layout which will tell HighCharts which charts to render.
  def charts
    @chart_names ||= []
  end

end
