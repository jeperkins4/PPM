require File.dirname(__FILE__) + '/../test_helper'
require 'incident_investigators_controller'

# Re-raise errors caught by the controller.
class IncidentInvestigatorsController; def rescue_action(e) raise e end; end

class IncidentInvestigatorsControllerTest < Test::Unit::TestCase
  fixtures :incident_investigators

  def setup
    @controller = IncidentInvestigatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:incident_investigators)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_incident_investigator
    old_count = IncidentInvestigator.count
    post :create, :incident_investigator => { }
    assert_equal old_count+1, IncidentInvestigator.count
    
    assert_redirected_to incident_investigator_path(assigns(:incident_investigator))
  end

  def test_should_show_incident_investigator
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_incident_investigator
    put :update, :id => 1, :incident_investigator => { }
    assert_redirected_to incident_investigator_path(assigns(:incident_investigator))
  end
  
  def test_should_destroy_incident_investigator
    old_count = IncidentInvestigator.count
    delete :destroy, :id => 1
    assert_equal old_count-1, IncidentInvestigator.count
    
    assert_redirected_to incident_investigators_path
  end
end
