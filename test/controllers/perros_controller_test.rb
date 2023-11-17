require "test_helper"

class PerrosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get perros_new_url
    assert_response :success
  end

  test "should get create" do
    get perros_create_url
    assert_response :success
  end
end
