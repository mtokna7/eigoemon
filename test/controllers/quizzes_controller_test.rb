require "test_helper"

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get quizzes_show_url
    assert_response :success
  end
end
