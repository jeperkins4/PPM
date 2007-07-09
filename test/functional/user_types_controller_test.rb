require File.dirname(__FILE__) + '/../test_helper'
require 'user_types_controller'

# Re-raise errors caught by the controller.
class UserTypesController; def rescue_action(e) raise e end; end

class UserTypesControllerTest < Test::Unit::TestCase
  fixtures :user_types

  def setup
    @controller = UserTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:user_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_user_type
    old_count = UserType.count
    post :create, :user_type => { }
    assert_equal old_count+1, UserType.count
    
    assert_redirected_to user_type_path(assigns(:user_type))
  end

  def test_should_show_user_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_user_type
    put :update, :id => 1, :user_type => { }
    assert_redirected_to user_type_path(assigns(:user_type))
  end
  
  def test_should_destroy_user_type
    old_count = UserType.count
    delete :destroy, :id => 1
    assert_equal old_count-1, UserType.count
    
    assert_redirected_to user_types_path
  end
end
