require File.dirname(__FILE__) + '/../spec_helper'

describe "named route edit_pppams_indicator_path" do
  it "maps /pppams_indicators/37/edit" do
    route_for(:controller => 'pppams_indicators', :action => 'edit', :id => '37').should == '/pppams_indicators/37/edit'
  end

  it "generates params for #edit_pppams_indicator" do
    params_from(:get, '/pppams_indicators/37/edit').should == {:controller => 'pppams_indicators', :action => 'edit', :id => '37'}
  end

  it 'recognizes edit_pppams_indicator_path' do
    edit_pppams_indicator_path('37').should == '/pppams_indicators/37/edit'
  end
end
