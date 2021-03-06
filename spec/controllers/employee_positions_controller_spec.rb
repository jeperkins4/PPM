require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe EmployeePositionsController do
  integrate_views
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
    @ep1 = EmployeePosition.make
    @ep2 = EmployeePosition.make
    @ep3 = EmployeePosition.make
    
  end
  
  describe 'index' do
    it 'should show all employee positions' do

      ep1_facility = @ep1.position_number.position.position_type.facility

      session[:facility] = ep1_facility

      @ep2.position_number.position.position_type.update_attribute(:facility, ep1_facility)

      ep1_full_name = @ep1.employee.first_name + ' ' + @ep1.employee.last_name
      ep2_full_name = @ep2.employee.first_name + ' ' + @ep2.employee.last_name

      get :index

      assigns[:employee_positions].should have(2).records
      response.should have_text(/#{ep1_full_name}/)
      response.should have_text(/#{ep2_full_name}/)

    end
  end
  
  describe 'set_filter' do
    it 'should show items when they are filtered by any of several criteria' do
      @ep1.employee.update_attribute(:first_name, 'aaaaaaaa')
      @ep2.employee.update_attribute(:first_name, 'aaaaaaab')
      ep1_facility = @ep1.position_number.position.position_type.facility
      
      @ep2.position_number.position.position_type.update_attribute(:facility, ep1_facility)
      session[:facility] = ep1_facility

      post :set_filter, :id => {:filter_drop => 'e.first_name'}, :employee_position => {:filter_text => 'aaaaaaaa'}
      
      assigns[:employee_positions].should have(1).record
      assigns[:employee_positions][0].should == @ep1
    end
    it 'should not display inactive position numbers' do
      @ep1.position_number.update_attribute(:active_flag, false)
      position_title = @ep1.position_number.position.title
      ep1_facility = @ep1.position_number.position.position_type.facility
      session[:facility] = ep1_facility

      post :set_filter, :id => {:filter_drop => 'p.title'}, :employee_position => {:filter_text => position_title}

      assigns[:employee_positions].should have(0).record
      assigns[:employee_positions].should be_empty
    end
  end
  
  describe 'edit' do
    it 'should show an edit page for a given position' do
      session[:facility] = @ep1.position_number.position.position_type.facility
      get :edit, :id => @ep1.id
      response.should be_success
      response.should have_tag('form[action=?]', "/employee_positions/#{@ep1.id}")
    end
  end
  
  describe 'update' do
    it 'should not save record  with invalid parameters edits' do
      session[:facility] = @ep1.position_number.position.position_type.facility
      new_attributes = @ep1.attributes.reject {|k,v| k.to_s == 'end_date' || k.to_s == 'start_date'}.
                                       merge({'start_date(3i)' => '01', 
                                              'start_date(2i)' => '02',
                                              'start_date(1i)' => '2009',
                                              'end_date(3i)' => '01', 
                                              'end_date(2i)' => '02',
                                              'end_date(1i)' => '2009'})
      post :update, :id => @ep1.id, :employee_position => new_attributes
      response.should be_success
      flash[:notice].should == 'End Date must be greater than the Start Date'

    end
    it 'should  update end date' do
      session[:facility] = @ep1.position_number.position.position_type.facility
      new_attributes = @ep1.attributes.reject {|k,v| k.to_s == 'end_date' || k.to_s == 'start_date'}.
                                       merge({'start_date(3i)' => '01', 
                                              'start_date(2i)' => '02',
                                              'start_date(1i)' => '2009',
                                              'end_date(3i)' => '01', 
                                              'end_date(2i)' => '03',
                                              'end_date(1i)' => '2009'})
      put :update, :id => @ep1.id, :employee_position => new_attributes
      response.should redirect_to(employee_path(@ep1.employee.id)) do 
        response.should have_tag('p', /Start date\:.*2009\-03\-01/)
      end
    end
    it 'should update positions' do
      session[:facility] = @ep1.position_number.position.position_type.facility
      position_number = PositionNumber.make(:position => @ep1.position_number.position)
      new_attributes = @ep1.attributes.reject {|k,v| k.to_s == 'end_date' || k.to_s == 'start_date'}.
                                       merge({'position_number_id' => position_number.id,
                                              'end_date(3i)' => '', 
                                              'end_date(2i)' => '',
                                              'end_date(1i)' => ''})
      put :update, :id => @ep1.id, :employee_position => new_attributes
      response.should redirect_to(employee_position_path(@ep1.id)) do
        response.should be_success
      end
    end
  end
  describe 'POST create' do
    before do
      session[:facility] = @ep1.position_number.position.position_type.facility
      @employee = @ep1.employee
      @employee.employee_position = nil
      @employee.save

      @position_number = @ep1.position_number
      @ep1.destroy
      @position_number.update_attribute(:active_flag, false)
      
    end
    it 'should allow creation of employee_positions for position numbers that were once inactive' do
      @active_position_number = PositionNumber.make
      post :create, :employee_position => {
                      'position_number_id' => @active_position_number.id.to_s,
                      'employee_id' => @employee.id.to_s,
                      'start_date(1i)' => Date.yesterday.year.to_s,
                      'start_date(2i)' => Date.yesterday.month.to_s,
                      'start_date(3i)' => Date.yesterday.day.to_s 
      }
      assigns[:employee_position].position_number.should == @active_position_number
      assigns[:employee_position].employee.should == @employee
      assigns[:employee_position].should be_valid
    end
    it 'should not allow creation of employee positions for position numbers that are only inactive' do
      post :create, :employee_position => {
                      'position_number_id' => @position_number.id.to_s,
                      'employee_id' => @employee.id.to_s,
                      'start_date(1i)' => Date.yesterday.year.to_s,
                      'start_date(2i)' => Date.yesterday.month.to_s,
                      'start_date(3i)' => Date.yesterday.day.to_s 
      }
      assigns[:employee_position].should_not be_valid
    end
  end
  describe 'delete' do
    it 'should destroy an employee_position' do
      session[:facility] = @ep1.position_number.position.position_type.facility
      
      delete :destroy, :id => @ep1.id
      assigns[:employee_position].should eql @ep1
      response.should redirect_to(employee_positions_url) do
        response.should be_success
      end
    end
  end
#  describe "create with lateral moove" do
#    it "should move an existing employee to a vacant position" do
#      post :create, 'commit' => 'Save',
#      'employee_position' => {'start_date(1i)' => '2009'},
#      'employee_position' => {'start_date(2i)' => '7'   },
#      'employee_position' => {'start_date(3i)' => '2'   },
#      'employee_id' => '3611',
#      'position_number_id' => '1785'
#      
#      
#    end
#  end
end
