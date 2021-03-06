<<<<<<< HEAD
class PositionsController < ApplicationController
  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @positions }
    end
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
    @position = Position.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position }
    end
  end

  # GET /positions/new
  # GET /positions/new.json
  def new
    @position = Position.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position }
    end
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(params[:position])

    respond_to do |format|
      if @position.save
        format.html { redirect_to @position, notice: 'Position was successfully created.' }
        format.json { render json: @position, status: :created, location: @position }
      else
        format.html { render action: "new" }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /positions/1
  # PUT /positions/1.json
  def update
    @position = Position.find(params[:id])

    respond_to do |format|
      if @position.update_attributes(params[:position])
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position = Position.find(params[:id])
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url }
      format.json { head :no_content }
    end
  end
end
=======
class PositionsController < ApplicationController
  before_filter :authenticate, :except => :reset_password
  layout 'administration'  
  
  # GET /positions
  # GET /positions.xml
  def index
    @facility = session[:facility]
    @positions = facility_positions_sorted

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @positions.to_xml }
    end
  end
  
  # GET /positions/1
  # GET /positions/1.xml
  def show
    
    @position =  Position.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @position.to_xml }
    end
  end
  
  # GET /positions/new
  def new
    @position = Position.new
  end
  
  # GET /positions/1;edit
  def edit
    @position = Position.find(params[:id])
  end
  
  # POST /positions
  # POST /positions.xml
  def create
    @position = Position.new(params[:position])
    
    respond_to do |format|
      if @position.save
        flash[:notice] = 'Position was successfully created.'
        format.html { redirect_to position_url(@position) }
        format.xml  { head :created, :location => position_url(@position) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position.errors.to_xml }
      end
    end
  end
  
  # PUT /positions/1
  # PUT /positions/1.xml
  def update
    @position = Position.find(params[:id])    
    respond_to do |format|
      
      if @position.salary.to_i != (params[:position][:salary]).to_i
        session[:position_history] = @position
        @position_history = PositionHist.new( :position_id  => session[:position_history].id,
                                             :salary            => session[:position_history].salary,
                                             :create_date       => Time.now)
        @position_history.save
        
        @position.update_attributes(params[:position])
        flash[:notice] = 'Position was successfully updated.'
        format.html { redirect_to position_url(@position) }
      else
        if @position.update_attributes(params[:position])
          flash[:notice] = 'Position was successfully updated.'
          format.html { redirect_to position_url(@position) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @position.errors.to_xml }
        end
      end
    end
  end
  
  # DELETE /positions/1
  # DELETE /positions/1.xml
  def destroy
    
    @position = Position.find(params[:id])

    @position.destroy
    
    respond_to do |format|
      format.html { redirect_to positions_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def facility_positions_sorted
    session[:facility].position_types.find(:all, :order => 'position_type').map do |position_type|
       position_type.positions.find(:all, :order => 'title')
    end.flatten
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
