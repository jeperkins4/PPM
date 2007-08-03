require 'pdf/writer'

class ReportsController < ApplicationController
  before_filter :authenticate 
  layout 'administration', :except => :export_pdf
  
  def index
    @incidents = Incident.find(:all)
    if @request.post?
      params[:report][:begin_date] = Date.new(params[:report].delete('begin_date(1i)').to_i, params[:report].delete('begin_date(2i)').to_i, (params[:report].delete('begin_date(3i)')||1).to_i) if params[:report]['begin_date(3i)']
      params[:report][:end_date] = Date.new(params[:report].delete('end_date(1i)').to_i, params[:report].delete('end_date(2i)').to_i, (params[:report].delete('end_date(3i)')||1).to_i) if params[:report]['end_date(3i)']
      @begin = params[:report][:begin_date]
      @end = params[:report][:end_date]
      @incidents = Incident.find(:all, :conditions => ["incident_date >= ? and incident_date <= ?", @begin, @end])     
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
