require "test_helper"

class ExplanationsControllerTest < ActionDispatch::IntegrationTest
  test "should get programming" do
    get explanations_programming_url
    assert_response :success
  end

  test "should get english" do
    get explanations_english_url
    assert_response :success
  end
end
