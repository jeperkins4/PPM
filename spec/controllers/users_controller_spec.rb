require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "ruby-debug"

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
  
  describe 'route generation' do
    it 'maps forgot password' do
      route_for(:controller => 'users', :action => 'forgot_password').should == '/forgot_password'
    end
  end
  
  describe "route recognition" do
    it "generates params for #forgot_password" do
      params_from(:get, "/forgot_password").should == {:controller => "users", :action => "forgot_password"}
    end
  end

end
