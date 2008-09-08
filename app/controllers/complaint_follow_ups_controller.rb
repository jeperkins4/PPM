class ComplaintFollowUpsController < ApplicationController

before_filter :authenticate 
before_filter :find_complaint
layout 'administration'

  def index
    @complaint_follow_ups = @complaint.complaint_follow_ups.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @complaint_follow_ups.to_xml }
    end
  end

  # GET /complaint_follow_ups/1
  # GET /complaint_follow_ups/1.xml
  def show
    @complaint_follow_up = ComplaintFollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @complaint_follow_up.to_xml }
    end
  end

  # GET /complaint_follow_ups/new
  def new
    @complaint_follow_up = ComplaintFollowUp.new
  end

  # GET /complaint_follow_ups/1;edit
  def edit
    @complaint_follow_up = ComplaintFollowUp.find(params[:id])
  end

  # POST /complaint_follow_ups
  # POST /complaint_follow_ups.xml
  def create
    @complaint_follow_up = ComplaintFollowUp.new(params[:complaint_follow_up])

    respond_to do |format|
      if @complaint_follow_up.save
        flash[:notice] = 'Non Comp Issue Follow Up was successfully added.'
        format.html { redirect_to complaint_path(@complaint) }
        format.xml  { head :created, :location => complaint_path(@complaint) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @complaint_follow_up.errors.to_xml }
      end
    end
  end

  # PUT /complaint_follow_ups/1
  # PUT /complaint_follow_ups/1.xml
  def update
    @complaint_follow_up = ComplaintFollowUp.find(params[:id])

    respond_to do |format|
      if @complaint_follow_up.update_attributes(params[:complaint_follow_up])
        flash[:notice] = 'Non Comp Issue Follow Up was successfully updated.'
        format.html { redirect_to complaint_path(@complaint) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @complaint_follow_up.errors.to_xml }
      end
    end
  end

  # DELETE /complaint_follow_ups/1
  # DELETE /complaint_follow_ups/1.xml
  def destroy
    @complaint_follow_up = ComplaintFollowUp.find(params[:id])
    @complaint_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to complaint_follow_ups_url(@complaint) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end
  
end
