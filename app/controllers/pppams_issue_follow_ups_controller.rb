class PppamsIssueFollowUpsController < ApplicationController
<<<<<<< HEAD
  # GET /pppams_issue_follow_ups
  # GET /pppams_issue_follow_ups.json
  def index
    @pppams_issue_follow_ups = PppamsIssueFollowUp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_issue_follow_ups }
=======

before_filter :authenticate 
before_filter :find_pppams_issue
layout 'administration'

  def index
    @pppams_issue_follow_ups = @pppams_issue.pppams_issue_follow_ups.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @pppams_issue_follow_ups.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_issue_follow_ups/1
<<<<<<< HEAD
  # GET /pppams_issue_follow_ups/1.json
=======
  # GET /pppams_issue_follow_ups/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
<<<<<<< HEAD
      format.html # show.html.erb
      format.json { render json: @pppams_issue_follow_up }
=======
      format.html # show.rhtml
      format.xml  { render :xml => @pppams_issue_follow_up.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /pppams_issue_follow_ups/new
<<<<<<< HEAD
  # GET /pppams_issue_follow_ups/new.json
  def new
    @pppams_issue_follow_up = PppamsIssueFollowUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_issue_follow_up }
    end
  end

  # GET /pppams_issue_follow_ups/1/edit
=======
  def new
    @pppams_issue_follow_up = PppamsIssueFollowUp.new
  end

  # GET /pppams_issue_follow_ups/1;edit
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
  end

  # POST /pppams_issue_follow_ups
<<<<<<< HEAD
  # POST /pppams_issue_follow_ups.json
=======
  # POST /pppams_issue_follow_ups.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @pppams_issue_follow_up = PppamsIssueFollowUp.new(params[:pppams_issue_follow_up])

    respond_to do |format|
      if @pppams_issue_follow_up.save
<<<<<<< HEAD
        format.html { redirect_to @pppams_issue_follow_up, notice: 'Pppams issue follow up was successfully created.' }
        format.json { render json: @pppams_issue_follow_up, status: :created, location: @pppams_issue_follow_up }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_issue_follow_up.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'Non Comp Issue Follow Up was successfully added.'
        format.html { redirect_to pppams_issue_path(@pppams_issue) }
        format.xml  { head :created, :location => pppams_issue_path(@pppams_issue) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pppams_issue_follow_up.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /pppams_issue_follow_ups/1
<<<<<<< HEAD
  # PUT /pppams_issue_follow_ups/1.json
=======
  # PUT /pppams_issue_follow_ups/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])

    respond_to do |format|
      if @pppams_issue_follow_up.update_attributes(params[:pppams_issue_follow_up])
<<<<<<< HEAD
        format.html { redirect_to @pppams_issue_follow_up, notice: 'Pppams issue follow up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_issue_follow_up.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'Non Comp Issue Follow Up was successfully updated.'
        format.html { redirect_to pppams_issue_path(@pppams_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_issue_follow_up.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /pppams_issue_follow_ups/1
<<<<<<< HEAD
  # DELETE /pppams_issue_follow_ups/1.json
  def destroy
    @pppams_issue_follow_up = PppamsIssueFollowUp.find(params[:id])
    @pppams_issue_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to pppams_issue_follow_ups_url }
      format.json { head :no_content }
    end
  end
=======
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
  
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
