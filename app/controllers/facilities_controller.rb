<<<<<<< HEAD
class FacilitiesController < ApplicationController
  # GET /facilities
  # GET /facilities.json
  def index
    @facilities = Facility.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facilities }
    end
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
    @facility = Facility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facility }
    end
  end

  # GET /facilities/new
  # GET /facilities/new.json
  def new
    @facility = Facility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @facility }
    end
  end

  # GET /facilities/1/edit
  def edit
    @facility = Facility.find(params[:id])
  end

  # POST /facilities
  # POST /facilities.json
  def create
    @facility = Facility.new(params[:facility])

    respond_to do |format|
      if @facility.save
        format.html { redirect_to @facility, notice: 'Facility was successfully created.' }
        format.json { render json: @facility, status: :created, location: @facility }
      else
        format.html { render action: "new" }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /facilities/1
  # PUT /facilities/1.json
  def update
    @facility = Facility.find(params[:id])

    respond_to do |format|
      if @facility.update_attributes(params[:facility])
        format.html { redirect_to @facility, notice: 'Facility was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy

    respond_to do |format|
      format.html { redirect_to facilities_url }
      format.json { head :no_content }
    end
  end
end
=======
class FacilitiesController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  # GET /facilities
  # GET /facilities.xml
  def index
    @facilities = Facility.find(:all)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @facilities.to_xml }
    end
  end
  
  # GET /facilities/1
  # GET /facilities/1.xml
  def show
    @facility = Facility.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @facility.to_xml }
    end
  end
  
  
  # GET /facilities/new
  def new
    @facility = Facility.new
  end
  
  # GET /facilities/1;edit
  def edit
    @facility = Facility.find(params[:id])
  end
  
  # POST /facilities
  # POST /facilities.xml
  def create
    @facility = Facility.new(params[:facility])
    
    respond_to do |format|
      if @facility.save
        flash[:notice] = 'Facility was successfully created.'
        format.html { redirect_to facility_url(@facility) }
        format.xml  { head :created, :location => facility_url(@facility) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facility.errors.to_xml }
      end
    end
  end
  
  # PUT /facilities/1
  # PUT /facilities/1.xml
  def update
    @facility = Facility.find(params[:id])
    session[:facility] = @facility if session[:facility].id == @facility.id 

    respond_to do |format|
      if @facility.update_attributes(params[:facility])
        flash[:notice] = 'Facility was successfully updated.'
        format.html { redirect_to facility_url(@facility) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facility.errors.to_xml }
      end
    end
  end
  
  # DELETE /facilities/1
  # DELETE /facilities/1.xml
  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    
    respond_to do |format|
      format.html { redirect_to facilities_url }
      format.xml  { head :ok }
    end
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
