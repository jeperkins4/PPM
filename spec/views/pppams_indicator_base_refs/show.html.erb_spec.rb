require 'spec_helper'

describe "/pppams_indicator_base_refs/show.html.erb" do
  include PppamsIndicatorBaseRefsHelper
  before(:each) do
    assigns[:pppams_indicator_base_ref] = @pppams_indicator_base_ref = stub_model(PppamsIndicatorBaseRef,
      :question => "value for question",
      :pppams_category_base_ref_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ question/)
    response.should have_text(/1/)
  end
  it 'should render the category name'
end
