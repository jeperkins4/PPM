class PppamsReportsController < ApplicationController
  skip_before_filter :set_facility
  before_filter :authenticate

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
      type = params[:pppams_report_filter][:report_type].nil? ? "full" : params[:pppams_report_filter][:report_type].split('.')[0]
      filter = params[:pppams_report_filter]
      base_filter = [filter[:facility_filter], filter[:category_filter], filter[:indicator_filter]]
      good_ids_ar = PppamsReportFilter.good_indicator_ids(base_filter)
      @pppamsIndicators = good_ids_ar[0] << Junk.new
      good_ids = @pppamsIndicators.collect{|i| i.id}
      status_filter = filter[:status_filter]
      @to_date = filter[:end_date] 
      @from_date = filter[:start_date]
      @show_from = filter[:start_date].empty? ? Time.now.beginning_of_month : Time.parse(filter[:start_date]) 
      @show_to = filter[:end_date] .empty? ? Time.now.end_of_month :  Time.parse(filter[:end_date] )  
      months_dif = (@show_to.month + 12 * @show_to.year) - (@show_from.month + 12 * @show_from.year)
      start_with  = @show_from.month
      @show_span = []
      (0..(months_dif)).each do |x|
        @show_span << start_with.to_s
        start_with+=1
        start_with = 1 if start_with > 12
      end
      @show_span.uniq!
      @pppamsReviews = PppamsReportFilter.good_reviews(@from_date, @to_date, status_filter, good_ids)
      @filter_name = filter['name']
      @group_level = good_ids_ar[1]
      render :partial => type, :layout => 'pppams_reports'
    else
      @doneFilters = PppamsReportFilter.find(:all).collect {|p| [ p.name] }
      if params.has_key?('pppams_report_filter') && !params[:pppams_report_filter][:name].empty? 

        if existant = PppamsReportFilter.find(:first, :conditions => ["name = ?", params[:pppams_report_filter][:name]])
            existant.destroy
        end
        if existant = PppamsReportFilter.find(:first, :conditions => ["id = ?", params[:pppams_report_filter][:name]])
            existant.destroy
            flash[:notice] = 'Filter deleted.'
            @facilities =  Facility.find(:all) 
            @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
            return false
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
