require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_categories_controller'

# Re-raise errors caught by the controller.
class PppamsCategoriesController; def rescue_action(e) raise e end; end

class PppamsCategoriesControllerTest < Test::Unit::TestCase
  fixtures :pppams_categories

  def setup
    @controller = PppamsCategoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = pppams_categories(:first).id
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

    assert_not_nil assigns(:pppams_categories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pppams_category)
    assert assigns(:pppams_category).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pppams_category)
  end

  def test_create
    num_pppams_categories = PppamsCategory.count

    post :create, :pppams_category => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_pppams_categories + 1, PppamsCategory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pppams_category)
    assert assigns(:pppams_category).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PppamsCategory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PppamsCategory.find(@first_id)
    }
  end
end
