class UsersController < ApplicationController
  before_filter :admin_authenticate, :except => [:reset_from_code, :forgot_password, :reset_password]
  before_filter :authenticate, :only => [:reset_password]
  layout 'administration'
  
  def index
    @users = User.find(:all)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @users.to_xml }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # GET /users/1;edit
  def edit
    @user = User.find(params[:id])
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to user_url(@user) }
        format.xml  { head :created, :location => user_url(@user) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to user_url(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors.to_xml }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.xml  { head :ok }
    end
  end
  
  def reset_password
    @hide_search_div = true
    @user = User.find(session[:user_id])
    if request.put? && @user && params[:user]
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        flash[:notice] = 'Password was successfully updated.'
        redirect_to incidents_path
      else
        flash[:notice] = 'Unable to save the new password.'
      end
    end
  end
  
  def reset_from_code
   @hide_search_div = true
   if params[:password_reset_code]
      @user = User.find_by_password_reset_code(params[:password_reset_code])
      if @user
         setup_session(@user)
         redirect_to :action => 'reset_password'
      else
        flash[:notice] = "Could not find the given password reset code. 
          Please check that you used the full web address from the email we sent you. 
          If the problem persists, please contact the application support group."
        redirect_to(:controller => 'login', :action => "index")
      end
    else
      redirect_to :controller => 'login', :action => 'index'
      flash[:notice] = 'You are not authorized to view this area.'
    end
  end
  
  def forgot_password
    unless request.put?
      @hide_search_div = true
      @user = User.new
      render :action => 'forgot_password', :layout => 'application'
    else
      begin
        @hide_search_div = true
        @user = User.find_by_name(params[:user][:name])
        @user.forgot_password
        @user.save
        flash[:notice] = "An email was sent to #{@user.email} with a link you can use to reset your password."
        render :template => 'login/index', :layout => 'application'
      rescue
        flash[:notice] = "We were not able to find your username. If you are sure you entered the correct username, please contact us at <a href='mailto:#{APP_CONFIG['support_email']}'>#{APP_CONFIG['support_email']}</a>"
      end
    end
  end

end
