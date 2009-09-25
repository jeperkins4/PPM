class PppamsIssueFollowUpsController < ApplicationController

before_filter :authenticate 
before_filter :find_pppams_issue
layout 'administration'

  def index
    @pppams_issue_follow_ups = @pppams_issue.pppams_issue_follow_ups.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @pppams_issue_follow_ups.to_xml }
    end
  end

  # GET /pppams_issue_follow_ups/1
  # GET /pppams_issue_follow_ups/1.xml
  def show
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @pppams_issue_follow_up.to_xml }
    end
  end

  # GET /pppams_issue_follow_ups/new
  def new
    @pppams_issue_follow_up = PppamsIssueFollowUp.new
  end

  # GET /pppams_issue_follow_ups/1;edit
  def edit
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
  end

  # POST /pppams_issue_follow_ups
  # POST /pppams_issue_follow_ups.xml
  def create
    @pppams_issue_follow_up = PppamsIssueFollowUp.new(params[:pppams_issue_follow_up])

    respond_to do |format|
      if @pppams_issue_follow_up.save
        flash[:notice] = 'Non Comp Issue Follow Up was successfully added.'
        format.html { redirect_to pppams_issue_path(@pppams_issue) }
        format.xml  { head :created, :location => pppams_issue_path(@pppams_issue) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_issue_follow_up.errors.to_xml }
      end
    end
  end

  # PUT /pppams_issue_follow_ups/1
  # PUT /pppams_issue_follow_ups/1.xml
  def update
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
      if @pppams_issue_follow_up.update_attributes(params[:pppams_issue_follow_up])
        flash[:notice] = 'Non Comp Issue Follow Up was successfully updated.'
        format.html { redirect_to pppams_issue_path(@pppams_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_issue_follow_up.errors.to_xml }
      end
    end
  end

  # DELETE /pppams_issue_follow_ups/1
  # DELETE /pppams_issue_follow_ups/1.xml
  def destroy
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
    @pppams_issue = @pppams_issue_follow_up.pppams_issue
    @pppams_issue_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to @pppams_issue }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_pppams_issue
    @pppams_issue = PppamsIssue.find(params[:pppams_issue_id])
  end
  
end
