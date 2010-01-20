class PppamsReportsController < ApplicationController
  skip_before_filter :set_facility
  before_filter :authenticate

  layout 'administration'
  #require RAILS_ROOT + '/vendor/plugins/calendar_date_select/init.rb'
  require 'orderedhash.rb'
  require RAILS_ROOT + '/vendor/plugins/multiple_select/init.rb'
  
  def index
    filter
    render :action => 'filter'
  end
  
  def filter(use_params = nil)
    @use_params = use_params
    if params.has_key?(:report_request)
      return unless valid_report_type = process_a_report
      render :partial => valid_report_type, :layout => 'pppams_reports'
    elsif params.has_key?(:pppams_report_filter) && !params[:pppams_report_filter].try(:fetch,:name).blank? 
      save_a_new_filter
    elsif params.has_key?(:pppams_report_filter) && params[:pppams_report_filter].try(:fetch, :name).blank?
      flash[:warning] = 'Please specify a name for the filter.'
    end
  end

  def _form
    @pppams_report_filter = PppamsReportFilter.find(params[:id]) if params[:id]
    @facilities =  Facility.find(:all) 
    @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
    render :partial => 'form'
  end

  private

  def last_post_to_xls
    filter session[:last_post]
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="' + report_type.capitalize + ' Report -' + Time.now.to_s + '.xls"'
    render :partial => report_type , :type => 'application/vnd.ms-excel', :layout => false
  end

  def process_a_report
    #If we're submitting an existing set of params
    #(i.e. from the reports_layout's "EXCEL" button)
    #Then use the parameters from the last post.
    @use_params ||= params
    session[:last_post] = @use_params

    @filter = @use_params[:pppams_report_filter]

    if @filter[:report_type] == 'signature.rhtml'
      return false unless prepare_signature_reports
    end

    report_type = @filter[:report_type].nil? ? "full" : @filter[:report_type].split('.')[0]

    base_filter = {:facilities => @filter[:facility_filter], 
                   :categories => @filter[:category_filter], 
                   :indicators => @filter[:indicator_filter]
                  }
    good_ids_ar = PppamsReportFilter.good_indicator_ids(base_filter)
    @pppamsIndicators = good_ids_ar[0] << Junk.new
    @good_ids = @pppamsIndicators.collect{|i| i.id}
    status_filter = []
    @filter[:status_filter].uniq.each { |x|
      status_filter << x if x != "" and x != "Submitted"
      status_filter << "" if x == "Submitted"
    }
    @to_date = @filter[:end_date] 
    @from_date = @filter[:start_date]
    @show_from = @filter[:start_date].empty? ? Time.now.beginning_of_month : Time.parse(@filter[:start_date]) 
    @show_to = @filter[:end_date] .empty? ? Time.now.end_of_month :  Time.parse(@filter[:end_date] )  
    months_dif = (@show_to.month + 12 * @show_to.year) - (@show_from.month + 12 * @show_from.year)
    start_with  = @show_from.month
    @show_span = []
    (0..(months_dif)).each do |x|
      @show_span << start_with.to_s
      start_with+=1
      start_with = 1 if start_with > 12
    end
    @show_span.uniq!
    @pppamsReviews = PppamsReportFilter.good_reviews(@from_date, @to_date, status_filter, @filter[:score_filter].uniq_numerics, @good_ids)
    @pppamsReviews_clean = @pppamsReviews[1]
    @pppamsReviews = @pppamsReviews[0]
    @filter_name = @filter['name']
    @group_level = good_ids_ar[1]
    report_type
  end

  def save_a_new_filter
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
    @facilities =  Facility.find(:all) 
    @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
  end

  def prepare_signature_reports
    #Make sure we only have one facility.
    if @filter[:facility_filter] == [""] || @filter[:facility_filter].try(:size) > 1
       flash[:warning] = 'This report can only be run with a single facility selected.'
       @facilities =  Facility.find(:all) 
       @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
       render(:action => 'filter')
       return false
    end

    #Clear out the score, status & indicator filters,
    #set end date to end of month,
    #Regrieve all of the facility's categories
    @filter[:score_filter] = @filter[:status_filter] = @filter[:indicator_filter] = [""]
    @filter[:end_date] = Time.parse(@filter[:start_date]).end_of_month.to_s
    @filter[:category_filter] = PppamsCategory.find(:all, :conditions => ["facility_id in (#{@filter[:facility_filter]})"]).collect {|p| [ p.pppams_category_base_ref_id] }
  end
end
