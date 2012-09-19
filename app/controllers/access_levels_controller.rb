class AccessLevelsController < ApplicationController
<<<<<<< HEAD
  # GET /access_levels
  # GET /access_levels.json
  def index
    @access_levels = AccessLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @access_levels }
=======
before_filter :admin_authenticate
layout 'administration'

  def index
    @access_levels = AccessLevel.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @access_levels.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /access_levels/1
<<<<<<< HEAD
  # GET /access_levels/1.json
=======
  # GET /access_levels/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
<<<<<<< HEAD
      format.html # show.html.erb
      format.json { render json: @access_level }
=======
      format.html # show.rhtml
      format.xml  { render :xml => @access_level.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /access_levels/new
<<<<<<< HEAD
  # GET /access_levels/new.json
  def new
    @access_level = AccessLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @access_level }
    end
  end

  # GET /access_levels/1/edit
=======
  def new
    @access_level = AccessLevel.new
  end

  # GET /access_levels/1;edit
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @access_level = AccessLevel.find(params[:id])
  end

  # POST /access_levels
<<<<<<< HEAD
  # POST /access_levels.json
=======
  # POST /access_levels.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @access_level = AccessLevel.new(params[:access_level])

    respond_to do |format|
      if @access_level.save
<<<<<<< HEAD
        format.html { redirect_to @access_level, notice: 'Access level was successfully created.' }
        format.json { render json: @access_level, status: :created, location: @access_level }
      else
        format.html { render action: "new" }
        format.json { render json: @access_level.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'AccessLevel was successfully created.'
        format.html { redirect_to access_level_url(@access_level) }
        format.xml  { head :created, :location => access_level_url(@access_level) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @access_level.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /access_levels/1
<<<<<<< HEAD
  # PUT /access_levels/1.json
=======
  # PUT /access_levels/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @access_level = AccessLevel.find(params[:id])

    respond_to do |format|
      if @access_level.update_attributes(params[:access_level])
<<<<<<< HEAD
        format.html { redirect_to @access_level, notice: 'Access level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @access_level.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'AccessLevel was successfully updated.'
        format.html { redirect_to access_level_url(@access_level) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @access_level.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /access_levels/1
<<<<<<< HEAD
  # DELETE /access_levels/1.json
=======
  # DELETE /access_levels/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def destroy
    @access_level = AccessLevel.find(params[:id])
    @access_level.destroy

    respond_to do |format|
      format.html { redirect_to access_levels_url }
<<<<<<< HEAD
      format.json { head :no_content }
=======
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
