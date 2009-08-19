require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  describe "forgot_password" do
    before(:each) do
      @user = User.make
    end
    it "should set 'recently_forgot" do
      @user.forgot_password
      @user.instance_variable_get('@recently_forgot').should == true
    end
    it "should receive make_password_reset_code" do
      @user.forgot_password
      @user.password_reset_code.should_not be_nil
    end
  end
  
end