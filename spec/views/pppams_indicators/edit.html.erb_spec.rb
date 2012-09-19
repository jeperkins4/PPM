require File.dirname(__FILE__) + '/../../spec_helper'

describe "edit" do
  before(:each) do
    assigns[:pppams_indicator] = stub(:id => 1,
                                      :question => 'inmates behaved',
                                      :frequency => 1,
                                      :start_month => 5,
                                      :pppams_reference_ids => nil,
                                      :errors => [],
                                      :pppams_category_id => 3,
                                      :facility_id => 3,
                                      :pppams_indicator_base_ref_id => 3,
                                      :pppams_indicator_base_ref => mock_model(PppamsIndicatorBaseRef, :id => 32)
                                     )

  end
  it "should show the question, but not allow editing" do
    render 'pppams_indicators/edit'
    response.should have_text /inmates behaved/
    response.should_not have_tag('textarea[id=pppams_indicator_question]')
  end
  it "should have a link back to the global indicator" do
    render 'pppams_indicators/edit'
    puts response.body
    response.should have_tag(["a[href=?]",edit_pppams_indicator_base_ref_path(32)])
  end
end
