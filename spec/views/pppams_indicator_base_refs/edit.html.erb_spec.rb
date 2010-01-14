require 'spec_helper'

describe "/pppams_indicator_base_refs/edit.html.erb" do
  include PppamsIndicatorBaseRefsHelper

  before(:each) do
    assigns[:pppams_indicator_base_ref] = @pppams_indicator_base_ref = stub_model(PppamsIndicatorBaseRef,
      :new_record? => false,
      :question => "value for question",
      :pppams_category_base_ref_id => 1,
      :id => 1
    )
    assigns[:pppams_category_base_refs] = [['hello', 1]]
    assigns[:facilities] = {1 => {:active => true, :name => 'active', :indicator_id => 23},
                            2 => {:active => false, :name => 'inactive', :indicator_id => 25}
                           }
  end

  it "renders the edit pppams_indicator_base_ref form" do
    render

    response.should have_tag("form[action=#{pppams_indicator_base_ref_path(@pppams_indicator_base_ref)}][method=post]") do
      with_tag('textarea#pppams_indicator_base_ref_question[name=?]', "pppams_indicator_base_ref[question]")
      with_tag('select#pppams_indicator_base_ref_pppams_category_base_ref_id[name=?]', "pppams_indicator_base_ref[pppams_category_base_ref_id]")
    end
  end
  it "renders facilities that use this overall indicator" do
    render
    response.should have_tag("td", /active/i)
    response.should have_tag("td", /inactive/i)
  end
  it "renders links to facility indicators" do
    render
    response.should have_tag(["a[href=?]", edit_pppams_indicator_path(23)])
    response.should_not have_tag(["a[href=?]", edit_pppams_indicator_path(25)])
  end

end
