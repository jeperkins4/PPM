class NonCompIssuesController < ApplicationController
<<<<<<< HEAD
  # GET /non_comp_issues
  # GET /non_comp_issues.json
  def index
    @non_comp_issues = NonCompIssue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @non_comp_issues }
    end
  end

  # GET /non_comp_issues/1
  # GET /non_comp_issues/1.json
  def show
    @non_comp_issue = NonCompIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @non_comp_issue }
    end
  end

  # GET /non_comp_issues/new
  # GET /non_comp_issues/new.json
  def new
    @non_comp_issue = NonCompIssue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @non_comp_issue }
    end
  end

  # GET /non_comp_issues/1/edit
  def edit
    @non_comp_issue = NonCompIssue.find(params[:id])
  end

  # POST /non_comp_issues
  # POST /non_comp_issues.json
  def create
    @non_comp_issue = NonCompIssue.new(params[:non_comp_issue])

    respond_to do |format|
      if @non_comp_issue.save
        format.html { redirect_to @non_comp_issue, notice: 'Non comp issue was successfully created.' }
        format.json { render json: @non_comp_issue, status: :created, location: @non_comp_issue }
      else
        format.html { render action: "new" }
        format.json { render json: @non_comp_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /non_comp_issues/1
  # PUT /non_comp_issues/1.json
  def update
    @non_comp_issue = NonCompIssue.find(params[:id])

    respond_to do |format|
      if @non_comp_issue.update_attributes(params[:non_comp_issue])
        format.html { redirect_to @non_comp_issue, notice: 'Non comp issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @non_comp_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /non_comp_issues/1
  # DELETE /non_comp_issues/1.json
  def destroy
    @non_comp_issue = NonCompIssue.find(params[:id])
    @non_comp_issue.destroy

    respond_to do |format|
      format.html { redirect_to non_comp_issues_url }
      format.json { head :no_content }
    end
  end
=======

  before_filter :authenticate
  
  layout 'administration_with_all'
  # GET /non_comp_issues.xml
  def index
    session[:nci_status] = params[:nci_status] unless params[:nci_status].nil?
    @nci_status = session[:nci_status].nil? ?  "3" : session[:nci_status]
    @status_ar_st = (@nci_status.to_i == 4) ? "4" : (0..@nci_status.to_i).to_a
    
    condition_ar = session[:facility].class.to_s == 'Junk' ? ['nci_status in (?)', @status_ar_st] : ['nci_status in (?) and facility_id = ?', @status_ar_st, session[:facility].id]
    @non_comp_issues = NonCompIssue.paginate :page => params[:page],
      :order => 'facility_id, discovery_date',
      :per_page => 20,
      :conditions => condition_ar
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @non_comp_issues.to_xml }
    end
    
  end
  
  # GET /non_comp_issues/1
  # GET /non_comp_issues/1.xml
  def show
    @non_comp_issue = NonCompIssue.find(params[:id])
    @non_comp_follow_ups = @non_comp_issue.non_comp_follow_ups.find(:all)
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @non_comp_issue.to_xml }
    end
  end
  
  # GET /non_comp_issues/new
  def new
    redirect_to :action => :index if session[:facility].class.to_s == 'Junk'
    @non_comp_issue = NonCompIssue.new
  end
  
  # GET /non_comp_issues/1;edit
  def edit
    @non_comp_issue = NonCompIssue.find(params[:id])
  end
  
  # POST /non_comp_issues
  # POST /non_comp_issues.xml
  def create
    if session[:facility].shortname.nil?
      flash[:notice] = 'Issue could not be saved - this facility does not have a short name!'
      render :action => 'new'
    else
      @non_comp_issue = NonCompIssue.new(params[:non_comp_issue])
      respond_to do |format|
        if @non_comp_issue.save
          save_uploads(@non_comp_issue)
          year_start = DateTime.parse("1/1/#{Time.now.year}").strftime("%Y-%m-%d 00:00:00")
          first_this_year = NonCompIssue.find(:first, :order => :created_on, :conditions => ["created_on > '#{year_start}' and facility_id = '#{@non_comp_issue.facility_id}'"])
          mynum = (@non_comp_issue.id - first_this_year.id) + 1

          @non_comp_issue.issue_number = Time.now.month.to_s + '/' + Time.now.year.to_s + '-' + session[:facility].shortname + '-' + mynum.to_s

          @non_comp_issue.save
          flash[:notice] = 'NonCompIssue was successfully created.'
          format.html { redirect_to non_comp_issue_url(@non_comp_issue) }
          format.xml  { head :created, :location => non_comp_issue_url(@non_comp_issue) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @non_comp_issue.errors.to_xml }
        end
      end
    end
  end
  
  # PUT /non_comp_issues/1
  # PUT /non_comp_issues/1.xml
  def update
    if session[:access_level] == 'Administrator'
      @non_comp_issue = NonCompIssue.find(params[:id])
    else
      @non_comp_issue = session[:facility].non_comp_issues.find(params[:id])
    end
    
    respond_to do |format|
      if @non_comp_issue.update_attributes(params[:non_comp_issue])
        save_uploads(@non_comp_issue)
        flash[:notice] = 'NonCompIssue was successfully updated.'
        format.html { redirect_to non_comp_issue_url(@non_comp_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @non_comp_issue.errors.to_xml }
      end
    end
  end
  
  # DELETE /non_comp_issues/1
  # DELETE /non_comp_issues/1.xml
  def destroy
    @non_comp_issue = session[:facility].non_comp_issues.find(params[:id])
    @non_comp_issue.destroy
    
    respond_to do |format|
      format.html { redirect_to non_comp_issues_url }
      format.xml  { head :ok }
    end
  end


>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
