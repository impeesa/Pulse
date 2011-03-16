class NpsController < ApplicationController
  before_filter :check_permission

  def check_permission
    render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('NPS')
  end
end
