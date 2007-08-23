require 'pdf/writer'

class ReportsController < ApplicationController
  before_filter :authenticate 
  layout 'administration', :except => :export_pdf
  
  def index
    @type = params[:report_type] rescue ''
    @type_select = "<option>Choose Type</option>,
                    <option>Incident</option>,
                    <option>Inmate Count</option>"
    if @request.post?
      params[:report][:begin_date] = Date.new(params[:report].delete('begin_date(1i)').to_i, params[:report].delete('begin_date(2i)').to_i, (params[:report].delete('begin_date(3i)')||1).to_i) if params[:report]['begin_date(3i)']
      params[:report][:end_date] = Date.new(params[:report].delete('end_date(1i)').to_i, params[:report].delete('end_date(2i)').to_i, (params[:report].delete('end_date(3i)')||1).to_i) if params[:report]['end_date(3i)']
      @use_date = params[:use_date] rescue 0
      @begin = params[:report][:begin_date]
      @end = params[:report][:end_date]
      @mins = params[:report][:mins] rescue ''
      @incident_type = params[:report][:incident_type_id] rescue ''
      @search_string = ""
      
      if @use_date == 1
        @search_string += " incident_date >= ? and incident_date <= ? "
      else
        @search_string += " incident_date <> ? and incident_date <> ? "
        @begin = ''
        @end = ''
      end
      unless @mins == "" or @mins == nil
        @search_string += " and mins = ? "
      else
        @search_string += " or mins <> ? "
      end 
      unless @incident_type  == "" or @incident_type == nil
        @search_string += " and incident_type_id = ? "
      else
        @search_string += " or incident_type_id <> ? "
      end
      
      case @type = params[:report_type]
        
      when 'Incident'
        @type_select = "<option>Choose Type</option>, <option selected='true'>Incident</option>, <option>Inmate Count</option>"
        if session[:access_level] == 'Administrator'
          @incidents = Incident.find(:all, :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type])
        else
          @incidents = session[:facility].incidents.find(:all, :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type])
        end
        
      when 'Inmate Count'
        @type_select = "<option>Choose Type</option>, <option>Incident</option>, <option selected='true'>Inmate Count</option>"
      end
      
    end
  end
  
  def export_excel
    @incidents = Incident.find(:all)
    @response.headers['CONTENT-TYPE'] = 'application/vnd.ms-excel'
    @response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="Incident Report -' + Time.now.to_s + '.xls"'
    render :type => 'application/vnd.ms-excel', :layout => false
  end
  
  def pdf
    @response.headers['CONTENT-TYPE'] = 'application/pdf'
    @response.headers['CONTENT-DISPOSITION'] = 'attachment; filename="Incident Report -' + Time.now.to_s + '.pdf"'
    render :type => 'application/pdf', :layout => false  
  end
  
  def export_pdf
    @incidents = Incident.find(:all)
    pdf = PDF::Writer.new
    pdf.select_font "Times-Roman"
    pdf.text((render '/reports/export_excel'), :justification => :left)
    send_data pdf.render, :filename => "Incident Report -" + Time.now.to_s + ".pdf",
    :type => "application/pdf"
  end
end
