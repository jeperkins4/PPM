require File.dirname(__FILE__) + '/../test_helper'
require 'incident_classes_controller'

# Re-raise errors caught by the controller.
class IncidentClassesController; def rescue_action(e) raise e end; end

class IncidentClassesControllerTest < Test::Unit::TestCase
  fixtures :incident_classes

  def setup
    @controller = IncidentClassesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:incident_classes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_incident_class
    old_count = IncidentClass.count
    post :create, :incident_class => { }
    assert_equal old_count+1, IncidentClass.count
    
    assert_redirected_to incident_class_path(assigns(:incident_class))
  end

  def test_should_show_incident_class
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_incident_class
    put :update, :id => 1, :incident_class => { }
    assert_redirected_to incident_class_path(assigns(:incident_class))
  end
  
  def test_should_destroy_incident_class
    old_count = IncidentClass.count
    delete :destroy, :id => 1
    assert_equal old_count-1, IncidentClass.count
    
    assert_redirected_to incident_classes_path
  end
end
