class PppamsReportFiltersController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_report_filters = PppamsReportFilter.paginate :page => params[:page]
  end

  def show
    @pppams_report_filter = PppamsReportFilter.find(params[:id])
  end

  def new
    @pppams_report_filter = PppamsReportFilter.new
  end

  def create
    @pppams_report_filter = PppamsReportFilter.new(params[:pppams_report_filter])
    if @pppams_report_filter.save
      flash[:notice] = 'PppamsReportFilter was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_report_filter = PppamsReportFilter.find(params[:id])
  end

  def update
    @pppams_report_filter = PppamsReportFilter.find(params[:id])
    if @pppams_report_filter.update_attributes(params[:pppams_report_filter])
      flash[:notice] = 'PppamsReportFilter was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_report_filter
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsReportFilter.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
