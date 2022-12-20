require "test_helper"

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @post = Post.new(content: "Test di post", user_id: @user.id)
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "content should be present" do
    @post.content = " "
    assert_not @post.valid?
  end
  
  test "content should be at most 10000 characters" do
    @post.content = "a" * 10001
    assert_not @post.valid?
  end
end
