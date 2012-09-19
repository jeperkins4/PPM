require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'login view' do
  it "should have a link to 'forgot  password" do
    render 'login/index'
    response.should have_tag('a') 
  end
end