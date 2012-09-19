require File.dirname(__FILE__) + '/../../spec_helper'

describe "pppams_indicators/show" do
  it "shold display an indicator's field data" do
    indicator = mock_model(PppamsIndicator, :id => 123456,
                                            :frequency => '12',
                                            :start_month => '3',
                                            :created_on => Time.now,
                                            :updated_on => Time.now,
                                            :inactive_on => nil,
                                            :active_on => Date.yesterday,
                                            :good_months => ":1:2:3",
                                            :pppams_references => [stub(:html =>'ref text')])
    assigns[:pppams_indicator] = indicator
    assigns[:user] = stub('is_admin?' => false)
    render 'pppams_indicators/show'
    response.should have_text(/frequency.*12/i)
    response.should have_text(/start month.*3/i)
    response.should have_text(/good months.*:1:2:3/i)
    response.should have_text(/ref text/i)
  end
end
