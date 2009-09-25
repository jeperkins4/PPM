class IncidentTypesController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  # GET /incident_types.xml
  def index
    @incident_types = IncidentType.paginate :per_page => 10, :page => params[:page] 
    #IncidentType.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @incident_types.to_xml }
    end
  end

  # GET /incident_types/1
  # GET /incident_types/1.xml
  def show
    @incident_type = IncidentType.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @incident_type.to_xml }
    end
  end

  # GET /incident_types/new
  def new
    @incident_type = IncidentType.new
  end

  # GET /incident_types/1;edit
  def edit
    @incident_type = IncidentType.find(params[:id])
  end

  # POST /incident_types
  # POST /incident_types.xml
  def create
    @incident_type = IncidentType.new(params[:incident_type])

    respond_to do |format|
      if @incident_type.save
        flash[:notice] = 'IncidentType was successfully created.'
        format.html { redirect_to incident_type_url(@incident_type) }
        format.xml  { head :created, :location => incident_type_url(@incident_type) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @incident_type.errors.to_xml }
      end
    end
  end

  # PUT /incident_types/1
  # PUT /incident_types/1.xml
  def update
    @incident_type = IncidentType.find(params[:id])

    respond_to do |format|
      if @incident_type.update_attributes(params[:incident_type])
        flash[:notice] = 'IncidentType was successfully updated.'
        format.html { redirect_to incident_type_url(@incident_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @incident_type.errors.to_xml }
      end
    end
  end

  # DELETE /incident_types/1
  # DELETE /incident_types/1.xml
  def destroy
    @incident_type = IncidentType.find(params[:id])
    @incident_type.destroy

    respond_to do |format|
      format.html { redirect_to incident_types_url }
      format.xml  { head :ok }
    end
  end
end
