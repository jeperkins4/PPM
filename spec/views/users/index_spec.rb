require File.dirname(__FILE__) + '/../../spec_helper'

describe "users_index" do
  it 'should show edit functionality only for active users' do
    facility = Facility.make
    user_type = UserType.contract_manager
    assigns[:users] = [stub_model(User, :firstname => 'al',
                                      :inactive_on => nil,
                                      :user_type => user_type,
                                      :id => 1,
                                      :facility => facility),
                      stub_model(User, :firstname => 'bob',
                                      :user_type => user_type,
                                      :inactive_on => Time.now,
                                      :facility => facility,
                                      :id => 2)]

    render 'users/index'
    response.should have_tag('tr.active_flag_false td', 'bob')
    response.should_not have_tag('tr.active_flag_false td', /destroy/i)
  end

end
