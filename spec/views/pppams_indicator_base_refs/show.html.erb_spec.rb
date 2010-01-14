require 'spec_helper'

describe "/pppams_indicator_base_refs/show.html.erb" do
  include PppamsIndicatorBaseRefsHelper
  before(:each) do
    assigns[:pppams_indicator_base_ref] = @pppams_indicator_base_ref = stub_model(PppamsIndicatorBaseRef,
      :question => "value for question",
      :pppams_category_base_ref => stub_model(PppamsCategoryBaseRef, :id => 1, :name => 'hi', :to_s => 'hi')
    )
    assigns[:facilities] = @facs = {1 => {:name => 'fac_name',
                                          :active => true,
                                          :active_on => '2008-01-01',
                                          :indicator_id => 1}
                                   }
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ question/)
    response.should have_text(/1/)
  end
  it 'should render the category name' do
    render
    response.should have_text(/hi/)
  end
  it 'should show a list of facilities for which this is used' do
    render
    response.should have_tag('table') do 
      with_tag('td', 'fac_name')
      with_tag('td', 'Active')
      with_tag('td', '2008-01-01')
    end
  end
end
