require 'spec_helper'

describe "/pppams_indicator_base_refs/index.html.erb" do
  include PppamsIndicatorBaseRefsHelper

  before(:each) do
    assigns[:pppams_indicator_base_refs] = [
      stub_model(PppamsIndicatorBaseRef,
        :question => "value for question",
        :pppams_category_base_ref_id => 1
      ),
      stub_model(PppamsIndicatorBaseRef,
        :question => "value for question",
        :pppams_category_base_ref_id => 1
      )
    ]
  end

  it "renders a list of pppams_indicator_base_refs" do
    render
    response.should have_tag("tr>td", "value for question".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
