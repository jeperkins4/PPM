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

  def filter(use_params = nil, excel = false)
    @excel = excel
    @use_params = use_params || params
    if @use_params.has_key?(:report_request)
      return if process_a_report
    elsif @use_params.has_key?(:pppams_report_filter) && !@use_params[:pppams_report_filter].try(:fetch,:name).blank? 
      save_a_new_filter
    elsif @use_params.has_key?(:pppams_report_filter) && @use_params[:pppams_report_filter].try(:fetch, :name).blank?
      flash[:warning] = 'Please specify a name for the filter.'
    end
    @pppams_report_filter = PppamsReportFilter.find(params[:id]) if params[:id]
    @facilities =  Facility.find(:all) 
    @Cats = PppamsCategoryBaseRef.find(:all, :order => :name)
  end


  def last_post_to_xls
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    report_type = session[:last_post].try(:fetch, :pppams_report_filter).try(:fetch, :report_type) || 'full'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="' + report_type.humanize.titleize + ' Report -' + Time.now.to_s + '.xls"'
    filter(session[:last_post], true) and return
  end

  private

  def process_a_report

    session[:last_post] = @use_params

    @filter = @use_params[:pppams_report_filter]

    report_type = @filter[:report_type] || 'full'
    if %w{signature summary_average summary_percent full}.include?(report_type)
      return false unless send("create_#{report_type}_report")
    end

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
    if @filter[:facility_filter].empty? || @filter[:facility_filter].try(:size) > 1
       flash[:warning] = 'This report can only be run with a single facility selected.'
       return false
    end

    @facility = Facility.find(@filter[:facility_filter][0], :select => 'facility, id')
    
    # 'true' below ignores the end date. 
    assign_to_from_dates(true)
    @pppams_groups = PppamsCategoryBaseRef.signature_summary_for_facility(@facility.id,
                                                                        @show_from,
                                                                        @show_to)

    @left_side_groups, @right_side_groups = @pppams_groups.split_into(2) {|k,v| k.instance_of? Fixnum}
    render :layout => 'pppams_reports', :action => 'signature' and return true
  end

  def create_summary_average_report
    setup_summary_report
    @data = PppamsCategoryBaseRef.indicator_summary_between(@show_from, @show_to, summary_query_options)
    if @excel 
      render :layout => 'pppams_reports', :action => 'summary_average', :type => 'application/vnd.ms-excel', :layout => false
    else
      render :layout => 'pppams_reports', :action => 'summary_average'
    end
  end
  def create_summary_percent_report
    setup_summary_report
    @data = PppamsCategoryBaseRef.indicator_summary_between(@show_from, @show_to, summary_query_options)
    if @excel 
      render :layout => 'pppams_reports', :action => 'summary_percent', :type => 'application/vnd.ms-excel', :layout => false
    else
      render :layout => 'pppams_reports', :action => 'summary_percent'
    end
  end
  def create_full_report
    setup_summary_report
    @data = PppamsCategoryBaseRef.review_summary(@show_from, @show_to, summary_query_options)
    if @excel 
      render :layout => 'pppams_reports', :action => 'full', :type => 'application/vnd.ms-excel', :layout => false
    else
      render :layout => 'pppams_reports', :action => 'full'
    end
  end


  private

  def setup_summary_report
    assign_to_from_dates
    @filter = @filter.remove_blanks_in_arrays
    @filter_name = @filter[:name]
    assign_grouping_type
    assign_facilities
  end

  def assign_to_from_dates(start_date_only = false)
    #make sure we have valid dates
    @show_from = @filter[:start_date].blank? ?
      Time.now.beginning_of_month :
      Time.parse(@filter[:start_date])

    if start_date_only
      @show_to = @show_from.end_of_month
    else
      @show_to = @filter[:end_date].blank? ?
        Time.now.end_of_month :
        Time.parse(@filter[:end_date])
    end
  end

  def assign_grouping_type
    if !@filter[:indicator_filter].blank?
      @grouping_type = 'indicator_grouping'
    elsif !@filter[:category_filter].blank?
      @grouping_type = 'category_grouping'
    else
      @grouping_type = 'facility_grouping'
    end
  end

  def assign_facilities
    if @filter[:facility_filter].blank?
      @filter[:facility_filter] = Facility.all(:select => [:id]).map(&:id)
    end
  end
  def summary_query_options
    {
     :facility_ids => @filter[:facility_filter],
     :pppams_category_base_ref_ids => @filter[:category_filter],
     :pppams_indicator_base_ref_ids => @filter[:indicator_filter],
     :score_values => @filter[:score_filter],
     :status_values => @filter[:status_filter]
    }
  end
end
