class NotificationReportsController < ApplicationController
  # GET /notification_reports
  # GET /notification_reports.json
  def index
    @notification_reports = NotificationReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notification_reports }
    end
  end

  # GET /notification_reports/1
  # GET /notification_reports/1.json
  def show
    @notification_report = NotificationReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification_report }
    end
  end

  # GET /notification_reports/new
  # GET /notification_reports/new.json
  def new
    @notification_report = NotificationReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification_report }
    end
  end

  # GET /notification_reports/1/edit
  def edit
    @notification_report = NotificationReport.find(params[:id])
  end

  # POST /notification_reports
  # POST /notification_reports.json
  def create
    @notification_report = NotificationReport.new(params[:notification_report])

    respond_to do |format|
      if @notification_report.save
        format.html { redirect_to @notification_report, notice: 'Notification report was successfully created.' }
        format.json { render json: @notification_report, status: :created, location: @notification_report }
      else
        format.html { render action: "new" }
        format.json { render json: @notification_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_reports/1
  # PUT /notification_reports/1.json
  def update
    @notification_report = NotificationReport.find(params[:id])

    respond_to do |format|
      if @notification_report.update_attributes(params[:notification_report])
        format.html { redirect_to @notification_report, notice: 'Notification report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_reports/1
  # DELETE /notification_reports/1.json
  def destroy
    @notification_report = NotificationReport.find(params[:id])
    @notification_report.destroy

    respond_to do |format|
      format.html { redirect_to notification_reports_url }
      format.json { head :no_content }
    end
  end
end
