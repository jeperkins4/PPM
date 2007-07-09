require File.dirname(__FILE__) + '/../test_helper'
require 'facilities_controller'

# Re-raise errors caught by the controller.
class FacilitiesController; def rescue_action(e) raise e end; end

class FacilitiesControllerTest < Test::Unit::TestCase
  fixtures :facilities

  def setup
    @controller = FacilitiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:facilities)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_facility
    old_count = Facility.count
    post :create, :facility => { }
    assert_equal old_count+1, Facility.count
    
    assert_redirected_to facility_path(assigns(:facility))
  end

  def test_should_show_facility
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_facility
    put :update, :id => 1, :facility => { }
    assert_redirected_to facility_path(assigns(:facility))
  end
  
  def test_should_destroy_facility
    old_count = Facility.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Facility.count
    
    assert_redirected_to facilities_path
  end
end
