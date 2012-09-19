class NonCompFollowUpsController < ApplicationController
<<<<<<< HEAD
  # GET /non_comp_follow_ups
  # GET /non_comp_follow_ups.json
  def index
    @non_comp_follow_ups = NonCompFollowUp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @non_comp_follow_ups }
=======

before_filter :authenticate 
before_filter :find_non_comp_issue
layout 'administration_with_all'

  def index
    @non_comp_follow_ups = @non_comp_issue.non_comp_follow_ups.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @non_comp_follow_ups.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /non_comp_follow_ups/1
<<<<<<< HEAD
  # GET /non_comp_follow_ups/1.json
=======
  # GET /non_comp_follow_ups/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def show
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
<<<<<<< HEAD
      format.html # show.html.erb
      format.json { render json: @non_comp_follow_up }
=======
      format.html # show.rhtml
      format.xml  { render :xml => @non_comp_follow_up.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
    end
  end

  # GET /non_comp_follow_ups/new
<<<<<<< HEAD
  # GET /non_comp_follow_ups/new.json
  def new
    @non_comp_follow_up = NonCompFollowUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @non_comp_follow_up }
    end
  end

  # GET /non_comp_follow_ups/1/edit
=======
  def new
    @non_comp_follow_up = NonCompFollowUp.new
  end

  # GET /non_comp_follow_ups/1;edit
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
  end

  # POST /non_comp_follow_ups
<<<<<<< HEAD
  # POST /non_comp_follow_ups.json
=======
  # POST /non_comp_follow_ups.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def create
    @non_comp_follow_up = NonCompFollowUp.new(params[:non_comp_follow_up])

    respond_to do |format|
      if @non_comp_follow_up.save
<<<<<<< HEAD
        format.html { redirect_to @non_comp_follow_up, notice: 'Non comp follow up was successfully created.' }
        format.json { render json: @non_comp_follow_up, status: :created, location: @non_comp_follow_up }
      else
        format.html { render action: "new" }
        format.json { render json: @non_comp_follow_up.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'Non Comp Issue Follow Up was successfully added.'
        format.html { redirect_to non_comp_issue_path(@non_comp_issue) }
        format.xml  { head :created, :location => non_comp_issue_path(@non_comp_issue) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @non_comp_follow_up.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # PUT /non_comp_follow_ups/1
<<<<<<< HEAD
  # PUT /non_comp_follow_ups/1.json
=======
  # PUT /non_comp_follow_ups/1.xml
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def update
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])

    respond_to do |format|
      if @non_comp_follow_up.update_attributes(params[:non_comp_follow_up])
<<<<<<< HEAD
        format.html { redirect_to @non_comp_follow_up, notice: 'Non comp follow up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @non_comp_follow_up.errors, status: :unprocessable_entity }
=======
        flash[:notice] = 'Non Comp Issue Follow Up was successfully updated.'
        format.html { redirect_to non_comp_issue_path(@non_comp_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @non_comp_follow_up.errors.to_xml }
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
      end
    end
  end

  # DELETE /non_comp_follow_ups/1
<<<<<<< HEAD
  # DELETE /non_comp_follow_ups/1.json
  def destroy
    @non_comp_follow_up = NonCompFollowUp.find(params[:id])
    @non_comp_follow_up.destroy

    respond_to do |format|
      format.html { redirect_to non_comp_follow_ups_url }
      format.json { head :no_content }
    end
  end
=======
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
  
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
