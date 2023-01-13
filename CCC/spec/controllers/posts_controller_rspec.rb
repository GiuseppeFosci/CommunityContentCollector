require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe PostsController, type: :request do

    before(:all) do
      @post = create(:post)
      @user1 = @post.user
      @user2 = create(:user, email: "joe.banana@uniroma1.it")
    end
    
    after(:all) do
      @post.destroy
      @user1.destroy
      @user2.destroy
    end

    describe "Validations" do
        
        it "should redirect create when not logged in" do
            expect do
              post posts_path, params: { post: {content: @post.content, category: @post.category } }
            end.to_not change{Post.count}
            assert_redirected_to login_url
        end
    end
        
    describe "Post operations" do
        before {log_in_as(@user1) }
    
        it "should be able to create a post" do
          expect do
            post posts_path, params: { post: {content: @post.content, category: @post.category, files: []} }
          end.to change{Post.count}.from(1).to(2)
        end
        
        it "should be able to delete own post" do
          post posts_path, params: { post: {content: @post.content, category: @post.category, files: []} }
          post=@user1.posts.last
          expect do
            delete post_path(post)
          end.to change{Post.count}.from(2).to(1)
        end
        
        it "should be able to update own post" do
          post posts_path, params: { post: {content: @post.content, category: @post.category, files: []} }
          post=@user1.posts.last
          expect do
            patch post_path(post), params: { post: {content: "Updated content", category: "Ingegneria"}, id: post.id }
            post=@user1.posts.last
          end.to change{post.content}.from(@post.content).to("Updated content")
        end
          
    end
end
