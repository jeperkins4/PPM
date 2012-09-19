class EmployeesController < ApplicationController
<<<<<<< HEAD
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end
=======
  before_filter :authenticate
  layout 'administration'
  
  # GET /employees
  # GET /employees.xml  
  def index
    
    @employees = Employee.paginate(:all, :conditions => {:facility_id => session[:facility].id}, :page => params[:page], :per_page => 100)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employees.to_xml }
    end
  end
  
  # GET /employees/1
  # GET /employees/1.xml
  def show
    
    @employee =  session[:facility].employees.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @employee.to_xml }
    end
  end
  
  # GET /employees/new
  def new
    @employee = Employee.new
  end
  
  # GET /employees/1;edit
  def edit
    @employee = Employee.find(params[:id])
  end
  
  # POST /employees
  # POST /employees.xml
  def create
    @employee = Employee.new(params[:employee])
    
    respond_to do |format|
      if @employee.save
        flash[:notice] = 'Employee was successfully created.'
        format.html { redirect_to employee_url(@employee) }
        format.xml  { head :created, :location => employee_url(@employee) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors.to_xml }
      end
    end
  end
  
  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    @employee = Employee.find(params[:id])
    
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        flash[:notice] = 'Employee was successfully updated.'
        format.html { redirect_to employee_url(@employee) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors.to_xml }
      end
    end
  end
  
  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
    
    @employee = session[:facility].employees.find(params[:id])
    @employee.destroy
    
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.xml  { head :ok }
    end
  end
  
  def set_filter
    session[:search_dropdown] = params[:id][:filter_drop] rescue ''
    session[:search_text] = params[:employee][:filter_text] rescue ''
    if session[:search_dropdown].to_s != nil and session[:search_dropdown] != "" then
      session[:test] =  @search = session[:search_dropdown] + " like " + '"' + session[:search_text] + "%%" + '"'
      @employees =  session[:facility].employees.find(:all, :conditions=> ["#{@search}"], :order =>['first_name, last_name'])
      render :action => 'index'
    else
      redirect_to :action => 'index'
    end   
  end  
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
