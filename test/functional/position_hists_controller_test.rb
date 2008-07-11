require File.dirname(__FILE__) + '/../test_helper'
require 'position_hists_controller'

# Re-raise errors caught by the controller.
class PositionHistsController; def rescue_action(e) raise e end; end

class PositionHistsControllerTest < Test::Unit::TestCase
  fixtures :position_hists

  def setup
    @controller = PositionHistsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:position_hists)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_position_hist
    old_count = PositionHist.count
    post :create, :position_hist => { }
    assert_equal old_count+1, PositionHist.count
    
    assert_redirected_to position_hist_path(assigns(:position_hist))
  end

  def test_should_show_position_hist
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_position_hist
    put :update, :id => 1, :position_hist => { }
    assert_redirected_to position_hist_path(assigns(:position_hist))
  end
  
  def test_should_destroy_position_hist
    old_count = PositionHist.count
    delete :destroy, :id => 1
    assert_equal old_count-1, PositionHist.count
    
    assert_redirected_to position_hists_path
  end
end
