require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmployeePosition do

  describe 'available_positions' do
    it "should return all positions for a given facility" do
      ep1 = EmployeePosition.make
      ep2 = EmployeePosition.make

      facility = ep1.position_number.position.position_type.facility

      EmployeePosition.available_positions(facility.id).to_a.size.should == 1
      EmployeePosition.available_positions(facility.id)[0].id == ep1.id
    end
  end
  it 'requires active position_number' do
    position_number = PositionNumber.make
    position_number.update_attribute(:active_flag, false)
    lambda {
      employee_position.make(:position_number => position_number)
    }.should raise_error
  end

end
