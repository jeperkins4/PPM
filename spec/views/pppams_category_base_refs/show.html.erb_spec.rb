require 'spec_helper'

describe "/pppams_category_base_refs/show.html.erb" do
  include PppamsCategoryBaseRefsHelper
  before(:each) do
    assigns[:pppams_category_base_ref] = @pppams_category_base_ref = stub_model(PppamsCategoryBaseRef,
      :name => "value for name",
      :pppams_category_group => stub_model(PppamsCategoryGroup, :id => 1, :to_s => 'hi')
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
  end
  it 'should render the category group name' do
    render
    response.should have_text(/hi/)
  end
end
