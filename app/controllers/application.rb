# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_privateprison_session_id'
  
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
end
