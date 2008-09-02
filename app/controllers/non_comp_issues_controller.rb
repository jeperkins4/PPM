class NonCompIssuesController < ApplicationController

  before_filter :authenticate
  
  layout 'administration'
  # GET /non_comp_issues.xml
  def index
    if params[:nci_status]
      session[:nci_status] = params[:nci_status]
    end
    @nci_status = session[:nci_status] ? session[:nci_status] :  "0"
    @status_ar_st = (@nci_status.to_i == 5) ? "5" : (0..@nci_status.to_i).to_a
    @non_comp_issue_pages, @non_comp_issues = paginate :non_comp_issue, 
    :order => 'discovery_date',
    :per_page => 20,
    :conditions => ['nci_status in (?) and facility_id = ?', @status_ar_st, session[:facility].id]
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @non_comp_issues.to_xml }
    end
    
  end
  
  # GET /non_comp_issues/1
  # GET /non_comp_issues/1.xml
  def show
    @non_comp_issue = NonCompIssue.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @non_comp_issue.to_xml }
    end
  end
  
  # GET /non_comp_issues/new
  def new
    @non_comp_issue = NonCompIssue.new
  end
  
  # GET /non_comp_issues/1;edit
  def edit
    @non_comp_issue = NonCompIssue.find(params[:id])
  end
  
  # POST /non_comp_issues
  # POST /non_comp_issues.xml
  def create
    @non_comp_issue = NonCompIssue.new(params[:non_comp_issue])
    respond_to do |format|
      if @non_comp_issue.save
        flash[:notice] = 'NonCompIssue was successfully created.'
        format.html { redirect_to non_comp_issue_url(@non_comp_issue) }
        format.xml  { head :created, :location => non_comp_issue_url(@non_comp_issue) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @non_comp_issue.errors.to_xml }
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


end
