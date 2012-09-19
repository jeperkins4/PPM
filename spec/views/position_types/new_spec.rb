require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe 'new view' do
  it 'should show facility select option' do
    position_type = PositionType.make(:with_facility)
    assigns[:position_type] = position_type
    render 'position_types/new'
    response.should have_tag('b', 'Facility:')
    response.should have_tag('option', /#{position_type.facility.facility}/)
    response.should have_tag('select#position_type_facility_id')
  end
end