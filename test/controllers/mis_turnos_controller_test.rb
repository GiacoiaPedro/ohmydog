require "test_helper"

class MisTurnosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mis_turnos_index_url
    assert_response :success
  end
end
