class AccountabilityLogsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
    if request.post?
      bang!
    end
  end
  
  def capture
    @category = Context.find(:all)
    @questions = Prompt.find(:all, :conditions =>  ['active = ? and context_id = ?', 1, @category[2].id])
  end
  
  def collect
    
  end
  
  def set_calendar
    session[:date] = Date.new()
    redirect_to :action => 'capture'
  end
end
