require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_indicators_controller'

# Re-raise errors caught by the controller.
class PppamsIndicatorsController; def rescue_action(e) raise e end; end

class PppamsIndicatorsControllerTest < Test::Unit::TestCase
  fixtures :pppams_indicators

  def setup
    @controller = PppamsIndicatorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = pppams_indicators(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:pppams_indicators)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pppams_indicator)
    assert assigns(:pppams_indicator).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pppams_indicator)
  end

  def test_create
    num_pppams_indicators = PppamsIndicator.count

    post :create, :pppams_indicator => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_pppams_indicators + 1, PppamsIndicator.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pppams_indicator)
    assert assigns(:pppams_indicator).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PppamsIndicator.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PppamsIndicator.find(@first_id)
    }
  end
end
