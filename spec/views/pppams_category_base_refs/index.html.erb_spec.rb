require 'spec_helper'

describe "/pppams_category_base_refs/index.html.erb" do

  before(:each) do
    assigns[:pppams_category_base_refs] = WillPaginate::Collection.new(1,10).replace([
      stub_model(PppamsCategoryBaseRef,
        :name => "value for name",
        :pppams_category_group => stub_model(PppamsCategoryGroup, :id => 1, :name => 'hi')
      ),
      stub_model(PppamsCategoryBaseRef,
        :name => "value for name",
        :pppams_category_group => stub_model(PppamsCategoryGroup, :id => 1, :name => 'hi')
      )
    ])
  end

  it "renders a list of pppams_category_base_refs" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 'hi', 2)
  end
  it  'should use pictures for actions' do
    render
    response.should have_tag('a[href*=/pppams_category_base_refs] img')
  end
end
