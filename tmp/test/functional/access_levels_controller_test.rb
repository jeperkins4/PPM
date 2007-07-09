require File.dirname(__FILE__) + '/../test_helper'
require 'access_levels_controller'

# Re-raise errors caught by the controller.
class AccessLevelsController; def rescue_action(e) raise e end; end

class AccessLevelsControllerTest < Test::Unit::TestCase
  fixtures :access_levels

  def setup
    @controller = AccessLevelsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:access_levels)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_access_level
    old_count = AccessLevel.count
    post :create, :access_level => { }
    assert_equal old_count+1, AccessLevel.count
    
    assert_redirected_to access_level_path(assigns(:access_level))
  end

  def test_should_show_access_level
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_access_level
    put :update, :id => 1, :access_level => { }
    assert_redirected_to access_level_path(assigns(:access_level))
  end
  
  def test_should_destroy_access_level
    old_count = AccessLevel.count
    delete :destroy, :id => 1
    assert_equal old_count-1, AccessLevel.count
    
    assert_redirected_to access_levels_path
  end
end
