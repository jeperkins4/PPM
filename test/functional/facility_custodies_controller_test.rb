require File.dirname(__FILE__) + '/../test_helper'
require 'facility_custodies_controller'

# Re-raise errors caught by the controller.
class FacilityCustodiesController; def rescue_action(e) raise e end; end

class FacilityCustodiesControllerTest < Test::Unit::TestCase
  fixtures :facility_custodies

  def setup
    @controller = FacilityCustodiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:facility_custodies)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_facility_custody
    old_count = FacilityCustody.count
    post :create, :facility_custody => { }
    assert_equal old_count+1, FacilityCustody.count
    
    assert_redirected_to facility_custody_path(assigns(:facility_custody))
  end

  def test_should_show_facility_custody
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_facility_custody
    put :update, :id => 1, :facility_custody => { }
    assert_redirected_to facility_custody_path(assigns(:facility_custody))
  end
  
  def test_should_destroy_facility_custody
    old_count = FacilityCustody.count
    delete :destroy, :id => 1
    assert_equal old_count-1, FacilityCustody.count
    
    assert_redirected_to facility_custodies_path
  end
end
