require File.dirname(__FILE__) + '/../test_helper'
require 'prompts_controller'

# Re-raise errors caught by the controller.
class PromptsController; def rescue_action(e) raise e end; end

class PromptsControllerTest < Test::Unit::TestCase
  fixtures :prompts

  def setup
    @controller = PromptsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prompts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prompt
    old_count = Prompt.count
    post :create, :prompt => { }
    assert_equal old_count+1, Prompt.count
    
    assert_redirected_to prompt_path(assigns(:prompt))
  end

  def test_should_show_prompt
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_prompt
    put :update, :id => 1, :prompt => { }
    assert_redirected_to prompt_path(assigns(:prompt))
  end
  
  def test_should_destroy_prompt
    old_count = Prompt.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Prompt.count
    
    assert_redirected_to prompts_path
  end
end
