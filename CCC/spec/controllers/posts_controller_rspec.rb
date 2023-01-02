require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe PostsController, type: :request do

    fixtures :posts, :users

    describe "Validations" do
        
        it "should redirect create when not logged in" do
            assert_no_difference 'Post.count' do
                post posts_path, params: { post: { content: "Lorem ipsum", category: "Ingegneria" } }
            end
            assert_redirected_to login_url
        end
        
        it "should redirect destroy when not logged in" do
            post= posts(:orange)
            assert_no_difference 'Post.count' do
                delete post_path(post)
            end
            assert_response :see_other
            assert_redirected_to login_url
        end
        
        it "should redirect destroy for wrong post" do
            log_in_as(users(:michael))
            post = posts(:ants)
            assert_no_difference 'Post.count' do
                delete post_path(post)
            end
            assert_response :see_other
            assert_redirected_to root_url
        end
    end
end