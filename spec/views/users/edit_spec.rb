require File.dirname(__FILE__) + '/../../spec_helper'

describe "users/edit" do
  before(:each) do
    @user = stub_model(User, 
                       :firstname => 'al',
                       :lastname => 'bundy',
                       :name => 'al bundy',
                       :user_type => UserType.make,
                       :facility => Facility.make)
    assigns[:user] = @user
  end
  it 'should have active/inactive fields' do
    render 'users/edit'
    response.should have_tag('input#user_inactive_comment')
  end
end
