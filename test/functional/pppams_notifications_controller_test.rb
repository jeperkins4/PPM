require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_notifications_controller'

# Re-raise errors caught by the controller.
class PppamsNotificationsController; def rescue_action(e) raise e end; end

class PppamsNotificationsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PppamsNotificationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
