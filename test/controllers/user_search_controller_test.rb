require "test_helper"

class UserSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get user_search_search_url
    assert_response :success
  end
end
