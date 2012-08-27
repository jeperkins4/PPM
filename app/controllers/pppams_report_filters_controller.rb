class PppamsReportFiltersController < ApplicationController
  # GET /pppams_report_filters
  # GET /pppams_report_filters.json
  def index
    @pppams_report_filters = PppamsReportFilter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_report_filters }
    end
  end

  # GET /pppams_report_filters/1
  # GET /pppams_report_filters/1.json
  def show
    @pppams_report_filter = PppamsReportFilter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_report_filter }
    end
  end

  # GET /pppams_report_filters/new
  # GET /pppams_report_filters/new.json
  def new
    @pppams_report_filter = PppamsReportFilter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_report_filter }
    end
  end

  # GET /pppams_report_filters/1/edit
  def edit
    @pppams_report_filter = PppamsReportFilter.find(params[:id])
  end

  # POST /pppams_report_filters
  # POST /pppams_report_filters.json
  def create
    @pppams_report_filter = PppamsReportFilter.new(params[:pppams_report_filter])

    respond_to do |format|
      if @pppams_report_filter.save
        format.html { redirect_to @pppams_report_filter, notice: 'Pppams report filter was successfully created.' }
        format.json { render json: @pppams_report_filter, status: :created, location: @pppams_report_filter }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_report_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_report_filters/1
  # PUT /pppams_report_filters/1.json
  def update
    @pppams_report_filter = PppamsReportFilter.find(params[:id])

    respond_to do |format|
      if @pppams_report_filter.update_attributes(params[:pppams_report_filter])
        format.html { redirect_to @pppams_report_filter, notice: 'Pppams report filter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_report_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_report_filters/1
  # DELETE /pppams_report_filters/1.json
  def destroy
    @pppams_report_filter = PppamsReportFilter.find(params[:id])
    @pppams_report_filter.destroy

    respond_to do |format|
      format.html { redirect_to pppams_report_filters_url }
      format.json { head :no_content }
    end
  end
end
