require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe PositionNumbersController do
  integrate_views
  
  before do
    @admin = User.make(:administrator)
    login_as @admin
    @ep1 = EmployeePosition.make
    @ep2 = EmployeePosition.make
    @ep3 = EmployeePosition.make
    
  end
  describe 'GET' do
    describe 'index' do
      it 'should show all position numbers' do
  
        ep1_facility = @ep1.position_number.position.position_type.facility
        
        session[:facility] = ep1_facility
        
        @ep2.position_number.position.position_type.update_attribute(:facility, ep1_facility)
        
        position_type1 ='A random position name 1'
         @ep1.position_number.position.position_type.update_attribute(:position_type, position_type1)
        position_type2 ='A random position name 2'
         @ep2.position_number.position.position_type.update_attribute(:position_type, position_type2)
        
        get :index
        assigns[:positions_filter].should have(2).records
        assigns[:position_numbers].should have(2).records
        response.should have_text(/#{position_type1}/)
        response.should have_text(/#{position_type2}/)
        
      end
    end
    
    describe 'edit' do
      it 'should show an edit page for a given position' do
        session[:facility] = @ep1.position_number.position.position_type.facility
        get :edit, :id => @ep1.position_number.id
        response.should be_success
        response.should have_tag('form[action=?]', "/position_numbers/#{@ep1.position_number.id}")
      end
    end
    
    describe 'show' do
      it 'should show position_number details' do 
        session[:facility] = @ep1.position_number.position.position_type.facility
        get :show, :id => @ep1.position_number.id
        response.should be_success
      end
    end
  end
  
  describe 'PUT' do
    
    describe 'update' do
      it 'should  save records  with valid parameters edits' do
        session[:facility] = @ep1.position_number.position.position_type.facility
        new_attributes = @ep1.position_number.attributes.reject {|k,v| k.to_s == 'created_on'}.
                                         merge({'created_on(3i)' => '01', 
                                                'created_on(2i)' => '02',
                                                'created_on(1i)' => '2009'})
        put :update, :id => @ep1.position_number.id, :position_number => new_attributes
        response.should redirect_to(position_number_url(@ep1.position_number.id))
      end
    end
  
    describe 'set_filter' do
      it 'should show items when they are filtered by any of several criteria' do
        @ep1.position_number.update_attribute(:position_num, 'aaaaaaaa')
        @ep2.position_number.update_attribute(:position_num, 'aaaaaaab')
        ep1_facility = @ep1.position_number.position.position_type.facility
        
        @ep2.position_number.position.position_type.update_attribute(:facility, ep1_facility)
        session[:facility] = ep1_facility
  
        get :set_filter, :id => {:filter_drop => '1'}, :position_number => {:filter_text => 'aaaaaaaa'}
        
        assigns[:position_numbers].should have(1).record
        assigns[:position_numbers][0].should == @ep1.position_number
      end
    end
  end
  
  describe 'POST' do
    
    describe 'create' do
      it 'should create new employee positions' do
        session[:facility] = @ep1.position_number.position.position_type.facility
        new_attributes = @ep1.position_number.attributes.reject {|k,v| k.to_s == 'created_on'}.
                                         merge({'position_id' => 2790,
                                                'created_on(3i)' => '01', 
                                                'created_on(2i)' => '02',
                                                'created_on(1i)' => '2009'})
        post :update, :id => @ep1.id, :position_number => new_attributes
        response.should redirect_to(position_number_path(@ep1.position_number.id)) do
          response.should be_success
        end
      end
    end
  end
  
  describe 'DELETE' do
    describe 'destroy' do
      it 'should delete records' do
        session[:facility] = @ep1.position_number.position.position_type.facility
        position_number = @ep1.position_number
        
       PositionNumber.should_receive(:find).with(position_number.id.to_s).and_return(position_number)
       position_number.should_receive(:destroy)
        
       delete :destroy, :id => position_number.id
       assigns[:position_number].should == position_number
        
       response.should redirect_to position_numbers_url do
         response.should be_success
       end

      end
    end
  end
  
end