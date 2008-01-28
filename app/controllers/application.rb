# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_privateprison_session_id'
  before_filter :set_page
  before_filter :set_facility, :except => ''
  
  def admin_authenticate
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      unless @user.user_type.access_level.id == 1
        flash[:notice]="You are not authorized to view this area."
        redirect_to(:controller => "login", :action => "index")
      end
    else
      flash[:notice]="Please log in."
      redirect_to(:controller => "login", :action => "index")
    end
  end
  
  def authenticate
    unless User.find_by_id(session[:user_id])
      flash[:notice]="Please log in."
      redirect_to(:controller => "login", :action => "index")
    end
  end
  
  def set_facility
    if session[:access_level] == 'Administrator'
      unless params[:set_facility] 
        unless session[:facility]
          @page_check = 0
          @page_check2 = 0
          ['facilities',
            'users',
            'custody_types',
            'action_types',
            'access_levels',
            'user_types',
            'login',
            'incident_types',
            'position_hists',
            'position_types',          
            'incident_classes',
            'reset_password',
            'contexts',
            'prompts'].each do |page_check|
            request.request_uri.split('/').each do |page|
              page.split('?').each do |page2|
                if page2.to_s == page_check
                  @page_check += 1
                end
              end 
            end
          end
          if @page_check == 0
            render :text => "Please select a facility from the drop down above to continue.", :layout => true
          end
        end
      else
        if params[:set_facility][:facility_id] != ""
          session[:facility] = Facility.find(params[:set_facility][:facility_id])
          redirect_to(:controller => request.request_uri.split('/'), :action => 'index')
        else
          session[:facility] = nil
          render :text => "Please select a facility from the drop down above to continue.", :layout => true
        end
      end      
    end      
  end 
  
  def set_page
    @host = request.host
    @page = request.request_uri.split('?')
  end
  
  def paginate_collection(collection, options = {})
    default_options = {:per_page => 100, :page => 1}
    options = default_options.merge options

    pages = Paginator.new self, collection.size, options[:per_page], options[:page]
    first = pages.current.offset
    last = [first + options[:per_page], collection.size].min
    slice = collection[first...last]
    return [pages, slice]
  end

end
