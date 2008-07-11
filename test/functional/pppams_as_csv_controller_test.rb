require File.dirname(__FILE__) + '/../test_helper'
require 'pppams_as_csv_controller'

# Re-raise errors caught by the controller.
class PppamsAsCsvController; def rescue_action(e) raise e end; end

class PppamsAsCsvControllerTest < Test::Unit::TestCase
  def setup
    @controller = PppamsAsCsvController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
