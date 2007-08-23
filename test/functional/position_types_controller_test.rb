require File.dirname(__FILE__) + '/../test_helper'
require 'position_types_controller'

# Re-raise errors caught by the controller.
class PositionTypesController; def rescue_action(e) raise e end; end

class PositionTypesControllerTest < Test::Unit::TestCase
  fixtures :position_types

  def setup
    @controller = PositionTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:position_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_position_type
    old_count = PositionType.count
    post :create, :position_type => { }
    assert_equal old_count+1, PositionType.count
    
    assert_redirected_to position_type_path(assigns(:position_type))
  end

  def test_should_show_position_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_position_type
    put :update, :id => 1, :position_type => { }
    assert_redirected_to position_type_path(assigns(:position_type))
  end
  
  def test_should_destroy_position_type
    old_count = PositionType.count
    delete :destroy, :id => 1
    assert_equal old_count-1, PositionType.count
    
    assert_redirected_to position_types_path
  end
end
