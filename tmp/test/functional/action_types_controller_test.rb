require File.dirname(__FILE__) + '/../test_helper'
require 'action_types_controller'

# Re-raise errors caught by the controller.
class ActionTypesController; def rescue_action(e) raise e end; end

class ActionTypesControllerTest < Test::Unit::TestCase
  fixtures :action_types

  def setup
    @controller = ActionTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:action_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_action_type
    old_count = ActionType.count
    post :create, :action_type => { }
    assert_equal old_count+1, ActionType.count
    
    assert_redirected_to action_type_path(assigns(:action_type))
  end

  def test_should_show_action_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_action_type
    put :update, :id => 1, :action_type => { }
    assert_redirected_to action_type_path(assigns(:action_type))
  end
  
  def test_should_destroy_action_type
    old_count = ActionType.count
    delete :destroy, :id => 1
    assert_equal old_count-1, ActionType.count
    
    assert_redirected_to action_types_path
  end
end
