class ReportsController < ApplicationController
  
  layout 'administration'
  
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
  
  def export_pdf
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
    if @request.post?
      params[:report][:begin_date] = Date.new(params[:report].delete('begin_date(1i)').to_i, params[:report].delete('begin_date(2i)').to_i, (params[:report].delete('begin_date(3i)')||1).to_i) if params[:report]['begin_date(3i)']
      params[:report][:end_date] = Date.new(params[:report].delete('end_date(1i)').to_i, params[:report].delete('end_date(2i)').to_i, (params[:report].delete('end_date(3i)')||1).to_i) if params[:report]['end_date(3i)']
      @begin = params[:report][:begin_date]
      @end = params[:report][:end_date]
      @incidents = Incident.find(:all, :conditions => ["incident_date >= ? and incident_date <= ?", @begin, @end])     
    end
  end
  
end
