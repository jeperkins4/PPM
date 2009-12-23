require 'spec_helper'

describe "/pppams_category_base_refs/index.html.erb" do
  include PppamsCategoryBaseRefsHelper

  before(:each) do
    assigns[:pppams_category_base_refs] = [
      stub_model(PppamsCategoryBaseRef,
        :name => "value for name",
        :pppams_category_group_id => 1
      ),
      stub_model(PppamsCategoryBaseRef,
        :name => "value for name",
        :pppams_category_group_id => 1
      )
    ]
  end

  it "renders a list of pppams_category_base_refs" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
