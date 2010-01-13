require File.dirname(__FILE__) + '/../../spec_helper'

describe "edit" do
  before(:each) do
    assigns[:pppams_indicator] = stub(:id => 1,
                                      :question => 'inmates behaved',
                                      :frequency => 1,
                                      :start_month => 5,
                                      :pppams_reference_ids => nil,
                                      :errors => [],
                                      :pppams_category_id => 3)

  end
  it "should show the question, but not allow editing" do
    render 'pppams_indicators/edit'
    response.should have_text /inmates behaved/
    response.should_not have_tag('textarea[id=pppams_indicator_question]')
  end
end
