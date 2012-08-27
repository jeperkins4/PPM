class InvestigatorsController < ApplicationController
  # GET /investigators
  # GET /investigators.json
  def index
    @investigators = Investigator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @investigators }
    end
  end

  # GET /investigators/1
  # GET /investigators/1.json
  def show
    @investigator = Investigator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @investigator }
    end
  end

  # GET /investigators/new
  # GET /investigators/new.json
  def new
    @investigator = Investigator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @investigator }
    end
  end

  # GET /investigators/1/edit
  def edit
    @investigator = Investigator.find(params[:id])
  end

  # POST /investigators
  # POST /investigators.json
  def create
    @investigator = Investigator.new(params[:investigator])

    respond_to do |format|
      if @investigator.save
        format.html { redirect_to @investigator, notice: 'Investigator was successfully created.' }
        format.json { render json: @investigator, status: :created, location: @investigator }
      else
        format.html { render action: "new" }
        format.json { render json: @investigator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /investigators/1
  # PUT /investigators/1.json
  def update
    @investigator = Investigator.find(params[:id])

    respond_to do |format|
      if @investigator.update_attributes(params[:investigator])
        format.html { redirect_to @investigator, notice: 'Investigator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @investigator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investigators/1
  # DELETE /investigators/1.json
  def destroy
    @investigator = Investigator.find(params[:id])
    @investigator.destroy

    respond_to do |format|
      format.html { redirect_to investigators_url }
      format.json { head :no_content }
    end
  end
end
