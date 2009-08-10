require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe 'edit view' do
  it 'should show facility for the current position type, and should not allow editing facility' do
    position_type = PositionType.make(:with_facility)
    assigns[:position_type] = position_type
    render 'position_types/edit'
    response.should have_tag('b', 'Facility:')
    response.should have_tag('p', /#{position_type.facility.facility}/)
    response.should_not have_tag('select#position_type_facility_id')
  end
end