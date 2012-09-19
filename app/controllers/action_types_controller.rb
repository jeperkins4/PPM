class ActionTypesController < ApplicationController
<<<<<<< HEAD
  # GET /action_types
  # GET /action_types.json
  def index
    @action_types = ActionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_types }
=======
  before_filter :admin_authenticate
  layout 'administration'
  # GET /action_types.xml
  def index
    @action_types = ActionType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @action_types.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /action_types/1
<<<<<<< HEAD
  # GET /action_types/1.json
=======
  # GET /action_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @action_type = ActionType.find(params[:id])

    respond_to do |format|
<<<<<<< HEAD
      format.html # show.html.erb
      format.json { render json: @action_type }
=======
      format.html # show.rhtml
      format.xml  { render :xml => @action_type.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /action_types/new
<<<<<<< HEAD
  # GET /action_types/new.json
  def new
    @action_type = ActionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_type }
    end
  end

  # GET /action_types/1/edit
=======
  def new
    @action_type = ActionType.new
  end

  # GET /action_types/1;edit
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @action_type = ActionType.find(params[:id])
  end

  # POST /action_types
<<<<<<< HEAD
  # POST /action_types.json
=======
  # POST /action_types.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @action_type = ActionType.new(params[:action_type])

    respond_to do |format|
      if @action_type.save
<<<<<<< HEAD
        format.html { redirect_to @action_type, notice: 'Action type was successfully created.' }
        format.json { render json: @action_type, status: :created, location: @action_type }
      else
        format.html { render action: "new" }
        format.json { render json: @action_type.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'ActionType was successfully created.'
        format.html { redirect_to action_type_url(@action_type) }
        format.xml  { head :created, :location => action_type_url(@action_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action_type.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /action_types/1
<<<<<<< HEAD
  # PUT /action_types/1.json
=======
  # PUT /action_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @action_type = ActionType.find(params[:id])

    respond_to do |format|
      if @action_type.update_attributes(params[:action_type])
<<<<<<< HEAD
        format.html { redirect_to @action_type, notice: 'Action type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_type.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'ActionType was successfully updated.'
        format.html { redirect_to action_type_url(@action_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action_type.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /action_types/1
<<<<<<< HEAD
  # DELETE /action_types/1.json
=======
  # DELETE /action_types/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def destroy
    @action_type = ActionType.find(params[:id])
    @action_type.destroy

    respond_to do |format|
      format.html { redirect_to action_types_url }
<<<<<<< HEAD
      format.json { head :no_content }
=======
      format.xml  { head :ok }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end
end
