require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "should get index" do
    get(:index, {'tag_id' => 4})
    assert_response :success
  end

  test "should get show" do
    get(:show, {'id' => 1, 'tag_id' => 4, 'content_type' => 'article'})
    assert_response :success
  end
end
