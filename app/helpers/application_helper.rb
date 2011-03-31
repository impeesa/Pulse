module ApplicationHelper
  def top_tab(tab_uri, display_name)
    html = ""
    return unless (signed_in?) 
    return if !current_user.can_see_this_tab?(display_name)

    if (tab_uri == request.fullpath.split('?')[0]) or (tab_uri == results_path and request.fullpath == "/") # or (tab_uri == '/' + request.fullpath.split('/')[1])
      html = "<li class='active'><a href='#{tab_uri}'>#{display_name}</a>"
    else
      html = "<li><a href='#{tab_uri}'>#{display_name}</a>"
    end
      
    if display_name == "Administrator"
      html = "<li><a href='#{tab_uri}'>#{display_name}</a>"
      html << "<ul>"
      html << sub_tab(groups_path, "Groups")
      html << sub_tab(users_path, "Users")
      html << sub_tab(charts_path, "Charts")
      html << sub_tab(admins_path, "General")
      html << "</ul>"
    end

    html << "</li>"
    html
  end

  def sub_tab(tab_uri, display_name)
    html = ""

    if tab_uri == request.fullpath
      html = "<li class='no-radius active'><a href='#{tab_uri}'>#{display_name}</a></li>"
    else
      html = "<li class='no-radius'><a href='#{tab_uri}'>#{display_name}</a></li>"
    end

    html
  end
end
