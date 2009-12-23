require 'spec_helper'

describe "/pppams_references/show.rhtml" do
  include PppamsReferencesHelper
  before(:each) do
    assigns[:pppams_reference] = @pppams_reference = stub_model(PppamsReference,
      :name => "value for name",
      :url => "value for url"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ url/)
  end
end
