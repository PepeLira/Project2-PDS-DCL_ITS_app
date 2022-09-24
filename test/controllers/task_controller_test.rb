require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get task_view_url
    assert_response :success
  end
end
