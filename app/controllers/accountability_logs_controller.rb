class AccountabilityLogsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
    unless request.post?
      @category_pages, @categories = paginate :context, :per_page => 1
    else
      collect
    end
  end
  
  def set_category
    #(params[:context].nil?) ? @category = session[:contexts].first : @category = Context.find(:all, :conditions => ["id = ?", params[:context]])
     (@area.lower_item.nil?) ? redirect_to(:action => 'index') : redirect_to(:action => :capture, :context => @context.lower_item.id)  
  end
  
  def capture
    
  end
  
  def collect
    redirect_to params[:category]
  end

  def set_calendar
    session[:date] = Date.new()
    session[:category] = Context.find(:all)
    redirect_to :action => :capture
  end
end
