require File.dirname(__FILE__) + '/../spec_helper'

def set_criteria_date(date)
  @criteria_date= date
end

describe PositionReportsController do
  require 'ruby-debug'
  
  describe 'GET index' do
    it "should run a vacancy report when asked" do
      controller.should_receive(:vacancy).and_return false
      post :index, :id => {:selection => 'Vacancy'}, :date => {:month => '1', :year => '2009'}
      assigns[:results].should == 'vacancy'
      session[:report_selection].should == 'Vacancy'
      session[:selectmonth].should == 1
      session[:selectyear].should == 2009
    end
    it "should run deduction reports when asked" do
      controller.should_receive(:vacancy).and_return false
      post :index, :id => {:selection => 'Deduction'}, :date => {:month => '1', :year => '2009'}
      assigns[:results].should == 'deduction'
      session[:report_selection].should == 'Deduction'
      session[:selectmonth].should == 1

    end
  end

  describe "vacancy" do
    before do
      @f = Facility.make
      session[:facility]= @f
      session[:report_selection]= 'Vacancy'
      session[:selectmonth]= 1
      session[:selectyear]= 2007
      controller.instance_variable_set(:@criteria_date, Date.new(2009,5,1))
      controller.instance_variable_set(:@results, 'vacancy')
    end

    it "should find deductable position numbers that are active." do
      there_is_a_deductable_position_number

      #User queries for a date AFTER pn creation date
      controller.instance_variable_set(:@criteria_date, Date.new(2009,4,1))

      #The employee position start date is after the date queried
      EmployeePosition.create(:position_number => @pn_deductable,
                              :start_date => Date.new(2009,5,1))
      controller.vacancy
      controller.instance_variable_get(:@deductable_position_numbers).should include(@pn_deductable)
      controller.instance_variable_get(:@deductable_position_numbers).should have(1).records
    end

    it "should find position numbers that were active at the time being queried" do
       there_is_a_deductable_position_number
       position_number_was_rendered_inactive_in_May

      #User queries for a positions created after the pn creation time
      #but before the pn was inactive
      controller.instance_variable_set(:@criteria_date, Date.new(2009,4,1))
      controller.vacancy
      controller.instance_variable_get(:@deductable_position_numbers).should == [@pn_deductable]
    end

    it "should NOT find position numbers that were inactive at the time being queried" do
      there_is_a_deductable_position_number
      position_number_was_rendered_inactive_in_May

      #User queries for positions after the pn creation time and after rendered
      #inactive time
      controller.instance_variable_set(:@criteria_date, Date.new(2009,6,1))
      controller.vacancy 
      controller.instance_variable_get(:@deductable_position_numbers).should be_empty
    end

    it "should find deductable position numbers that are not assigned to positions" do
      there_is_a_deductable_position_number
      @pn_deductable.position = nil
      @pn_deductable.save
      controller.instance_variable_set(:@criteria_date, Date.new(2009,5,1))
      controller.vacancy
      controller.instance_variable_get(:@not_assigned_position_numbers).should eql [@pn_deductable]
    end

    it "should NOT find deductable position numbers that are inactive at the time queried 
        and are not assigned to positions" do
      there_is_a_deductable_position_number
      position_number_was_rendered_inactive_in_May
      controller.instance_variable_set(:@criteria_date, Date.new(2009,6,1))
      controller.vacancy
      controller.instance_variable_get(:@not_assigned_position_numbers).should eql []
    end

    it "should find deductable position numbers that are assigned to a position, 
        but that do not have a history" do
      there_is_a_deductable_position_number
      @employee_position = EmployeePosition.create(:position_number => @pn_deductable, 
         :employee => Employee.make,
         :start_date => Date.new(2009,5,3))
      controller.instance_variable_set(:@criteria_date, Date.new(2009,5,1))
      controller.vacancy
      controller.instance_variable_get(:@current_assigned_no_history).should eql [@employee_position]
    end
    
    it "should find deductable position numbers that are assigned to a position that have a history" do
      there_is_a_deductable_position_number
      the_position_number_has_an_employee_position_history
      @employee_position = EmployeePosition.create(:position_number => @pn_deductable,
        :employee => Employee.make,
        :start_date => Date.new(2009,5,3))
      controller.instance_variable_set(:@criteria_date, Date.new(2009,5,1))
      controller.vacancy
      controller.instance_variable_get(:@current_assigned_with_history)[0].position_number_id.should eql @employee_position.position_number_id
      controller.instance_variable_get(:@current_assigned_with_history).should have(1).record
    end

    it "should find deductable position numbers that have a history but are not assigned to a position" do
      there_is_a_deductable_position_number
      the_position_number_has_an_employee_position_history
      controller.instance_variable_set(:@criteria_date, Date.new(2009,5,1))
      controller.vacancy
      controller.instance_variable_get(:@history_with_no_current).should == EmployeePositionHist.all
    end
    
    it "should NOT find deductable position numbers that have a history and are inactive when
        querying after the inactive date" do
      there_is_a_deductable_position_number
      position_number_was_rendered_inactive_in_May
      the_position_number_has_an_employee_position_history
      controller.instance_variable_set(:@criteria_date, Date.new(2009,6,1))
      controller.vacancy
      controller.instance_variable_get(:@history_with_no_current).should be_empty
    end
   
    it "should find deductable position numbers that have a history and were active at the time
        the query is set but are now inactive" do
      there_is_a_deductable_position_number
      @pn_deductable.inactive_on = Date.new(2009,7,1)
      @pn_deductable.save
      the_position_number_has_an_employee_position_history
      @eph.start_date = Date.new(2009,2,2)
      @eph.end_date = Date.new(2009,2,3)
      @eph.save
      controller.instance_variable_set(:@criteria_date, Date.new(2009,6,1))
      controller.vacancy
      controller.instance_variable_get(:@history_with_no_current).should eql [@eph]
    end

    it "should create a report" do

    end
  end

  def there_is_a_deductable_position_number
      @pt_deductable = PositionType.make(:deductable => 1, :facility => @f)
      @p_deductable = Position.make(:position_type => @pt_deductable)
      @pn_deductable= PositionNumber.make(:position => @p_deductable, 
                                         :waiver_approval_date => nil, 
                                         :position_type => 'none',
                                         :created_on => Date.new(2009,1,1))
  end

  def position_number_was_rendered_inactive_in_May
      @pn_deductable.inactive_on = Date.new(2009,5,1)
      @pn_deductable.save
  end

  def the_position_number_has_an_employee_position_history
    @eph = EmployeePositionHist.
      create(:position_number => @pn_deductable,
        :employee => Employee.make,
        :start_date => Date.new(2007,1,1),
        :end_date => Date.new(2007,6,1),
        :salary => 50000)
  end
end

