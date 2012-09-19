class LoginController < ApplicationController

  def index
    session[:user_id] = nil
    if request.post?
      user = User.authenticate( params[:name], params[:password] )
      setup_session(user) do
        redirect_to :controller => :incidents, :action => :index
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
