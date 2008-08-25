class ReportsController < ApplicationController
  before_filter :authenticate 
  layout 'administration'
  
  def index
    session[:report] = nil
    session[:type] = 'Choose Type'
    session[:use_date] = 'No'
    session[:status] = 'Open'
    session[:begin_date] = ''
    session[:end_date] = ''
    session[:acct_begin_date] = nil
    session[:acct_end_date] = nil
    
    if request.post?
      (params[:report][:report_type]) ? session[:type] = params[:report][:report_type] : session[:type] = 'Choose Type'
      (params[:report][:use_date]) ? session[:use_date] = params[:report][:use_date] : session[:use_date] = 'No'
      (params[:report][:status]) ? session[:status] = params[:report][:status] : session[:status] = 'Open'
      if session[:use_date] == 'Yes'        
        params[:report][:begin_date] = Date.new(params[:report].delete('begin_date(1i)').to_i, params[:report].delete('begin_date(2i)').to_i, (params[:report].delete('begin_date(3i)')||1).to_i) if params[:report]['begin_date(3i)']
        params[:report][:end_date] = Date.new(params[:report].delete('end_date(1i)').to_i, params[:report].delete('end_date(2i)').to_i, (params[:report].delete('end_date(3i)')||1).to_i) if params[:report]['end_date(3i)'] 
        session[:begin_date] = params[:report][:begin_date]
        session[:end_date] = params[:report][:end_date]
        session[:acct_begin_date] = Date.new(params[:report].delete('acct_begin_date(1i)').to_i, params[:report].delete('acct_begin_date(2i)').to_i) if params[:report]['acct_begin_date(1i)'] 
        session[:acct_end_date] = Date.new(params[:report].delete('acct_end_date(1i)').to_i, params[:report].delete('acct_end_date(2i)').to_i) if params[:report]['acct_end_date(1i)']                  
      
      end
      if params[:report][:ready] == "1"
        @excel = false
        case session[:type].downcase
        when 'incident'   
          build_report_incident(@excel)
        when 'accountability'
          if  session[:acct_begin_date] then
            session[:acct_begin_date] > session[:acct_end_date] ? (flash[:notice] = "Date Range is Invalid"; render :action => 'index' and return) : ""
          end          
          build_report_accountability(@excel)          
        end      
      end
    end
  end
  
  def export_excel
    @excel = true
    case session[:type].downcase
    when 'incident'   
      build_report_incident(@excel)
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
      @search_string += " and mins <> ? "
    end 
    unless @incident_type  == '' or @incident_type == nil
      @search_string += " and incident_type_id = ? "
    else
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
      @search_string += " and investigation_closed <> ? "
      @status = 42 #All_HACKITY_HACK
    end
    
    session[:report] = session[:facility].incidents.find :all, 
      :conditions => ["" + @search_string + "", @begin, @end, @mins, @incident_type, @status], 
      :order => 'incident_date, mins'
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
