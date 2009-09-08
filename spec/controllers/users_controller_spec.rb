require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  integrate_views
  describe 'forgot_password' do
    it "should render the forgot password form" do
      get :forgot_password
      response.should render_template 'users/forgot_password'
    end
    describe "put with valid params" do
      it "should render login page" do
        user = User.make
        put :forgot_password, :user => {:name => user.name}
        response.should render_template('login/index')
      end
      it "should set 'recently_forgot' to true" do
        user = User.make
        put :forgot_password, :user => {:name => user.name}
        assigns[:hide_search_div].should == true
      end
      it "should find a user and assign it to @user" do
        user = User.make
        put :forgot_password, :user => {:name => user.name}
        assigns[:user].should == user
      end
      it "should set the user's password_reset_code user" do
        user = User.make
        put :forgot_password, :user => {:name => user.name}
        assigns[:user].password_reset_code.should_not be_nil
      end
    end
    describe "put with invalid params" do
      it "should render the same page with an error message" do
        put :forgot_password, :user => {:name => '@#$<'}
        flash[:notice].should match(/We were not able to find your username/)
        response.should render_template(:forgot_password)
      end
    end
  end
  describe "reset_password" do
    before do
      @user = User.make
      @user.save
    end
    describe 'GET' do
      it "without a current session should redirect to home" do
        get :reset_password
        response.should redirect_to '/'  
      end
       it "with a session should be success" do
         session[:user_id] = @user.id
         get :reset_password
         response.should be_success
      end
    end
    describe "PUT" do
      it 'without a current session should redirect to home' do
        put :reset_password, :user => {:password => 'aoeuao', :password_confirmation => 'aoeuao'}
        response.should redirect_to '/'
      end
      describe "with session and valid params" do
        it "should redirect to the incidents path" do
          session[:user_id] = @user.id
          session[:facility] = @user.facility_id
          put :reset_password, :user => {:password => 'aoeuao', :password_confirmation => 'aoeuao'}
          response.should redirect_to incidents_path
        end
      end
      describe "with session and invalid params" do
        it "should render itself" do
          session[:user_id] = @user.id
          session[:facility] = @user.facility_id
          put :reset_password, :password => 'aoeuao'
          response.should be_success
          response.should render_template('users/reset_password')        
        end
        it "should show the error that occured" do
          session[:user_id] = @user.id
          put :reset_password, :user => {:password => 'aoeuao', :password_confirmation => '21222'}
          response.body.should =~ /match confirmation/
        end
        it "should show the error that occured" do
          session[:user_id] = @user.id
          put :reset_password, :invalid_param => 'aoeuao'
          response.body.should =~ /new password/i
        end
      end
    end
  end
  describe "reset_from_code" do
    before do
      @user = User.make
      @user.send(:make_password_reset_code)
      @user.save
    end
    describe 'GET' do
      it "should accept a previously generated password_reset_code" do
        get :reset_from_code, :password_reset_code => @user.password_reset_code
        response.should redirect_to '/reset_password' do      
          response.should have_tag("form") 
        end
      end
      it "should login the user if the password reset code is valid" do
        get :reset_from_code, :password_reset_code => @user.password_reset_code
        session[:user_id].should == @user.id
      end
      it "should not accept an invalid password_reset_code" do
        get :reset_from_code, :password_reset_code => 'aaaaaaaaaa'
        assigns[:flash][:notice].should have_text /not find/
        response.should redirect_to(start_path)            
      end
    end
  end
  describe 'route generation' do
    it 'maps forgot password' do
      route_for(:controller => 'users', :action => 'forgot_password').should == '/forgot_password'
    end
    it 'maps reset password' do
      route_for(:controller => 'users', :action => 'reset_password').should == '/reset_password'
    end
  end
  describe "route recognition" do
    it "generates params for #forgot_password" do
      params_from(:get, "/forgot_password").should == {:controller => "users", :action => "forgot_password"}
    end
    it "generates params for #reset_password" do
      params_from(:get, "/reset_from_code/aoeu").should == {:controller => "users", :action => "reset_from_code", :password_reset_code => "aoeu"}
    end
  end

end
