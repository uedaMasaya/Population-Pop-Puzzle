require "test_helper"

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get question_index_url
    assert_response :success
  end

  test "should get submit" do
    get question_submit_url
    assert_response :success
  end
end
