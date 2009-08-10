require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe 'index view' do
  it 'should show facility for each position type' do
    position_type = PositionType.make(:with_facility)
    assigns[:position_types] = [position_type]
    render 'position_types/index'
    response.should have_tag('th', 'Facility')
    response.should have_tag('td', position_type.facility.facility)
  end
end