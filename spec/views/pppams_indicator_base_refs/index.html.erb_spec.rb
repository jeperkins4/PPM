require 'spec_helper'

describe "/pppams_indicator_base_refs/index.html.erb" do
  include PppamsIndicatorBaseRefsHelper

  before(:each) do
    assigns[:pppams_indicator_base_refs] = WillPaginate::Collection.new(1,10).replace([
      stub_model(PppamsIndicatorBaseRef,
        :question => "value for question",
        :pppams_category_base_ref_id => 1
      ),
      stub_model(PppamsIndicatorBaseRef,
        :question => "value for question",
        :pppams_category_base_ref_id => 1
      )
    ])
  end

  it "renders a list of pppams_indicator_base_refs" do
    render
    response.should have_tag("tr>td", "value for question".to_s, 2)
  end
  it  'should use pictures for actions' do
    render
    response.should have_tag('a[href*=/pppams_indicator_base_refs] img')
  end
end
