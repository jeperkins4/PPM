class PppamsReportsController < ApplicationController
  skip_before_filter :set_facility
  before_filter :admin_authenticate

  layout 'administration'
  require RAILS_ROOT + '/vendor/plugins/calendar_date_select/init.rb'
  require 'orderedhash.rb'
  require RAILS_ROOT + '/vendor/plugins/multiple_select/init.rb'
  
  def index
    filter
    render :action => 'filter'
  end
  
  def filter
    if params.has_key?('commit')
      session[:dbcustom] = params[:pppams_report_filter][:report_type].class
      type = params[:pppams_report_filter][:report_type].nil? ? "full" : params[:pppams_report_filter][:report_type].split('.')[0]
      filter = params[:pppams_report_filter]
      base_filter = [filter[:facility_filter], filter[:category_filter], filter[:indicator_filter]]
      good_ids = PppamsReportFilter.good_indicator_ids(base_filter)
      status_filter = filter[:status_filter]
      @to_date = filter[:end_date] 
      @from_date = filter[:start_date]
      @pppamsReviews = PppamsReportFilter.good_reviews(@from_date, @to_date, status_filter, good_ids[0])

      @filter_name = filter['name']
      @group_level = good_ids[1]
      render :partial => type, :layout => 'pppams_reports'
    else
      @doneFilters = PppamsReportFilter.find(:all).collect {|p| [ p.name] }
      if params.has_key?('pppams_report_filter') && !params[:pppams_report_filter][:name].empty? 
        if existant = PppamsReportFilter.find(:first, :conditions => ["name = ?", params[:pppams_report_filter][:name]])
            existant.destroy
        end
        myfilter = PppamsReportFilter.new(params[:pppams_report_filter])
        if myfilter.save
            flash[:notice] = 'New filter successfully created.'
        else
            flash[:notice] = 'There was a problem saving your filer. Please contact a Systems Administrator.'
        end
      end
      @facilities =  Facility.find(:all) 
      @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
    end
  end

  def _form
    @pppams_report_filter = PppamsReportFilter.find(params[:id]) if params[:id]
    @facilities =  Facility.find(:all) 
    @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
    render :partial => 'form'
  end


  
end
