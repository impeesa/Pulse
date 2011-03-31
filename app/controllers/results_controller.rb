class ResultsController < ApplicationController
  before_filter :check_permission

  def index
    @charts = current_user.charts
  end

  def table
    @results = Result.sections('Sales').items('EQUAL')
    @terms = @results.terms_hash.delete_if { |key, val| !['CMTD', 'CYTD'].include?(key) }
    @classes = @results.classes_hash
    @types = @results.types_hash
  end

  def check_permission
    #render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Results')
    render_layout_only unless current_user.can_see_this_tab?('Results')
  end
end
