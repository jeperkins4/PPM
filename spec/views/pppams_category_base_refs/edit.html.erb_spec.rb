require 'spec_helper'

describe "/pppams_category_base_refs/edit.html.erb" do

  before(:each) do
    assigns[:pppams_category_base_ref] = @pppams_category_base_ref = stub_model(PppamsCategoryBaseRef,
      :new_record? => false,
      :name => "value for name",
      :pppams_category_group_id => 1,
      :id => 123,
      :pppams_indicator_base_refs => [stub_model(PppamsIndicatorBaseRef, :question => 'q1', :id => 5)]
    )
    assigns[:pppams_category_groups] = [['hello', 1]]
    assigns[:facilities_with_base] = [stub_model(Facility, :facility => 'rand fac', :id => 1)]
    assigns[:user] = mock_model(User, 'is_admin?' => true)
  end

  it "renders the edit pppams_category_base_ref form" do
    render

    response.should have_tag("form[action=#{pppams_category_base_ref_path(@pppams_category_base_ref)}][method=post]") do
      with_tag('input#pppams_category_base_ref_name[name=?]', "pppams_category_base_ref[name]")
      with_tag('select#pppams_category_base_ref_pppams_category_group_id[name=?]', "pppams_category_base_ref[pppams_category_group_id]")
    end
  end
  it "renders facilities that use this overall indicator" do
    render
    response.should have_tag("li", /rand fac/)
  end
  it 'renders indicator base references' do
    render
    response.should have_tag('td', 'q1')
  end

end
