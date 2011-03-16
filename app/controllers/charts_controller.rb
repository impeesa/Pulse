class ChartsController < ApplicationController
  before_filter :check_permission
  before_filter :require_admin, :except => [:index, :show]

  def index
    @charts = Chart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @charts }
    end
  end

  # GET /charts/1
  # GET /charts/1.xml
  def show
    @chart = Chart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chart }
    end
  end

  # GET /charts/new
  # GET /charts/new.xml
  def new
    @chart = Chart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chart }
    end
  end

  # GET /charts/1/edit
  def edit
    @chart = Chart.find(params[:id])
  end

  # POST /charts
  # POST /charts.xml
  def create
    @chart = Chart.new(params[:chart])

    respond_to do |format|
      if @chart.save
        format.html { redirect_to(@chart, :notice => 'Chart was successfully created.') }
        format.xml  { render :xml => @chart, :status => :created, :location => @chart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /charts/1
  # PUT /charts/1.xml
  def update
    @chart = Chart.find(params[:id])
    @chart.groups = [] if params[:chart][:group_ids].blank?

    respond_to do |format|
      if @chart.update_attributes(params[:chart])
        format.html { redirect_to(@chart, :notice => 'Chart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.xml
  def destroy
    @chart = Chart.find(params[:id])
    @chart.destroy

    respond_to do |format|
      format.html { redirect_to(charts_url) }
      format.xml  { head :ok }
    end
  end

  def default_size
    Chart.reset_all_size
    redirect_to charts_path, :notice => "Default size reset."
  end

  def check_permission
    render_layout_only "You don't have permission to view this page" unless current_user.can_see_this_tab?('Administrator')
  end
end
