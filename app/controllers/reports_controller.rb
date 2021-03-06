class ReportsController < ApplicationController
  before_filter :authenticate 

  expose(:facility) { Facility.find(params[:report][:facility_id]) if params[:report][:facility_id] }
  respond_to :html, :json
  def index
  end

  def inmate
  end

  def generate
    start_day = params[:report]['start_date(1i)'].to_i
    start_month = params[:report]['start_date(2i)'].to_i
    start_year = params[:report]['start_date(3i)'].to_i
    start_date = Date.new(start_day, start_month, start_year)

    end_day = params[:report]['end_date(1i)'].to_i
    end_month = params[:report]['end_date(2i)'].to_i
    end_year = params[:report]['end_date(3i)'].to_i
    end_date = Date.new(end_day, end_month, end_year)

    case params[:report][:name]
    when 'Accountability'
      begin
        @results, @months = Report.accountability(start_date, end_date, {:facility_id => facility.id})
      rescue
        @results, @months = Report.accountability(start_date, end_date) 
      end
      respond_to do |format|
        format.html { render 'accountability' }
        format.json { head :no_content }
      end
    when 'Incident'
      @incidents, @months = Report.incident(params[:report][:status])
      respond_to do |format|
        format.html { render 'incident' }
        format.json { head :no_content }

      end
    end
  end

  def accountability
  end

  def incident
  end

  def export_excel
    @excel = true
    case session[:type].gsub(" ", "_").downcase
    when 'incident'
      build_report_incident(@excel)
    when 'non_comp_issue'
      build_report_non_comp_issue(@excel)
    when 'pppams_issue'
      build_report_pppams_issue(@excel)
    when 'accountability'
      build_report_accountability(@excel)
    end
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="' + session[:type] + ' Report -' + Time.now.to_s + '.xls"'
    render :type => 'application/vnd.ms-excel', :layout => false
  end
  
  def build_report_incident(excel)

    @mins = params[:report][:mins] rescue ''
    @incident_type = params[:report][:incident_type_id] rescue ''
    @search_string = ""

    if session[:use_date] == 'Yes'
      @search_string += "incident_date >= ? and incident_date <= ? "
      @begin = session[:begin_date]
      @end = session[:end_date]
    else
      @search_string += "incident_date <> ? and incident_date <> ? "
      @begin = ''
      @end = ''
    end

    unless @mins == '' or @mins == nil
      @search_string += " and mins = ? "
    else
      @mins = ''
      @search_string += " and mins <> ? "
    end 
    unless @incident_type  == '' or @incident_type == nil
      @search_string += " and incident_type_id = ? "
    else
      @incident_type = ''
      @search_string += " and incident_type_id <> ? "
    end
    
    case session[:status]
    when 'Open'
      @search_string += " and investigation_closed = ? "
      @status = 0
    when 'Closed'
      @search_string += " and investigation_closed = ? "
      @status = 1
    when 'All'
      @search_string += " and (investigation_closed <> ? OR 1 = 1)"
      @status = 42 #All_HACKITY_HACK
    end
    if session[:facility].class.to_s == 'Junk'
    session[:report] = Incident.find :all,
      :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type, @status], 
      :order => 'facility_id, incident_date, mins'
    else
    session[:report] = session[:facility].incidents.find :all,
      :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type, @status], 
      :order => 'incident_date, mins'
    end
    unless excel == true
      redirect_to :action => :report
    end
  end

  def build_report_non_comp_issue(excel)
    
    @id = params[:report][:id] rescue ''
    @search_string = ""
    
    if session[:use_date] == 'Yes'
      @search_string += "created_on >= ? and created_on <= ? "
      @begin = session[:begin_date]
      @end = session[:end_date]
    else
      @search_string += "created_on <> ? and created_on <> ? "
      @begin = ''
      @end = ''
    end
    
    unless @id == '' or @id.nil?
      @search_string += " and issue_number = ? "
    else
      @id = ''
      @search_string += " and (issue_number <> ? OR 1=1) "
    end 
    
    case session[:status]
    when 'Open'
      @search_string += " and nci_status <= ? "
      @status = 3
    when 'Closed'
      @search_string += " and nci_status = ? "
      @status = 4
    when 'All'
      @search_string += " and (nci_status <> ? OR 1=1)"
      @status = 42 # TODO All_HACKITY_HACK
    end
    if session[:facility].class.to_s == 'Junk'
    session[:report] = NonCompIssue.find :all,
      :conditions => ["" + @search_string + "", @begin, @end, @id, @status], 
      :order => 'facility_id, created_on, id'
    else
    session[:report] = session[:facility].non_comp_issues.find :all, 
      :conditions => ["" + @search_string + "", @begin, @end, @id, @status], 
      :order => 'created_on, id'
    end
    unless excel == true
      redirect_to :action => :report
    end
  end

  def build_report_pppams_issue(excel)
    
    @id = params[:report][:id] rescue ''
    @search_string = ""
    
    if session[:use_date] == 'Yes'
      @search_string += "received_date >= ? and received_date <= ? "
      @begin = session[:begin_date]
      @end = session[:end_date]
    else
      @search_string += "received_date <> ? and received_date <> ? "
      @begin = ''
      @end = ''
    end
    
    unless @id == '' or @id.nil?
      @search_string += " and pppams_issue_number = ? "
    else
      @id = ''
      @search_string += " and pppams_issue_number <> ? "
    end 
    
    case session[:status]
    when 'Open'
      @search_string += " and pppams_issue_status <= ? "
      @status = 2
    when 'Closed'
      @search_string += " and pppams_issue_status = ? "
      @status = 3
    when 'All'
      @search_string += " and pppams_issue_status <> ? "
      @status = 42 #All_HACKITY_HACK
    end
    @search_string += " and category = ? "
    if session[:facility].class.to_s == 'Junk'
    session[:report] = PppamsIssue.find :all,
      :conditions => ["" + @search_string + "", @begin, @end, @id, @status], 
      :order => 'facility_id, received_date, id'
    else
    session[:report] = session[:facility].pppams_issues.find :all, 
      :conditions => ["" + @search_string + "", @begin, @end, @id, @status, session[:category] ], 
      :order => 'received_date, id'
    end
    unless excel == true
      redirect_to :action => :report
    end

  end
  
  def build_report_accountability(excel)
    session[:report] = Context.find :all, :order => 'position'
    unless excel == true
      redirect_to :action => :report 
    end
  end
  
  def report
    render :layout => 'reports'
  end
end
