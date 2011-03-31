class NpsController < ApplicationController
  before_filter :check_permission

  def summary
    @comments = Comment.order('created_at DESC').paginate(:page => params[:page] || 1, :per_page => 10)
    @chart = Chart.find_by_name('trend_line')
  end

  def detail
    if current_user.groups.map(&:name).include? "Management"
      @comments = Comment.all(:order => 'weekid desc, created_at desc')
    else 
      flash.now[:error] = "Only Management users have permission to view this page."
    end
  end

  def check_permission
    #render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('NPS')
    render_layout_only unless current_user.can_see_this_tab?('NPS')
  end
end
