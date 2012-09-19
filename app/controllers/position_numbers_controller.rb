<<<<<<< HEAD
class PositionNumbersController < ApplicationController
  expose(:position_numbers) { PositionNumber.all.order(:position_num) }
  expose(:position_number)

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: PositionNumbersDatatable.new(view_context) }
    end
  end

  def show
    @position_number = PositionNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_number }
    end
  end

  # GET /position_numbers/new
  # GET /position_numbers/new.json
  def new
    @position_number = PositionNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_number }
    end
  end

  # GET /position_numbers/1/edit
  def edit
    @position_number = PositionNumber.find(params[:id])
  end

  # POST /position_numbers
  # POST /position_numbers.json
  def create
    @position_number = PositionNumber.new(params[:position_number])

    respond_to do |format|
      if @position_number.save
        format.html { redirect_to @position_number, notice: 'Position number was successfully created.' }
        format.json { render json: @position_number, status: :created, location: @position_number }
      else
        format.html { render action: "new" }
        format.json { render json: @position_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_numbers/1
  # PUT /position_numbers/1.json
  def update
    @position_number = PositionNumber.find(params[:id])

    respond_to do |format|
      if @position_number.update_attributes(params[:position_number])
        format.html { redirect_to @position_number, notice: 'Position number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_numbers/1
  # DELETE /position_numbers/1.json
  def destroy
    @position_number = PositionNumber.find(params[:id])
    @position_number.destroy

    respond_to do |format|
      format.html { redirect_to position_numbers_url }
      format.json { head :no_content }
    end
  end
end
=======
class PositionNumbersController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  @@filter_params = {'1' => {'title' => 'Position Number', 'table' => 'pn.position_num'},
                     '2' => {'title' => 'Position Title',  'table' => 'p.title'}}
  # GET /position_numbers
  # GET /position_numbers.xml
  def index

    @position_numbers = PositionNumber.send(:with_exclusive_scope) {PositionNumber.for_facility(session[:facility]).paginate(:page => params[:page], :per_page => 100, :order => 'active_flag desc, position_num asc')}
    @filter_params = @@filter_params

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @position_numbers.to_xml }
    end
  end

  # GET /position_numbers/1
  # GET /position_numbers/1.xml
  def show
    @position_number = PositionNumber.send(:with_exclusive_scope) { PositionNumber.find(params[:id]) }

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
    begin
      @position_number = PositionNumber.find(params[:id])
      session[:facility] = @position_number.position.position_type.facility
    rescue
      position_number = PositionNumber.send(:with_exclusive_scope) { PositionNumber.find(params[:id]).position_num }
      flash[:notice] = "The position number #{position_number} is set to inactive. Recreate it to use it again."
      redirect_to position_numbers_path
    end
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
    
    @position_number = PositionNumber.find(params[:id])
    
    @position_number.destroy
    
    respond_to do |format|
      format.html { redirect_to position_numbers_url }
      format.xml  { head :ok }
    end
  end
  
   def set_filter
    @filter_params = @@filter_params

    session[:search_dropdown] = params[:id][:filter_drop] rescue ''
    session[:search_text] = params[:position_number][:filter_text] rescue ''
    if session[:search_dropdown].to_s != nil and session[:search_dropdown] != "" then
      @search = 'pt.id = p.position_type_id and pn.position_id = p.id and ' + @@filter_params[session[:search_dropdown]]['table'] + " like ? "+ 
      ' and pt.facility_id = ?'
      @position_numbers =  PositionNumber.send(:with_exclusive_scope){ PositionNumber.find(:all, :select => 'pn.id as id, pn.position_id, pn.position_num, pn.position_type,
                                                       pn.waiver_approval_date, pn.created_on, pn.inactive_on, pn.active_flag',:from => 'position_numbers pn , positions p, position_types pt',
                                                   :conditions=> ["#{@search}", session[:search_text] + '%%' ,session[:facility][:id]],:order=>'pn.active_flag desc, pn.position_num asc')}
      render :action => 'index'
    else
      redirect_to :action => 'index'
    end   
  end  
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
