<<<<<<< HEAD
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
=======
class PppamsIssuesController < ApplicationController

  before_filter :authenticate
  
  layout 'administration_with_all'
  # GET /pppams_issues.xml
  def index
    session[:pppams_issue_status] = params[:pppams_issue_status] unless params[:pppams_issue_status].nil?
    @pppams_issue_status = session[:pppams_issue_status].nil? ?  "2" : session[:pppams_issue_status]

    @status_ar_st = (@pppams_issue_status.to_i == 3) ? "3" : (0..@pppams_issue_status.to_i).to_a
    
    condition_ar = session[:facility].class.to_s == 'Junk' ? ['pppams_issue_status in (?)', @status_ar_st ]: ['pppams_issue_status in (?) and facility_id = ?', @status_ar_st, session[:facility].id ]

    @pppams_issues = PppamsIssue.paginate :page => params[:page],
      :order => "facility_id, received_date",
      :per_page => 20,
      :conditions => condition_ar
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @pppams_issues.to_xml }
    end
  end
  
  # GET /pppams_issues/1
  # GET /pppams_issues/1.xml
  def show
    @pppams_issue = PppamsIssue.find(params[:id])
    @pppams_issue_follow_ups = @pppams_issue.pppams_issue_follow_ups.find(:all)
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @pppams_issue.to_xml }
    end
  end
  
  # GET /pppams_issues/new
  def new
    redirect_to :action => :index if session[:facility].class.to_s == 'Junk'
    @pppams_issue = PppamsIssue.new
  end
  
  # GET /pppams_issues/1;edit
  def edit
    @pppams_issue = PppamsIssue.find(params[:id])
  end
  
  # POST /pppams_issues
  # POST /pppams_issues.xml
  def create

    params[:pppams_issue][:facility_id] = session[:facility].id

    @pppams_issue = PppamsIssue.new(params[:pppams_issue])
    
    if session[:facility].shortname.nil?
        flash[:notice] = 'Data could not be saved! This facility does not have a short name in the database. Please contact a system administrator.'
        redirect_to "/pppams_issues" 
    else

      respond_to do |format|
        if @pppams_issue.save
          year_start = DateTime.parse("1/1/#{Time.now.year}").strftime("%Y-%m-%d 00:00:00")
          first_this_year = PppamsIssue.find(:first, :order => :created_on, :conditions => ["created_on > '#{year_start}' and facility_id = '#{@pppams_issue.facility_id}'"])
          mynum = (@pppams_issue.id - first_this_year.id) + 1
          @pppams_issue.pppams_issue_number = Time.now.month.to_s + '/' + Time.now.year.to_s + '-' + session[:facility].shortname + '-' + mynum.to_s
          @pppams_issue.save
          flash[:notice] = 'PppamsIssue was successfully created.'
          format.html { redirect_to pppams_issue_url(@pppams_issue) }
          format.xml  { head :created, :location => pppams_issue_url(@pppams_issue) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @pppams_issue.errors.to_xml }
        end
      end
    
    end
  end
  
  # PUT /pppams_issues/1
  # PUT /pppams_issues/1.xml
  def update
    if session[:access_level] == 'Administrator'
      @pppams_issue = PppamsIssue.find(params[:id])
    else
      @pppams_issue = session[:facility].pppams_issues.find(params[:id])
    end

    respond_to do |format|
      if @pppams_issue.update_attributes(params[:pppams_issue])
        flash[:notice] = 'PppamsIssue was successfully updated.'
        format.html { redirect_to pppams_issue_url(@pppams_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pppams_issue.errors.to_xml }
      end
    end
  end
  
  # DELETE /pppams_issues/1
  # DELETE /pppams_issues/1.xml
  def destroy
    @pppams_issue = session[:facility].pppams_issues.find(params[:id])
    @pppams_issue.destroy
    
    respond_to do |format|
      format.html { redirect_to pppams_issues_url }
      format.xml  { head :ok }
    end
  end


end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
