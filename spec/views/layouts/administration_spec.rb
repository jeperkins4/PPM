require File.dirname(__FILE__) + '/../../spec_helper'
describe 'layouts/administration.rhtml' do
  it 'should show pagination links' do
    session[:access_level] = 'Administrator'
    session[:facility] = stub( {:facility => 'Ad hoc Facile'})
    render 'layouts/administration'
    response.should have_tag("a",'PPPAMS References') 
    response.should have_tag("a[href*=#{pppams_references_path}]") 
  end
  describe "should have administration links" do
    before do
      session[:access_level] = 'Administrator'
      session[:facility] = stub( {:facility => 'Ad hoc Facile'})
      render 'layouts/administration'
    end

    specify { response.should have_tag("a[href*=/reports]") }
    specify { response.should have_tag("a[href*=/position_reports]") }
    specify { response.should have_tag("a[href*=#{incidents_path}]") }
    specify { response.should have_tag("a[href*=#{non_comp_issues_path}]") }
    specify { response.should have_tag("a[href*=#{pppams_issues_path}]") }
    specify { response.should have_tag("a[href*=#{investigators_path}]") }
    specify { response.should have_tag("a[href*=#{positions_path}]") }
    specify { response.should have_tag("a[href*=#{position_numbers_path}]") }
    specify { response.should have_tag("a[href*=#{employees_path}]") }
    specify { response.should have_tag("a[href*=#{employee_positions_path}]") }
    specify { response.should have_tag("a[href*=#{employee_position_hists_path}]") }
    specify { response.should have_tag("a[href*=/accountability_logs]") }
    specify { response.should have_tag("a[href*=/pppams_indicators]") }
    specify { response.should have_tag("a[href*=/pppams_reports]") }
  end
end
