class NonCompFollowUpsController < ApplicationController

before_filter :authenticate 
before_filter :find_non_comp_issue
layout 'administration_with_all'

  def index
    @non_comp_follow_ups = @non_comp_issue.non_comp_follow_ups.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @non_comp_follow_ups.to_xml }
    end
  end

  # GET /non_comp_follow_ups/1
  # GET /non_comp_follow_ups/1.xml
  def show
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @non_comp_follow_up.to_xml }
    end
  end

  # GET /non_comp_follow_ups/new
  def new
    @non_comp_follow_up = NonCompFollowUp.new
  end

  # GET /non_comp_follow_ups/1;edit
  def edit
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
  end

  # POST /non_comp_follow_ups
  # POST /non_comp_follow_ups.xml
  def create
    @non_comp_follow_up = NonCompFollowUp.new(params[:non_comp_follow_up])

    respond_to do |format|
      if @non_comp_follow_up.save
        flash[:notice] = 'Non Comp Issue Follow Up was successfully added.'
        format.html { redirect_to non_comp_issue_path(@non_comp_issue) }
        format.xml  { head :created, :location => non_comp_issue_path(@non_comp_issue) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @non_comp_follow_up.errors.to_xml }
      end
    end
  end

  # PUT /non_comp_follow_ups/1
  # PUT /non_comp_follow_ups/1.xml
  def update
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
      if @non_comp_follow_up.update_attributes(params[:non_comp_follow_up])
        flash[:notice] = 'Non Comp Issue Follow Up was successfully updated.'
        format.html { redirect_to non_comp_issue_path(@non_comp_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @non_comp_follow_up.errors.to_xml }
      end
    end
  end

  # DELETE /non_comp_follow_ups/1
  # DELETE /non_comp_follow_ups/1.xml
  def destroy
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
    @non_comp_issue = @non_comp_follow_up.non_comp_issue
    @non_comp_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to non_comp_issue_url(@non_comp_issue.id) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_non_comp_issue
    @non_comp_issue = NonCompIssue.find(params[:non_comp_issue_id])
  end
  
end
