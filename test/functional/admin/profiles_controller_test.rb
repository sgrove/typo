require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/profiles_controller'

# Re-raise errors caught by the controller.
class Admin::ProfilesController; def rescue_action(e) raise e end; end

class Admin::ProfilesControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::ProfilesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end