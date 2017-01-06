require 'test_helper'

class TopTensControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get(:show, {'id' => 25})
    assert_response :success
  end

  test "should get random" do
    get :random
    assert_response :success
  end
end
