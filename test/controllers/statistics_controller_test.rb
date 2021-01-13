require "test_helper"

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get statistics_new_url
    assert_response :success
  end

  test "should get create" do
    get statistics_create_url
    assert_response :success
  end

  test "should get index" do
    get statistics_index_url
    assert_response :success
  end
end
