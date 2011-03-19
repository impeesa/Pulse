class NpsController < ApplicationController
  before_filter :check_permission

  def index
    @comments = Comment.order('created_at DESC').paginate(:page => params[:page] || 1, :per_page => 10)
    @chart = Chart.find_by_name('trend_line')
  end

  def check_permission
    render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('NPS')
  end
end
