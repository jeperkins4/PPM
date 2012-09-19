<<<<<<< HEAD
class IncidentClassesController < ApplicationController
  # GET /incident_classes
  # GET /incident_classes.json
  def index
    @incident_classes = IncidentClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incident_classes }
    end
  end

  # GET /incident_classes/1
  # GET /incident_classes/1.json
  def show
    @incident_class = IncidentClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @incident_class }
    end
  end

  # GET /incident_classes/new
  # GET /incident_classes/new.json
  def new
    @incident_class = IncidentClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @incident_class }
    end
  end

  # GET /incident_classes/1/edit
  def edit
    @incident_class = IncidentClass.find(params[:id])
  end

  # POST /incident_classes
  # POST /incident_classes.json
  def create
    @incident_class = IncidentClass.new(params[:incident_class])

    respond_to do |format|
      if @incident_class.save
        format.html { redirect_to @incident_class, notice: 'Incident class was successfully created.' }
        format.json { render json: @incident_class, status: :created, location: @incident_class }
      else
        format.html { render action: "new" }
        format.json { render json: @incident_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incident_classes/1
  # PUT /incident_classes/1.json
  def update
    @incident_class = IncidentClass.find(params[:id])

    respond_to do |format|
      if @incident_class.update_attributes(params[:incident_class])
        format.html { redirect_to @incident_class, notice: 'Incident class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @incident_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incident_classes/1
  # DELETE /incident_classes/1.json
  def destroy
    @incident_class = IncidentClass.find(params[:id])
    @incident_class.destroy

    respond_to do |format|
      format.html { redirect_to incident_classes_url }
      format.json { head :no_content }
    end
  end
end
=======
class IncidentClassesController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  # GET /incident_classes.xml
  def index
    @incident_classes = IncidentClass.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @incident_classes.to_xml }
    end
  end

  # GET /incident_classes/1
  # GET /incident_classes/1.xml
  def show
    @incident_class = IncidentClass.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @incident_class.to_xml }
    end
  end

  # GET /incident_classes/new
  def new
    @incident_class = IncidentClass.new
  end

  # GET /incident_classes/1;edit
  def edit
    @incident_class = IncidentClass.find(params[:id])
  end

  # POST /incident_classes
  # POST /incident_classes.xml
  def create
    @incident_class = IncidentClass.new(params[:incident_class])

    respond_to do |format|
      if @incident_class.save
        flash[:notice] = 'IncidentClass was successfully created.'
        format.html { redirect_to incident_class_url(@incident_class) }
        format.xml  { head :created, :location => incident_class_url(@incident_class) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @incident_class.errors.to_xml }
      end
    end
  end

  # PUT /incident_classes/1
  # PUT /incident_classes/1.xml
  def update
    @incident_class = IncidentClass.find(params[:id])

    respond_to do |format|
      if @incident_class.update_attributes(params[:incident_class])
        flash[:notice] = 'IncidentClass was successfully updated.'
        format.html { redirect_to incident_class_url(@incident_class) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @incident_class.errors.to_xml }
      end
    end
  end

  # DELETE /incident_classes/1
  # DELETE /incident_classes/1.xml
  def destroy
    @incident_class = IncidentClass.find(params[:id])
    @incident_class.destroy

    respond_to do |format|
      format.html { redirect_to incident_classes_url }
      format.xml  { head :ok }
    end
  end
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
