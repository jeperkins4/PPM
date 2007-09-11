class PositionsController < ApplicationController
  before_filter :authenticate, :except => :reset_password
  layout 'administration'  
  
  # GET /positions
  # GET /positions.xml
  def index
    if session[:access_level] == 'Administrator'
      @positions = Position.find(:all)
    else
      @positions =  session[:facility].positions.find(:all)
    end
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @positions.to_xml }
    end
  end
  
  # GET /positions/1
  # GET /positions/1.xml
  def show
    
    if session[:access_level] == 'Administrator'
      @position = Position.find(params[:id])
    else    
      @position =  session[:facility].positions.find(params[:id])
    end
    
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
        @position_history = PositionHist.new( :title             => session[:position_history].title, 
                                              :position_type_id  => session[:position_history].position_type_id,
                                              :salary            => session[:position_history].salary,
                                              :description       => session[:position_history].description, 
                                              :facility_id       => session[:position_history].facility_id, 
                                              :create_date       => Time.now )
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
    
    if session[:access_level] == 'Administrator'    
      @position = Position.find(params[:id])
    else
      @position = session[:facility].positions.find(params[:id])
    end
    
    @position.destroy
    
    respond_to do |format|
      format.html { redirect_to positions_url }
      format.xml  { head :ok }
    end
  end
end
