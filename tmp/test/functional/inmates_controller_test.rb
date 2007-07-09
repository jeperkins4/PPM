require File.dirname(__FILE__) + '/../test_helper'
require 'inmates_controller'

# Re-raise errors caught by the controller.
class InmatesController; def rescue_action(e) raise e end; end

class InmatesControllerTest < Test::Unit::TestCase
  fixtures :inmates

  def setup
    @controller = InmatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:inmates)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_inmate
    old_count = Inmate.count
    post :create, :inmate => { }
    assert_equal old_count+1, Inmate.count
    
    assert_redirected_to inmate_path(assigns(:inmate))
  end

  def test_should_show_inmate
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_inmate
    put :update, :id => 1, :inmate => { }
    assert_redirected_to inmate_path(assigns(:inmate))
  end
  
  def test_should_destroy_inmate
    old_count = Inmate.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Inmate.count
    
    assert_redirected_to inmates_path
  end
end
