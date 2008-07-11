class IncidentInvestigatorsController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  # GET /incident_investigators.xml
  def index
    @incident_investigators = IncidentInvestigator.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @incident_investigators.to_xml }
    end
  end

  # GET /incident_investigators/1
  # GET /incident_investigators/1.xml
  def show
    @incident_investigator = IncidentInvestigator.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @incident_investigator.to_xml }
    end
  end

  # GET /incident_investigators/new
  def new
    @incident_investigator = IncidentInvestigator.new
  end

  # GET /incident_investigators/1;edit
  def edit
    @incident_investigator = IncidentInvestigator.find(params[:id])
  end

  # POST /incident_investigators
  # POST /incident_investigators.xml
  def create
    @incident_investigator = IncidentInvestigator.new(params[:incident_investigator])

    respond_to do |format|
      if @incident_investigator.save
        flash[:notice] = 'IncidentInvestigator was successfully created.'
        format.html { redirect_to incident_investigator_url(@incident_investigator) }
        format.xml  { head :created, :location => incident_investigator_url(@incident_investigator) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @incident_investigator.errors.to_xml }
      end
    end
  end

  # PUT /incident_investigators/1
  # PUT /incident_investigators/1.xml
  def update
    @incident_investigator = IncidentInvestigator.find(params[:id])

    respond_to do |format|
      if @incident_investigator.update_attributes(params[:incident_investigator])
        flash[:notice] = 'IncidentInvestigator was successfully updated.'
        format.html { redirect_to incident_investigator_url(@incident_investigator) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @incident_investigator.errors.to_xml }
      end
    end
  end

  # DELETE /incident_investigators/1
  # DELETE /incident_investigators/1.xml
  def destroy
    @incident_investigator = IncidentInvestigator.find(params[:id])
    @incident_investigator.destroy

    respond_to do |format|
      format.html { redirect_to incident_investigators_url }
      format.xml  { head :ok }
    end
  end
end
