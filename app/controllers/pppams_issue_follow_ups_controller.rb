class PppamsIssueFollowUpsController < ApplicationController
  # GET /pppams_issue_follow_ups
  # GET /pppams_issue_follow_ups.json
  def index
    @pppams_issue_follow_ups = PppamsIssueFollowUp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_issue_follow_ups }
    end
  end

  # GET /pppams_issue_follow_ups/1
  # GET /pppams_issue_follow_ups/1.json
  def show
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_issue_follow_up }
    end
  end

  # GET /pppams_issue_follow_ups/new
  # GET /pppams_issue_follow_ups/new.json
  def new
    @pppams_issue_follow_up = PppamsIssueFollowUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_issue_follow_up }
    end
  end

  # GET /pppams_issue_follow_ups/1/edit
  def edit
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
  end

  # POST /pppams_issue_follow_ups
  # POST /pppams_issue_follow_ups.json
  def create
    @pppams_issue_follow_up = PppamsIssueFollowUp.new(params[:pppams_issue_follow_up])

    respond_to do |format|
      if @pppams_issue_follow_up.save
        format.html { redirect_to @pppams_issue_follow_up, notice: 'Pppams issue follow up was successfully created.' }
        format.json { render json: @pppams_issue_follow_up, status: :created, location: @pppams_issue_follow_up }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_issue_follow_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_issue_follow_ups/1
  # PUT /pppams_issue_follow_ups/1.json
  def update
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
      if @pppams_issue_follow_up.update_attributes(params[:pppams_issue_follow_up])
        format.html { redirect_to @pppams_issue_follow_up, notice: 'Pppams issue follow up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_issue_follow_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_issue_follow_ups/1
  # DELETE /pppams_issue_follow_ups/1.json
  def destroy
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
    @pppams_issue_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to pppams_issue_follow_ups_url }
      format.json { head :no_content }
    end
  end
end
