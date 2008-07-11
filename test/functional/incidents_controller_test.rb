require File.dirname(__FILE__) + '/../test_helper'
require 'incidents_controller'

# Re-raise errors caught by the controller.
class IncidentsController; def rescue_action(e) raise e end; end

class IncidentsControllerTest < Test::Unit::TestCase
  fixtures :incidents

  def setup
    @controller = IncidentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:incidents)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_incident
    old_count = Incident.count
    post :create, :incident => { }
    assert_equal old_count+1, Incident.count
    
    assert_redirected_to incident_path(assigns(:incident))
  end

  def test_should_show_incident
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_incident
    put :update, :id => 1, :incident => { }
    assert_redirected_to incident_path(assigns(:incident))
  end
  
  def test_should_destroy_incident
    old_count = Incident.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Incident.count
    
    assert_redirected_to incidents_path
  end
end
