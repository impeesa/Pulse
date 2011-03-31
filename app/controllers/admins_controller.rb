class AdminsController < ApplicationController
  before_filter :require_admin#, :check_permission

  def index
    @groups = Group.all
    @tabs = Tab.all
  end

  def save_settings
    Admin.save_settings({ :site_name => params[:site_name], :footer_text => params[:footer_text] })
    redirect_to(admins_path, :notice => "Setting saved.")
  end

  def save_permissions
    GroupTab.save_permissions(params[:permissions][0])
    redirect_to(admins_path, :notice => "Permissions saved.")
  end

  #def check_permission
  #  #render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Administrator')
  #  render_layout_only unless current_user.can_see_this_tab?('Administrator')
  #end
end
