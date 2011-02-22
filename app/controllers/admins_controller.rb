class AdminsController < ApplicationController
  before_filter :require_admin

  def index
  end

  def save_settings
    Admin.save_settings({ :site_name => params[:site_name], :footer_text => params[:footer_text] })
    redirect_to(admins_path, :notice => "Setting saved.")
  end
end
