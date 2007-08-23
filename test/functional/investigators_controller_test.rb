require File.dirname(__FILE__) + '/../test_helper'
require 'investigators_controller'

# Re-raise errors caught by the controller.
class InvestigatorsController; def rescue_action(e) raise e end; end

class InvestigatorsControllerTest < Test::Unit::TestCase
  fixtures :investigators

  def setup
    @controller = InvestigatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:investigators)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_investigator
    old_count = Investigator.count
    post :create, :investigator => { }
    assert_equal old_count+1, Investigator.count
    
    assert_redirected_to investigator_path(assigns(:investigator))
  end

  def test_should_show_investigator
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_investigator
    put :update, :id => 1, :investigator => { }
    assert_redirected_to investigator_path(assigns(:investigator))
  end
  
  def test_should_destroy_investigator
    old_count = Investigator.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Investigator.count
    
    assert_redirected_to investigators_path
  end
end
