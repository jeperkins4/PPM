class ComplaintsController < ApplicationController

  before_filter :authenticate
  
  layout 'administration'
  # GET /complaints.xml
  def index
    session[:complaint_status] = params[:complaint_status] unless params[:complaint_status].nil?
    @complaint_status = session[:complaint_status].nil? ?  "2" : session[:complaint_status]

    @status_ar_st = (@complaint_status.to_i == 3) ? "3" : (0..@complaint_status.to_i).to_a

    @complaint_pages, @complaints = paginate :complaint, 
    :order => 'received_date',
    :per_page => 20,
    :conditions => ['complaint_status in (?) and facility_id = ?', @status_ar_st, session[:facility].id ]
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @complaints.to_xml }
    end
  end
  
  # GET /complaints/1
  # GET /complaints/1.xml
  def show
    @complaint = Complaint.find(params[:id])
    @complaint_follow_ups = @complaint.complaint_follow_ups.find(:all)
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @complaint.to_xml }
    end
  end
  
  # GET /complaints/new
  def new
    @complaint = Complaint.new
  end
  
  # GET /complaints/1;edit
  def edit
    @complaint = Complaint.find(params[:id])
  end
  
  # POST /complaints
  # POST /complaints.xml
  def create

    params[:complaint][:facility_id] = session[:facility].id

    @complaint = Complaint.new(params[:complaint])

    respond_to do |format|
      if @complaint.save
        year_start = DateTime.parse("1/1/#{Time.now.year}").strftime("%Y-%m-%d 00:00:00")
        first_this_year = Complaint.find(:first, :order => :created_on, :conditions => ["created_on > '#{year_start}' and facility_id = '#{@complaint.facility_id}'"])
        mynum = (@complaint.id - first_this_year.id) + 1
        @complaint.complaint_number = Time.now.month.to_s + '/' + Time.now.year.to_s + '-' + session[:facility].shortname + '-' + mynum.to_s
        @complaint.save
        flash[:notice] = 'Complaint was successfully created.'
        format.html { redirect_to complaint_url(@complaint) }
        format.xml  { head :created, :location => complaint_url(@complaint) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @complaint.errors.to_xml }
      end
    end
  end
  
  # PUT /complaints/1
  # PUT /complaints/1.xml
  def update
    if session[:access_level] == 'Administrator'
      @complaint = Complaint.find(params[:id])
    else
      @complaint = session[:facility].complaints.find(params[:id])
    end

    respond_to do |format|
      if @complaint.update_attributes(params[:complaint])
        flash[:notice] = 'Complaint was successfully updated.'
        format.html { redirect_to complaint_url(@complaint) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @complaint.errors.to_xml }
      end
    end
  end
  
  # DELETE /complaints/1
  # DELETE /complaints/1.xml
  def destroy
    @complaint = session[:facility].complaints.find(params[:id])
    @complaint.destroy
    
    respond_to do |format|
      format.html { redirect_to complaints_url }
      format.xml  { head :ok }
    end
  end


end
