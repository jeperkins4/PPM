require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_category_groups_controller'

# Re-raise errors caught by the controller.
class PppamsCategoryGroupsController; def rescue_action(e) raise e end; end

class PppamsCategoryGroupsControllerTest < Test::Unit::TestCase
  fixtures :pppams_category_groups

  def setup
    @controller = PppamsCategoryGroupsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = pppams_category_groups(:first).id
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

    assert_not_nil assigns(:pppams_category_groups)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:pppams_category_group)
    assert assigns(:pppams_category_group).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:pppams_category_group)
  end

  def test_create
    num_pppams_category_groups = PppamsCategoryGroup.count

    post :create, :pppams_category_group => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_pppams_category_groups + 1, PppamsCategoryGroup.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:pppams_category_group)
    assert assigns(:pppams_category_group).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PppamsCategoryGroup.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PppamsCategoryGroup.find(@first_id)
    }
  end
end
