class PppamsIssuesController < ApplicationController
  # GET /pppams_issues
  # GET /pppams_issues.json
  def index
    @pppams_issues = PppamsIssue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_issues }
    end
  end

  # GET /pppams_issues/1
  # GET /pppams_issues/1.json
  def show
    @pppams_issue = PppamsIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_issue }
    end
  end

  # GET /pppams_issues/new
  # GET /pppams_issues/new.json
  def new
    @pppams_issue = PppamsIssue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_issue }
    end
  end

  # GET /pppams_issues/1/edit
  def edit
    @pppams_issue = PppamsIssue.find(params[:id])
  end

  # POST /pppams_issues
  # POST /pppams_issues.json
  def create
    @pppams_issue = PppamsIssue.new(params[:pppams_issue])

    respond_to do |format|
      if @pppams_issue.save
        format.html { redirect_to @pppams_issue, notice: 'Pppams issue was successfully created.' }
        format.json { render json: @pppams_issue, status: :created, location: @pppams_issue }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_issues/1
  # PUT /pppams_issues/1.json
  def update
    @pppams_issue = PppamsIssue.find(params[:id])

    respond_to do |format|
      if @pppams_issue.update_attributes(params[:pppams_issue])
        format.html { redirect_to @pppams_issue, notice: 'Pppams issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_issues/1
  # DELETE /pppams_issues/1.json
  def destroy
    @pppams_issue = PppamsIssue.find(params[:id])
    @pppams_issue.destroy

    respond_to do |format|
      format.html { redirect_to pppams_issues_url }
      format.json { head :no_content }
    end
  end
end
