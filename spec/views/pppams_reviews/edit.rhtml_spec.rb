require File.dirname(__FILE__) + '/../../spec_helper'

describe "pppams_reviews/edit" do
  before(:each) do
    @status_ar =  ['', 'Review','Accepted'] # i.e. the status 'locked' should be disabled.
    @pppams_review= mock_model(PppamsReview,
                                   :status => 'Review',
                                   :notes => 'Hello notes',
                                   :score => 7,
                                   :documentation_ref => 'my documentation',
                                   :interview_ref => 'my interview',
                                   :submitted_count => 0,
                                   :observation_ref => 'my observation',
                                   :pppams_indicator_id => 98,
                                   :created_on => Time.now,
                                   :uploads => [stub(:id => 3,
                                                     :name => 'my upload',
                                                     :file_type => 'application/pdf',
                                                     'blank?' => false)])
    @pppams_indicator = mock_model(PppamsIndicator,
                                     :question => 'my question')

    assigns[:pppams_indicator] = @pppams_indicator
    assigns[:status_ar] = @status_ar
    assigns[:pppams_review] = @pppams_review
    render 'pppams_reviews/edit'
  end

  it "should allow selection and preselect the current status" do
    response.should have_tag("input[type='radio'][checked='checked'][name='pppams_review[status]'][value='Review']")
  end
  it "should allow selection and preselect the current status" do
    response.should have_tag("input[type='radio'][disabled='disabled'][name='pppams_review[status]'][value='Locked']")
  end
  it "should show the notes in a text area" do
    response.should have_tag("textarea", /Hello notes/)
  end
  it "should show the documentation ref in a text area" do
    response.should have_tag("textarea", /my documentation/)
  end
  it "should show the interview ref in a text area" do
    response.should have_tag("textarea", /my interview/)
  end
  it "should show the observation ref in a text area" do
    response.should have_tag("textarea", /my observation/)
  end
  it "should include the indicator question" do
    response.should have_text(/my question/)
  end

end
