
class ReportsController < ApplicationController
  before_filter :authenticate 
  layout 'administration'
  
  def index
    session[:report] = nil
    @type = params[:report_type] rescue ''
    @use_date = params[:use_date] rescue ''
    @type_select = "<option>Choose Type</option>,
                    <option>Incident</option>"
    @date_select = "<option>No</option>,
                    <option>Yes</option>"
    if request.post?
      case @type = params[:report_type]
        
      when 'Incident'   
        build_report_incident
      end
    end
  end
  
  def export_excel
    @incidents = session[:report]
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="Incident Report -' + Time.now.to_s + '.xls"'
    render :type => 'application/vnd.ms-excel', :layout => false
  end
  
  def build_report_incident
    @type_select = "<option>Choose Type</option>, <option selected='true'>Incident</option>"

    @use_date = params[:use_date] rescue ''
    @mins = params[:report][:mins] rescue ''
    @incident_type = params[:report][:incident_type_id] rescue ''
    @facility = session[:facility]
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
    
      session[:report] = session[:facility].incidents.find(:all, :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type])
  end
end
