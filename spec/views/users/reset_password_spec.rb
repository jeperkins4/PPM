require File.dirname(__FILE__) + '/../../spec_helper'

describe 'reset_password form' do
  it "should have a form" do
    assigns[:user] = User.make
     render 'users/reset_password'
    response.should have_tag('form') do
      with_tag 'input#user_password'
      with_tag 'input#user_password_confirmation'
    end
  end
end