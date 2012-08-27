class AccountabilityLogDetailsController < ApplicationController
  # GET /accountability_log_details
  # GET /accountability_log_details.json
  def index
    @accountability_log_details = AccountabilityLogDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accountability_log_details }
    end
  end

  # GET /accountability_log_details/1
  # GET /accountability_log_details/1.json
  def show
    @accountability_log_detail = AccountabilityLogDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accountability_log_detail }
    end
  end

  # GET /accountability_log_details/new
  # GET /accountability_log_details/new.json
  def new
    @accountability_log_detail = AccountabilityLogDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accountability_log_detail }
    end
  end

  # GET /accountability_log_details/1/edit
  def edit
    @accountability_log_detail = AccountabilityLogDetail.find(params[:id])
  end

  # POST /accountability_log_details
  # POST /accountability_log_details.json
  def create
    @accountability_log_detail = AccountabilityLogDetail.new(params[:accountability_log_detail])

    respond_to do |format|
      if @accountability_log_detail.save
        format.html { redirect_to @accountability_log_detail, notice: 'Accountability log detail was successfully created.' }
        format.json { render json: @accountability_log_detail, status: :created, location: @accountability_log_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @accountability_log_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accountability_log_details/1
  # PUT /accountability_log_details/1.json
  def update
    @accountability_log_detail = AccountabilityLogDetail.find(params[:id])

    respond_to do |format|
      if @accountability_log_detail.update_attributes(params[:accountability_log_detail])
        format.html { redirect_to @accountability_log_detail, notice: 'Accountability log detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accountability_log_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountability_log_details/1
  # DELETE /accountability_log_details/1.json
  def destroy
    @accountability_log_detail = AccountabilityLogDetail.find(params[:id])
    @accountability_log_detail.destroy

    respond_to do |format|
      format.html { redirect_to accountability_log_details_url }
      format.json { head :no_content }
    end
  end
end
