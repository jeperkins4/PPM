require File.dirname(__FILE__) + '/../../spec_helper'

describe 'forgot_password form' do
  it "should have a form" do
     render 'users/forgot_password'
    response.should have_tag('form') do
      with_tag 'input'
    end
    
    
  end
end