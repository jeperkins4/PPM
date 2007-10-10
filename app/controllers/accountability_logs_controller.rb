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
    #bang!
    @questions = session[:questions]
    @log = session[:context_log]
    #redirect_to params[:category]
  end

  def set_calendar
    session[:date] = Date.new()
    session[:category] = Context.find(:all)
    redirect_to :action => :capture
  end
end
