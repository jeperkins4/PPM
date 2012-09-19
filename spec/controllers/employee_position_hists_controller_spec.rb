require File.dirname(__FILE__) + '/../spec_helper'

describe EmployeePositionHistsController do
  before do
    login_as_admin
  end
  describe 'GET index' do
    it 'should list all position_numbers for a facility, including inactive ones' do
      @position_number = PositionNumber.make
      @position_number.update_attribute(:active_flag, false)
      session[:facility] = @position_number.position.position_type.facility
      get :index
      assigns[:facility_position_numbers].should == [@position_number]
      assigns[:employee_position_hists].should == []
    end
  end
end
