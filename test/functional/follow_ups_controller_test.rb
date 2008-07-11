require File.dirname(__FILE__) + '/../test_helper'
require 'follow_ups_controller'

# Re-raise errors caught by the controller.
class FollowUpsController; def rescue_action(e) raise e end; end

class FollowUpsControllerTest < Test::Unit::TestCase
  fixtures :follow_ups

  def setup
    @controller = FollowUpsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:follow_ups)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_follow_up
    old_count = FollowUp.count
    post :create, :follow_up => { }
    assert_equal old_count+1, FollowUp.count
    
    assert_redirected_to follow_up_path(assigns(:follow_up))
  end

  def test_should_show_follow_up
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_follow_up
    put :update, :id => 1, :follow_up => { }
    assert_redirected_to follow_up_path(assigns(:follow_up))
  end
  
  def test_should_destroy_follow_up
    old_count = FollowUp.count
    delete :destroy, :id => 1
    assert_equal old_count-1, FollowUp.count
    
    assert_redirected_to follow_ups_path
  end
end
