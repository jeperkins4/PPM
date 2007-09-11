class LoginController < ApplicationController

  def index
    session[:user_id] = nil
    if request.post?
      user = User.authenticate( params[:name], params[:password] )
      if user
        session[:user_id] = user.id
        session[:user] = user.firstname + ' ' + user.lastname
        session[:user_type] = user.user_type.user_type
        session[:name] = user.name
        session[:access_level] = user.user_type.access_level.access_level
        session[:facility] = user.facility
        redirect_to :controller => :incidents, :action => :index
      else
        flash[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    session[:user] = nil
    session[:name] = nil
    session[:access_level] = nil
    session[:facility] = nil
   flash[:notice] = "Logged out"
   redirect_to(:action => "index")
  end
end
