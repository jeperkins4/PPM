require 'spec_helper'

describe "/pppams_references/new.rhtml" do
  include PppamsReferencesHelper

  before(:each) do
    assigns[:pppams_reference] = stub_model(PppamsReference,
      :new_record? => true,
      :name => "value for name",
      :url => "value for url"
    )
  end

  it "renders new pppams_references form" do
    render

    response.should have_tag("form[action=/pppams_references][method=post]") do
      with_tag("input#pppams_reference_name[name=?]", "pppams_reference[name]")
      with_tag("input#pppams_reference_url[name=?]", "pppams_reference[url]")
    end
  end
end
