class AccountabilityLogsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
    @category_pages, @categories = paginate :context, :per_page => 1
    if request.post?
      session[:questions] = params[:questions]
      session[:context_log] = params[:log]
      redirect_to :action => :collect
    end
  end
  
  def collect
    @questions = session[:questions]
    @log = session[:context_log]
     (session[:month]) ? @month = session[:month] : @month = Time.now.month
    @year = Time.now.year
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
      if response.to_s =~ /\A[+-]?\d+\Z/ then
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
    if params[:month].to_i == Time.now.month - 1 or params[:month].to_i == Time.now.month then
      session[:month] = params[:month]
      redirect_to :back
    else
      flash[:notice] = "The selected month has been locked by the system because it is outside the editable range."
      redirect_to :back
    end
  end
end
