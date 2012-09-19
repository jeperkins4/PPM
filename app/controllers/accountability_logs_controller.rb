<<<<<<< HEAD
class AccountabilityLogsController < ApplicationController
  # GET /accountability_logs
  # GET /accountability_logs.json
  def index
    @accountability_logs = AccountabilityLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accountability_logs }
    end
  end

  # GET /accountability_logs/1
  # GET /accountability_logs/1.json
  def show
    @accountability_log = AccountabilityLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accountability_log }
    end
  end

  # GET /accountability_logs/new
  # GET /accountability_logs/new.json
  def new
    @accountability_log = AccountabilityLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accountability_log }
    end
  end

  # GET /accountability_logs/1/edit
  def edit
    @accountability_log = AccountabilityLog.find(params[:id])
  end

  # POST /accountability_logs
  # POST /accountability_logs.json
  def create
    @accountability_log = AccountabilityLog.new(params[:accountability_log])

    respond_to do |format|
      if @accountability_log.save
        format.html { redirect_to @accountability_log, notice: 'Accountability log was successfully created.' }
        format.json { render json: @accountability_log, status: :created, location: @accountability_log }
      else
        format.html { render action: "new" }
        format.json { render json: @accountability_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accountability_logs/1
  # PUT /accountability_logs/1.json
  def update
    @accountability_log = AccountabilityLog.find(params[:id])

    respond_to do |format|
      if @accountability_log.update_attributes(params[:accountability_log])
        format.html { redirect_to @accountability_log, notice: 'Accountability log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accountability_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountability_logs/1
  # DELETE /accountability_logs/1.json
  def destroy
    @accountability_log = AccountabilityLog.find(params[:id])
    @accountability_log.destroy

    respond_to do |format|
      format.html { redirect_to accountability_logs_url }
      format.json { head :no_content }
    end
  end
end
=======
class AccountabilityLogsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
    @categories = Context.paginate(:all, :order => 'position', :per_page => 1, :page => params[:category])

    if request.post?
      session[:questions] = params[:questions]
      session[:context_log] = params[:log]
      redirect_to :action => :collect
    else
      if Time.now.month >= 7 then
        session[:admin_year] ? "" : session[:admin_year] = Time.now.year
      else
        session[:admin_year] ? "" : session[:admin_year] = Time.now.year - 1
      end
    end
  end

  def set_admin_fy
    session[:admin_year] = params[:accountability_logs][:fiscal_year].to_i
    redirect_to :action => 'index'
  end
  
  def collect
    @questions = session[:questions]
    @log = session[:context_log]
    (session[:month]) ? @month = session[:month] : @month = Time.now.month
    if @month.to_i >= 7
      @year =  session[:admin_year]
    else
      @year =  session[:admin_year] + 1
    end
    @log.each_pair do | context_id, log_detail|
      @context_id = context_id
      if log_detail != "" then
        @update_log = AccountabilityLogDetails.find(:first, :conditions => ['log_year = ? and log_month = ? and context_id = ? and facility_id = ?', @year, @month, @context_id, session[:facility].id])
        unless @update_log then
          @log_details_new = AccountabilityLogDetails.new(:facility_id => session[:facility].id,
            :context_id => @context_id,
            :detail_response => log_detail,
            :log_year => @year,
            :log_month => @month,
            :created_by => session[:user]
          )
          @log_details_new.save
        else
          @update_log.update_attributes(:facility_id => session[:facility].id,
            :context_id => @context_id,
            :detail_response => log_detail,
            :log_year => @year,
            :log_month => @month,
            :created_by => session[:user]
          )
        end
      end
    end
    @not_updated = 0
    @questions.each_pair do |prompt_id, response|

      if response.split(".").to_s =~ /\A[+-]?\d+\Z/ then
        @update_response = AccountabilityLogs.find(:first, :conditions => ['log_year = ? and log_month = ? and context_id = ? and prompt_id = ? and facility_id = ?', @year, @month, @context_id, prompt_id, session[:facility].id])
        unless @update_response then
          @question_response = AccountabilityLogs.new(:facility_id => session[:facility].id,
            :context_id => @context_id,
            :prompt_id => prompt_id,
            :response => response,
            :log_year => @year,
            :log_month => @month,
            :created_by => session[:user]     
          )
          @question_response.save
        else
          @update_response.update_attributes(:facility_id => session[:facility].id,
            :context_id => @context_id,
            :prompt_id => prompt_id,
            :response => response,
            :log_year => @year,
            :log_month => @month,
            :created_by => session[:user]      
          )
        end
      else
        @not_updated += 1
      end
    end
    (@not_updated > 0) ? flash[:notice] = "The information for this category was recorded/updated. But #{@not_updated} fields not recorded/updated, count must be a number." : flash[:notice] = "The information for this category was recorded/updated. "
    redirect_to :back
  end
  
  def set_calendar
    #    unless params[:month].to_i == 12 then
    #      if params[:month].to_i == Time.now.month - 2 or params[:month].to_i == Time.now.month then
    session[:month] = params[:month]
    redirect_to :back
    #      else
    #        flash[:notice] = "The selected month has been locked by the system because it is outside the editable range."
    #        redirect_to :back
    #      end
    #    else
    #      if Time.now.month == 12 or Time.now.month == 1 then
    #        session[:month] = params[:month]
    #        redirect_to :back
    #      else
    #        flash[:notice] = "The selected month has been locked by the system because it is outside the editable range."
    #        redirect_to :back
    #      end
    #    end
  end
 
end
>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
