require 'spec_helper'

describe "/pppams_indicator_base_refs/show.html.erb" do
  include PppamsIndicatorBaseRefsHelper
  before(:each) do
    assigns[:pppams_indicator_base_ref] = @pppams_indicator_base_ref = stub_model(PppamsIndicatorBaseRef,
      :question => "value for question",
      :pppams_category_base_ref => stub_model(PppamsCategoryBaseRef, :id => 1, :name => 'hi', :to_s => 'hi'),
      :inactive_on => nil
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ question/)
    response.should have_text(/1/)
  end
  it 'should render the category name' do
    render
    response.should have_text(/hi/)
  end
  it 'should show still active when the category is active' do
    render
    response.should have_text(/still active/i)
  end
end
