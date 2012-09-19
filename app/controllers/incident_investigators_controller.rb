<<<<<<< HEAD
class IncidentInvestigatorsController < ApplicationController
  # GET /incident_investigators
  # GET /incident_investigators.json
  def index
    @incident_investigators = IncidentInvestigator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incident_investigators }
    end
  end

  # GET /incident_investigators/1
  # GET /incident_investigators/1.json
  def show
    @incident_investigator = IncidentInvestigator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @incident_investigator }
    end
  end

  # GET /incident_investigators/new
  # GET /incident_investigators/new.json
  def new
    @incident_investigator = IncidentInvestigator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @incident_investigator }
    end
  end

  # GET /incident_investigators/1/edit
  def edit
    @incident_investigator = IncidentInvestigator.find(params[:id])
  end

  # POST /incident_investigators
  # POST /incident_investigators.json
  def create
    @incident_investigator = IncidentInvestigator.new(params[:incident_investigator])

    respond_to do |format|
      if @incident_investigator.save
        format.html { redirect_to @incident_investigator, notice: 'Incident investigator was successfully created.' }
        format.json { render json: @incident_investigator, status: :created, location: @incident_investigator }
      else
        format.html { render action: "new" }
        format.json { render json: @incident_investigator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incident_investigators/1
  # PUT /incident_investigators/1.json
  def update
    @incident_investigator = IncidentInvestigator.find(params[:id])

    respond_to do |format|
      if @incident_investigator.update_attributes(params[:incident_investigator])
        format.html { redirect_to @incident_investigator, notice: 'Incident investigator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @incident_investigator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incident_investigators/1
  # DELETE /incident_investigators/1.json
  def destroy
    @incident_investigator = IncidentInvestigator.find(params[:id])
    @incident_investigator.destroy

    respond_to do |format|
      format.html { redirect_to incident_investigators_url }
      format.json { head :no_content }
    end
  end
end
=======
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
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
