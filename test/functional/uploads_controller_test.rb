require File.dirname(__FILE__) + '/../test_helper'
require 'uploads_controller'

# Re-raise errors caught by the controller.
class UploadsController; def rescue_action(e) raise e end; end

class UploadsControllerTest < Test::Unit::TestCase
  fixtures :uploads

  def setup
    @controller = UploadsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = uploads(:first).id
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

    assert_not_nil assigns(:uploads)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:upload)
    assert assigns(:upload).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:upload)
  end

  def test_create
    num_uploads = Upload.count

    post :create, :upload => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_uploads + 1, Upload.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:upload)
    assert assigns(:upload).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Upload.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Upload.find(@first_id)
    }
  end
end
