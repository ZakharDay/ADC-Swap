require "test_helper"

class ExchangeMinorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exchange_minors_index_url
    assert_response :success
  end

  test "should get show" do
    get exchange_minors_show_url
    assert_response :success
  end
end
