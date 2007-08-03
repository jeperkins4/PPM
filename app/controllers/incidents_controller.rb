class IncidentsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  # GET /incidents.xml
  def index
    @incidents = Incident.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @incidents.to_xml }
    end
  end

  # GET /incidents/1
  # GET /incidents/1.xml
  def show
    @incident = Incident.find(params[:id])
    @follow_ups = @incident.follow_ups.find(:all)

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @incident.to_xml }
    end
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1;edit
  def edit
    @incident = Incident.find(params[:id])
  end

  # POST /incidents
  # POST /incidents.xml
  def create
    @incident = Incident.new(params[:incident])
    respond_to do |format|
      if @incident.save
        flash[:notice] = 'Incident was successfully created.'
        format.html { redirect_to incident_url(@incident) }
        format.xml  { head :created, :location => incident_url(@incident) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @incident.errors.to_xml }
      end
    end
  end

  # PUT /incidents/1
  # PUT /incidents/1.xml
  def update
    @incident = Incident.find(params[:id])

    respond_to do |format|
      if @incident.update_attributes(params[:incident])
        flash[:notice] = 'Incident was successfully updated.'
        format.html { redirect_to incident_url(@incident) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @incident.errors.to_xml }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.xml
  def destroy
    @incident = Incident.find(params[:id])
    @incident.destroy

    respond_to do |format|
      format.html { redirect_to incidents_url }
      format.xml  { head :ok }
    end
  end
end
