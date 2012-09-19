require File.dirname(__FILE__) + '/../../spec_helper'

describe "new" do
  before(:each) do
    assigns[:pppams_indicator] = stub(
                                      :question => 'inmates behaved',
                                      :pppams_reference_ids => nil,
                                      :facility_id => 5,
                                      :errors => [],
                                      :frequency => nil,
                                      :start_month => nil,
                                      :pppams_indicator_base_ref_id => 32
                                     )

  end
  it "should show the question, but not allow newing" do
    render 'pppams_indicators/new'
    response.should have_text /inmates behaved/
    response.should_not have_tag('textarea[id=pppams_indicator_question]')
  end
  it "should have a link back to the global indicator" do
    render 'pppams_indicators/new'
    response.should have_tag("a",'Back')
  end
  it "should have a link back to the global indicator" do
    render 'pppams_indicators/new'
    response.should have_tag("input[type='hidden'][name='pppams_indicator[facility_id]'][value='5']")
  end

end
