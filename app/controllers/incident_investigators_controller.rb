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
