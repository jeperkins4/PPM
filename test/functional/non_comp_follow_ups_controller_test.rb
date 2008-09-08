require File.dirname(__FILE__) + '/../test_helper'
require 'non_comp_follow_ups_controller'

# Re-raise errors caught by the controller.
class NonCompFollowUpsController; def rescue_action(e) raise e end; end

class NonCompFollowUpsControllerTest < Test::Unit::TestCase
  fixtures :non_comp_follow_ups

  def setup
    @controller = NonCompFollowUpsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = non_comp_follow_ups(:first).id
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

    assert_not_nil assigns(:non_comp_follow_ups)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:non_comp_follow_up)
    assert assigns(:non_comp_follow_up).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:non_comp_follow_up)
  end

  def test_create
    num_non_comp_follow_ups = NonCompFollowUp.count

    post :create, :non_comp_follow_up => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_non_comp_follow_ups + 1, NonCompFollowUp.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:non_comp_follow_up)
    assert assigns(:non_comp_follow_up).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      NonCompFollowUp.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      NonCompFollowUp.find(@first_id)
    }
  end
end
