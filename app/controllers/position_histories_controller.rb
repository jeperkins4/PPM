class PositionHistoriesController < ApplicationController
  # GET /position_histories
  # GET /position_histories.json
  def index
    @position_histories = PositionHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @position_histories }
    end
  end

  # GET /position_histories/1
  # GET /position_histories/1.json
  def show
    @position_history = PositionHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_history }
    end
  end

  # GET /position_histories/new
  # GET /position_histories/new.json
  def new
    @position_history = PositionHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_history }
    end
  end

  # GET /position_histories/1/edit
  def edit
    @position_history = PositionHistory.find(params[:id])
  end

  # POST /position_histories
  # POST /position_histories.json
  def create
    @position_history = PositionHistory.new(params[:position_history])

    respond_to do |format|
      if @position_history.save
        format.html { redirect_to @position_history, notice: 'Position history was successfully created.' }
        format.json { render json: @position_history, status: :created, location: @position_history }
      else
        format.html { render action: "new" }
        format.json { render json: @position_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_histories/1
  # PUT /position_histories/1.json
  def update
    @position_history = PositionHistory.find(params[:id])

    respond_to do |format|
      if @position_history.update_attributes(params[:position_history])
        format.html { redirect_to @position_history, notice: 'Position history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_histories/1
  # DELETE /position_histories/1.json
  def destroy
    @position_history = PositionHistory.find(params[:id])
    @position_history.destroy

    respond_to do |format|
      format.html { redirect_to position_histories_url }
      format.json { head :no_content }
    end
  end
end
