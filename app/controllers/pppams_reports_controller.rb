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
      return if process_a_report
    elsif params.has_key?(:pppams_report_filter) && !params[:pppams_report_filter].try(:fetch,:name).blank? 
      save_a_new_filter
    elsif params.has_key?(:pppams_report_filter) && params[:pppams_report_filter].try(:fetch, :name).blank?
      flash[:warning] = 'Please specify a name for the filter.'
    end
    @pppams_report_filter = PppamsReportFilter.find(params[:id]) if params[:id]
    @facilities =  Facility.find(:all) 
    @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
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

    #If user requested a signature report, prepare it then
    #exit if it was an invalid report
    if @filter[:report_type] == 'signature.rhtml'
      return false unless create_signature_report
    end

    #default to 'full' report type if none was selected.
    report_type = @filter[:report_type].blank? ? "full" : @filter[:report_type].split('.')[0]

    #@pppams_indicators = reportable_indicators

    #@good_ids = @pppams_indicators.collect(&:id)

    #status_filter = []
    #@filter[:status_filter].uniq.each { |x|
    #  status_filter << x if x != "" and x != "Submitted" #I.E. Locked
    #  status_filter << "" if x == "Submitted"
    #}
    #@to_date = @filter[:end_date] 
    #@from_date = @filter[:start_date]
    #months_dif = (@show_to.month + 12 * @show_to.year) - (@show_from.month + 12 * @show_from.year)
    #start_with  = @show_from.month
    #@show_span = []
    #(0..(months_dif)).each do |x|
    #  @show_span << (start_with%12).to_s
    #  start_with+=1
    #end
    #@show_span.uniq!
    #@pppams_reviews = PppamsReportFilter.good_reviews(@from_date, @to_date, status_filter, @filter[:score_filter].uniq_numerics, @good_ids)
    #@pppams_reviews_clean = @pppams_reviews[1]
    #@pppams_reviews = @pppams_reviews[0]
    #@filter_name = @filter['name']
    #@group_level = user_indicator_ids_ar[1]
    true
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

  def create_signature_report
    #Make sure we only have one facility.
    @filter[:facility_filter].reject! {|a| a.blank?}
    if @filter[:facility_filter] == [""] || @filter[:facility_filter].try(:size) > 1
       flash[:warning] = 'This report can only be run with a single facility selected.'
       @facilities =  Facility.find(:all) 
       @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
       render(:action => 'filter')
       return false
    end

    @facility = Facility.find(@filter[:facility_filter][0], :select => 'facility, id')
    @show_from = Time.parse(@filter[:start_date]).beginning_of_month
    @show_to   = Time.parse(@filter[:start_date]).end_of_month
    @pppams_groups = PppamsCategoryBaseRef.summary_for_facility_between(@facility.id,
                                                                        @show_from,
                                                                        @show_to)

    @left_side_groups, @right_side_groups = @pppams_groups.split_into(2) {|k,v| k.instance_of? Fixnum}
    render :layout => 'pppams_reports', :action => 'signature' and return true
  end

  def reportable_indicators
    #setup the user-selected indicator filter.
    user_filter = {:facilities => @filter[:facility_filter], 
                   :categories => @filter[:category_filter], 
                   :indicators => @filter[:indicator_filter]
                  }
    
    #make sure we have valid dates
    @show_from = user_filter[:start_date] = @filter[:start_date].blank? ?
      Time.now.beginning_of_month :
      Time.parse(@filter[:start_date])

    @show_to = user_filter[:end_date] = @filter[:end_date].blank? ?
      Time.now.end_of_month :
      Time.parse(@filter[:end_date])

    #find all indicators that match user's filter
    PppamsIndicator.with_report_criteria_matching(user_filter)
  end

end
