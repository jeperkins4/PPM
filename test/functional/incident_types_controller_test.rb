require File.dirname(__FILE__) + '/../test_helper'
require 'incident_types_controller'

# Re-raise errors caught by the controller.
class IncidentTypesController; def rescue_action(e) raise e end; end

class IncidentTypesControllerTest < Test::Unit::TestCase
  fixtures :incident_types

  def setup
    @controller = IncidentTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:incident_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_incident_type
    old_count = IncidentType.count
    post :create, :incident_type => { }
    assert_equal old_count+1, IncidentType.count
    
    assert_redirected_to incident_type_path(assigns(:incident_type))
  end

  def test_should_show_incident_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_incident_type
    put :update, :id => 1, :incident_type => { }
    assert_redirected_to incident_type_path(assigns(:incident_type))
  end
  
  def test_should_destroy_incident_type
    old_count = IncidentType.count
    delete :destroy, :id => 1
    assert_equal old_count-1, IncidentType.count
    
    assert_redirected_to incident_types_path
  end
end
