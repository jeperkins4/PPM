require 'spec_helper'

describe "/pppams_category_base_refs/new.html.erb" do
  include PppamsCategoryBaseRefsHelper

  before(:each) do
    assigns[:pppams_category_base_ref] = stub_model(PppamsCategoryBaseRef,
      :new_record? => true,
      :name => "value for name",
      :pppams_category_group_id => 1
    )
  end

  it "renders new pppams_category_base_ref form" do
    render

    response.should have_tag("form[action=?][method=post]", pppams_category_base_refs_path) do
      with_tag("input#pppams_category_base_ref_name[name=?]", "pppams_category_base_ref[name]")
      with_tag("input#pppams_category_base_ref_pppams_category_group_id[name=?]", "pppams_category_base_ref[pppams_category_group_id]")
    end
  end
end
