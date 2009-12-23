require 'spec_helper'

describe "/pppams_indicator_base_refs/new.html.erb" do
  include PppamsIndicatorBaseRefsHelper

  before(:each) do
    assigns[:pppams_indicator_base_ref] = stub_model(PppamsIndicatorBaseRef,
      :new_record? => true,
      :question => "value for question",
      :pppams_category_base_ref_id => 1
    )
  end

  it "renders new pppams_indicator_base_ref form" do
    render

    response.should have_tag("form[action=?][method=post]", pppams_indicator_base_refs_path) do
      with_tag("input#pppams_indicator_base_ref_question[name=?]", "pppams_indicator_base_ref[question]")
      with_tag("input#pppams_indicator_base_ref_pppams_category_base_ref_id[name=?]", "pppams_indicator_base_ref[pppams_category_base_ref_id]")
    end
  end
end
