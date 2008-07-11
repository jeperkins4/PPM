require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_category_base_refs_controller'

# Re-raise errors caught by the controller.
class PppamsCategoryBaseRefsController; def rescue_action(e) raise e end; end

class PppamsCategoryBaseRefsControllerTest < Test::Unit::TestCase
  fixtures :pppams_category_base_refs

  def setup
    @controller = PppamsCategoryBaseRefsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = pppams_category_base_refs(:first).id
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

    assert_not_nil assigns(:pppams_category_base_refs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pppams_category_base_ref)
    assert assigns(:pppams_category_base_ref).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pppams_category_base_ref)
  end

  def test_create
    num_pppams_category_base_refs = PppamsCategoryBaseRef.count

    post :create, :pppams_category_base_ref => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_pppams_category_base_refs + 1, PppamsCategoryBaseRef.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pppams_category_base_ref)
    assert assigns(:pppams_category_base_ref).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PppamsCategoryBaseRef.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PppamsCategoryBaseRef.find(@first_id)
    }
  end
end
