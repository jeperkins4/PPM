require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe 'show view' do
  it 'should show facility for the current position type' do
    position_type = PositionType.make(:with_facility)
    assigns[:position_type] = position_type
    render 'position_types/show'
    response.should have_tag('b', 'Facility:')
    response.should have_tag('p', /#{position_type.facility.facility}/)
  end
end