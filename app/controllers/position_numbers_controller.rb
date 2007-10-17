class PositionNumbersController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  # GET /position_numbers
  # GET /position_numbers.xml
  def index
    
    @position_numbers_filter = session[:facility].position_numbers.find(:all, :order=>'position_num')
    
       
    @position_number_pages, @position_numbers = paginate_collection @position_numbers_filter, :page => params[:page]
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @position_numbers.to_xml }
    end
  end
  
  # GET /position_numbers/1
  # GET /position_numbers/1.xml
  def show
    @position_number = session[:facility].position_numbers.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position_number.to_xml }
    end
  end
  
  # GET /position_numbers/new
  def new
    @position_number = PositionNumber.new
  end
  
  # GET /position_numbers/1;edit
  def edit
    @position_number = PositionNumber.find(params[:id])
    session[:facility] = @position_number.position.facility
  end
  
  # POST /position_numbers
  # POST /position_numbers.xml
  def create
    @position_number = PositionNumber.new(params[:position_number])
    
    respond_to do |format|
      if @position_number.save
        flash[:notice] = 'PositionNumber was successfully created.'
        format.html { redirect_to position_number_url(@position_number) }
        format.xml  { head :created, :location => position_number_url(@position_number) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_number.errors.to_xml }
      end
    end
  end
  
  # PUT /position_numbers/1
  # PUT /position_numbers/1.xml
  def update
    @position_number = PositionNumber.find(params[:id])
    
    respond_to do |format|
      if @position_number.update_attributes(params[:position_number])
        flash[:notice] = 'PositionNumber was successfully updated.'
        format.html { redirect_to position_number_url(@position_number) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_number.errors.to_xml }
      end
    end
  end
  
  # DELETE /position_numbers/1
  # DELETE /position_numbers/1.xml
  def destroy
    
    @position_number = session[:facility].position_numbers.find(params[:id])
    
    @position_number.destroy
    
    respond_to do |format|
      format.html { redirect_to position_numbers_url }
      format.xml  { head :ok }
    end
  end
  
   def set_filter
    session[:search_dropdown] = params[:id][:filter_drop] rescue ''
    session[:search_text] = params[:position_number][:filter_text] rescue ''
    if session[:search_dropdown].to_s != nil and session[:search_dropdown] != "" then
      @search = 'pn.position_id = p.id and ' + session[:search_dropdown] + " like " + '"' + session[:search_text] + "%%" + '"' + 
      ' and p.facility_id = ?'
      @position_numbers_filter =  PositionNumber.find(:all, :select => 'pn.id as id, pn.position_id, pn.position_num, pn.position_type,
       pn.waiver_approval_date, pn.created_on',:from => 'position_numbers pn , positions p',
                  :conditions=> ["#{@search}",session[:facility][:id]],:order=>'pn.position_num')
      @position_number_pages, @position_numbers = paginate_collection @position_numbers_filter, :page => params[:page]
      render :action => 'index'
    else
      redirect_to :action => 'index'
    end   
  end  
end
