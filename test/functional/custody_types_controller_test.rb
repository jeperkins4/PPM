require File.dirname(__FILE__) + '/../test_helper'
require 'custody_types_controller'

# Re-raise errors caught by the controller.
class CustodyTypesController; def rescue_action(e) raise e end; end

class CustodyTypesControllerTest < Test::Unit::TestCase
  fixtures :custody_types

  def setup
    @controller = CustodyTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:custody_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_custody_type
    old_count = CustodyType.count
    post :create, :custody_type => { }
    assert_equal old_count+1, CustodyType.count
    
    assert_redirected_to custody_type_path(assigns(:custody_type))
  end

  def test_should_show_custody_type
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_custody_type
    put :update, :id => 1, :custody_type => { }
    assert_redirected_to custody_type_path(assigns(:custody_type))
  end
  
  def test_should_destroy_custody_type
    old_count = CustodyType.count
    delete :destroy, :id => 1
    assert_equal old_count-1, CustodyType.count
    
    assert_redirected_to custody_types_path
  end
end
