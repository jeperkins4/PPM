<<<<<<< HEAD
require 'spec_helper'

describe PositionNumber do
  pending "add some examples to (or delete) #{__FILE__}"
end
=======
require File.dirname(__FILE__) + '/../spec_helper'

describe PositionNumber do
  it 'should disallow setting active_flag false if there is an employee_position' do
    position_number = PositionNumber.make
    employee = Employee.make
    EmployeePosition.make(:employee => employee, :position_number => position_number)
    position_number.active_flag = false
    position_number.save.should == false
  end
  it 'should allow creation of new position_number for same position but whose previous position_number is inactive' do
    position_number1 = PositionNumber.make(:position_num => '12345')
    position_number1.update_attribute(:active_flag, false)
    position_number2 = PositionNumber.make(:position_num => '12345', :position => position_number1.position)
    position_number2.update_attribute(:active_flag, false)
    PositionNumber.make(:position => position_number1.position, :position_num => '12345').should be_an_instance_of PositionNumber
  end
  describe "set_inactive_on" do
    it "should set active_flag when inactive_on is set" do
      p = PositionNumber.make
      p.active_flag.should eql true
      p.inactive_on.should == nil
      p.update_attribute(:inactive_on, Date.today)
      p.inactive_on.should_not be_nil
    end
  end
end

>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
