class AccountabilityLogsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
     @category_pages, @categories = paginate :context, :per_page => 1
  end
  
  def set_category
    #(params[:context].nil?) ? @category = session[:contexts].first : @category = Context.find(:all, :conditions => ["id = ?", params[:context]])
     (@area.lower_item.nil?) ? redirect_to(:action => 'index') : redirect_to(:action => :capture, :context => @context.lower_item.id)  
  end
  
  def capture
     redirect_to @category_pages.current.next if @category_pages.current.next
  end
  
  def collect
    
  end
  
  def set_calendar
    session[:date] = Date.new()
    session[:category] = Context.find(:all)
    redirect_to :action => :capture
  end
end
