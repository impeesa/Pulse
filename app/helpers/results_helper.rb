module ResultsHelper
  def chart_placeholder(name, total=nil)
    charts << name

    if total
      chart_divs = ""
      for index in (0...total)
        chart_divs << content_tag(:div, nil, :id => "#{name}-#{index}", :style => "float:left; padding: 10px; box-shadow: 0 0 5px #BBBBBB; margin: 10px;")
      end
      chart_divs.html_safe
    else
      content_tag :div, nil, :id => name
    end
  end

  # instance variable to be used in application layout which will tell HighCharts which charts to render.
  def charts
    @chart_names ||= []
  end
end
