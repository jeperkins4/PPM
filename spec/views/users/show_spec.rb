require File.dirname(__FILE__) + '/../../spec_helper'

describe "users/show" do
  before(:each) do
    @time = Time.now
    @user = stub_model(User, 
                       :firstname => 'al',
                       :lastname => 'bundy',
                       :name => 'al bundy',
                       :inactive_on => @time,
                       :inactive_comment => 'hiho',
                       :user_type => UserType.contract_manager,
                       :facility => Facility.make)
    assigns[:user] = @user
  end
  it 'should have active/inactive fields' do
    render 'users/show'
    response.should have_text(/#{@time.to_s}/)
    response.should have_text(/#{@inactive_comment}/)
  end
end
