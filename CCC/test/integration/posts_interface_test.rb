require "test_helper"

class PostsInterface < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class PostsInterfaceTest < PostsInterface
  
  test "should paginate posts" do
    get root_path
    assert_select 'div.pagination'
  end
  
  test "should show errors but not create post on invalid submission" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2' # Correct pagination link
  end
  
  test "should create a post on valid submission" do
    content = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end
  
  test "should have post delete links on own profile page" do
    get users_path(@user)
    assert_select 'a', text: 'Elimina'
  end
  
  test "should be able to delete own post" do
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
  end
  
  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'Elimina', count: 0 }
  end
end
