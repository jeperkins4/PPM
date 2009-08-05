require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Position do
  it 'should delegate facilities to position_type' do
    
    facility = Facility.make(:facility => 'a facile name')
    position_type = PositionType.make({:facility_id => facility.id})
    position = Position.make({:position_type_id => position_type.id})
    
    position.facility.name.should eql 'a facile name'
  end
end