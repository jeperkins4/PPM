class AccountabilityLogsController < ApplicationController
  # GET /accountability_logs
  # GET /accountability_logs.json
  def index
    @accountability_logs = AccountabilityLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accountability_logs }
    end
  end

  # GET /accountability_logs/1
  # GET /accountability_logs/1.json
  def show
    @accountability_log = AccountabilityLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accountability_log }
    end
  end

  # GET /accountability_logs/new
  # GET /accountability_logs/new.json
  def new
    @accountability_log = AccountabilityLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accountability_log }
    end
  end

  # GET /accountability_logs/1/edit
  def edit
    @accountability_log = AccountabilityLog.find(params[:id])
  end

  # POST /accountability_logs
  # POST /accountability_logs.json
  def create
    @accountability_log = AccountabilityLog.new(params[:accountability_log])

    respond_to do |format|
      if @accountability_log.save
        format.html { redirect_to @accountability_log, notice: 'Accountability log was successfully created.' }
        format.json { render json: @accountability_log, status: :created, location: @accountability_log }
      else
        format.html { render action: "new" }
        format.json { render json: @accountability_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accountability_logs/1
  # PUT /accountability_logs/1.json
  def update
    @accountability_log = AccountabilityLog.find(params[:id])

    respond_to do |format|
      if @accountability_log.update_attributes(params[:accountability_log])
        format.html { redirect_to @accountability_log, notice: 'Accountability log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accountability_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountability_logs/1
  # DELETE /accountability_logs/1.json
  def destroy
    @accountability_log = AccountabilityLog.find(params[:id])
    @accountability_log.destroy

    respond_to do |format|
      format.html { redirect_to accountability_logs_url }
      format.json { head :no_content }
    end
  end
end
