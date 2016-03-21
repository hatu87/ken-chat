require 'test_helper'

class BlocksControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

end
