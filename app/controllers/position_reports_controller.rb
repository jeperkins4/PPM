class PositionReportsController < ApplicationController
    layout 'administration'  
  def index
    @position_report = EmployeePositionHist.find(:all)
  end
  
    
  def build_report_incident
    @type_select = "<option>Choose Type</option>, <option selected='true'>Incident</option>, <option>Inmate Count</option>"

    @use_date = params[:use_date] rescue ''
    @mins = params[:report][:mins] rescue ''
    @incident_type = params[:report][:incident_type_id] rescue ''
    @facility = params[:report][:facility_id] rescue ''
    @search_string = ""
    
    unless @facility == ''
      @search_facility = " facility_id = ? and"
    else
      @search_facility = " facility_id <> ? and"
    end
    
    if @use_date == 'Yes'
      @search_string += "incident_date >= ? and incident_date <= ? "
      @date_select = "<option selected=true>Yes</option>, <option>No</option>"
      params[:report][:begin_date] = Date.new(params[:report].delete('begin_date(1i)').to_i, params[:report].delete('begin_date(2i)').to_i, (params[:report].delete('begin_date(3i)')||1).to_i) if params[:report]['begin_date(3i)']
      params[:report][:end_date] = Date.new(params[:report].delete('end_date(1i)').to_i, params[:report].delete('end_date(2i)').to_i, (params[:report].delete('end_date(3i)')||1).to_i) if params[:report]['end_date(3i)'] 
      @begin = params[:report][:begin_date]
      @end = params[:report][:end_date]
    else
      @search_string += "incident_date <> ? and incident_date <> ? "
      @date_select = "<option>Yes</option>, <option selected=true>No</option>"
      @begin = ''
      @end = ''
    end
    
    unless @mins == '' or @mins == nil
      @search_string += " and mins = ? "
    else
      @search_string += " and mins <> ? "
    end 
    unless @incident_type  == '' or @incident_type == nil
      @search_string += " and incident_type_id = ? "
    else
      @search_string += " and incident_type_id <> ? "
    end
    
    if session[:access_level] == 'Administrator'
      session[:report] = Incident.find(:all, :conditions => [ "" + @search_facility + " " + @search_string + "", @facility, @begin, @end, @mins, @incident_type])
    else
      session[:report] = session[:facility].incidents.find(:all, :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type])
    end
  end
  
  def build_report_inmate_counts  
    
    @type_select = "<option>Choose Type</option>, <option>Incident</option>, <option selected='true'>Inmate Count</option>"
    if session[:access_level] == 'Administrator'
      session[:report] = InmateCount.find(:all, :conditions => [ "" + @search_facility + " " + @search_string + "", @facility])
    else
      session[:report] = session[:facility].inmate_counts.find(:all, :conditions => ["" + @search_string + "", @begin, @end])
    end
  end
end
