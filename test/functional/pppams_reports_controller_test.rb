require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_reports_controller'

# Re-raise errors caught by the controller.
class PppamsReportsController; def rescue_action(e) raise e end; end

class PppamsReportsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PppamsReportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
