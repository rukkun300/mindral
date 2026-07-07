require "test_helper"

class CheckControllerTest < ActionDispatch::IntegrationTest
  test "should get up" do
    get check_up_url
    assert_response :success
  end
end
