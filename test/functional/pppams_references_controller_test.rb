require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_references_controller'

# Re-raise errors caught by the controller.
class PppamsReferencesController; def rescue_action(e) raise e end; end

class PppamsReferencesControllerTest < Test::Unit::TestCase
  fixtures :pppams_references

  def setup
    @controller = PppamsReferencesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = pppams_references(:first).id
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

    assert_not_nil assigns(:pppams_references)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pppams_reference)
    assert assigns(:pppams_reference).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pppams_reference)
  end

  def test_create
    num_pppams_references = PppamsReference.count

    post :create, :pppams_reference => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_pppams_references + 1, PppamsReference.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pppams_reference)
    assert assigns(:pppams_reference).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PppamsReference.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PppamsReference.find(@first_id)
    }
  end
end
