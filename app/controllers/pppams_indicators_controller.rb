class PppamsIndicatorsController < ApplicationController
  # GET /pppams_indicators
  # GET /pppams_indicators.json
  def index
    @pppams_indicators = PppamsIndicator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_indicators }
    end
  end

  # GET /pppams_indicators/1
  # GET /pppams_indicators/1.json
  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_indicator }
    end
  end

  # GET /pppams_indicators/new
  # GET /pppams_indicators/new.json
  def new
    @pppams_indicator = PppamsIndicator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_indicator }
    end
  end

  # GET /pppams_indicators/1/edit
  def edit
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  # POST /pppams_indicators
  # POST /pppams_indicators.json
  def create
    @pppams_indicator = PppamsIndicator.new(params[:pppams_indicator])

    respond_to do |format|
      if @pppams_indicator.save
        format.html { redirect_to @pppams_indicator, notice: 'Pppams indicator was successfully created.' }
        format.json { render json: @pppams_indicator, status: :created, location: @pppams_indicator }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_indicators/1
  # PUT /pppams_indicators/1.json
  def update
    @pppams_indicator = PppamsIndicator.find(params[:id])

    respond_to do |format|
      if @pppams_indicator.update_attributes(params[:pppams_indicator])
        format.html { redirect_to @pppams_indicator, notice: 'Pppams indicator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_indicators/1
  # DELETE /pppams_indicators/1.json
  def destroy
    @pppams_indicator = PppamsIndicator.find(params[:id])
    @pppams_indicator.destroy

    respond_to do |format|
      format.html { redirect_to pppams_indicators_url }
      format.json { head :no_content }
    end
  end
end
