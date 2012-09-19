require 'spec_helper'

describe "/pppams_references/edit.rhtml" do

  before(:each) do
    assigns[:pppams_reference] = @pppams_references = stub_model(PppamsReference,
      :new_record? => false,
      :name => "value for name",
      :url => "value for url",
      :id => 1
    )
  end

  it "renders the edit pppams_references form" do
    render

    response.should have_tag("form[action=#{pppams_reference_path(@pppams_references)}][method=post]") do
      with_tag('input#pppams_reference_name[name=?]', "pppams_reference[name]")
      with_tag('input#pppams_reference_url[name=?]', "pppams_reference[url]")
    end
  end
end
