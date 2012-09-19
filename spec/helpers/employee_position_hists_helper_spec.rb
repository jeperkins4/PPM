require File.dirname(__FILE__) + '/../spec_helper'

describe EmployeePositionHistsHelper do
  describe "ordered_position_numbers" do
    it "should return all position numbers for a facility including inactive ones" do
      pn = PositionNumber.make
      pn.update_attribute(:active_flag, false)
      session[:facility] = pn.position.position_type.facility
      helper.ordered_position_numbers.should == [pn]
    end
  end
end

