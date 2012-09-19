class EmployeePositionHistsController < ApplicationController
  
  before_filter :authenticate
  layout 'administration'
  
  # GET /employee_position_hists
  # GET /employee_position_hists.xml
  def index
    @facility_position_numbers = PositionNumber.send(:with_exclusive_scope) do
      session[:facility].position_numbers.sort {|a,b| a.position_num <=> b.position_num}
    end
    @employee_position_hists =  EmployeePositionHist.generic_for_position_numbers(@facility_position_numbers.map(&:id))
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employee_position_hists.to_xml }
    end
  end

  # GET /employee_position_hists/1
  # GET /employee_position_hists/1.xml
  def show
    @employee_position_hist = EmployeePositionHist.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @employee_position_hist.to_xml }
    end
  end

  # GET /employee_position_hists/new
  def new
  end

  # GET /employee_position_hists/1;edit
  def edit
    @employee_position_hist = EmployeePositionHist.find(params[:id])
  end

  # POST /employee_position_hists
  # POST /employee_position_hists.xml
  def create
    
    @employee_position_hist = EmployeePositionHist.new(params[:employee_position_hist])
    @employee_position_hist.salary = @employee_position_hist.position_number ? @employee_position_hist.position_number.position.salary : ""
    respond_to do |format|
      if @employee_position_hist.save
        flash[:notice] = 'EmployeePositionHist was successfully created.'
        format.html { redirect_to employee_position_hists_path}
        format.xml  { head :created, :location => employee_position_hist_url(@employee_position_hist) }
      else             
        format.html{redirect_to :back}
        flash[:notice] =  activerecord_error_list(@employee_position_hist.errors)
      end
    end
  end

  # PUT /employee_position_hists/1
  # PUT /employee_position_hists/1.xml
  def update
    @employee_position_hist = EmployeePositionHist.find(params[:id])

    respond_to do |format|
      if @employee_position_hist.update_attributes(params[:employee_position_hist])
        flash[:notice] = 'EmployeePositionHist was successfully updated.'
        format.html {redirect_to employee_position_hists_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee_position_hist.errors.to_xml }
      end
    end
  end

  # DELETE /employee_position_hists/1
  # DELETE /employee_position_hists/1.xml
  def destroy
    @employee_position_hist = EmployeePositionHist.find(params[:id])
    @employee_position_hist.destroy

    respond_to do |format|
      format.html { redirect_to employee_position_hists_url }
      format.xml  { head :ok }
    end
  end
  
  private 
 
  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li>#{e.humanize unless e == "base"} #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end

end
