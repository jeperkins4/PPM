require File.dirname(__FILE__) + '/../test_helper'
require 'inmate_counts_controller'

# Re-raise errors caught by the controller.
class InmateCountsController; def rescue_action(e) raise e end; end

class InmateCountsControllerTest < Test::Unit::TestCase
  fixtures :inmate_counts

  def setup
    @controller = InmateCountsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:inmate_counts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_inmate_count
    old_count = InmateCount.count
    post :create, :inmate_count => { }
    assert_equal old_count+1, InmateCount.count
    
    assert_redirected_to inmate_count_path(assigns(:inmate_count))
  end

  def test_should_show_inmate_count
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_inmate_count
    put :update, :id => 1, :inmate_count => { }
    assert_redirected_to inmate_count_path(assigns(:inmate_count))
  end
  
  def test_should_destroy_inmate_count
    old_count = InmateCount.count
    delete :destroy, :id => 1
    assert_equal old_count-1, InmateCount.count
    
    assert_redirected_to inmate_counts_path
  end
end
