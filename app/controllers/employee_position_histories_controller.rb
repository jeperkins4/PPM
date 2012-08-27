class EmployeePositionHistoriesController < ApplicationController
  # GET /employee_position_histories
  # GET /employee_position_histories.json
  def index
    @employee_position_histories = EmployeePositionHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employee_position_histories }
    end
  end

  # GET /employee_position_histories/1
  # GET /employee_position_histories/1.json
  def show
    @employee_position_history = EmployeePositionHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee_position_history }
    end
  end

  # GET /employee_position_histories/new
  # GET /employee_position_histories/new.json
  def new
    @employee_position_history = EmployeePositionHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee_position_history }
    end
  end

  # GET /employee_position_histories/1/edit
  def edit
    @employee_position_history = EmployeePositionHistory.find(params[:id])
  end

  # POST /employee_position_histories
  # POST /employee_position_histories.json
  def create
    @employee_position_history = EmployeePositionHistory.new(params[:employee_position_history])

    respond_to do |format|
      if @employee_position_history.save
        format.html { redirect_to @employee_position_history, notice: 'Employee position history was successfully created.' }
        format.json { render json: @employee_position_history, status: :created, location: @employee_position_history }
      else
        format.html { render action: "new" }
        format.json { render json: @employee_position_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employee_position_histories/1
  # PUT /employee_position_histories/1.json
  def update
    @employee_position_history = EmployeePositionHistory.find(params[:id])

    respond_to do |format|
      if @employee_position_history.update_attributes(params[:employee_position_history])
        format.html { redirect_to @employee_position_history, notice: 'Employee position history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee_position_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_position_histories/1
  # DELETE /employee_position_histories/1.json
  def destroy
    @employee_position_history = EmployeePositionHistory.find(params[:id])
    @employee_position_history.destroy

    respond_to do |format|
      format.html { redirect_to employee_position_histories_url }
      format.json { head :no_content }
    end
  end
end
