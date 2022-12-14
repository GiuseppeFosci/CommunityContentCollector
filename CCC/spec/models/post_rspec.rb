require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe Post, type: :model do

    fixtures :users, :posts
    
    describe "validations" do
        
        it "should be valid" do
            user= users(:michael)
            post= user.posts.build(content: "Test di post", category: "Economia")
            assert post.valid?
        end
    
        it "user id should be present" do
            user = users(:michael)
            post = user.posts.build(content: "Test di post", category: "Economia")
            post.user_id = nil
            expect(post).to_not be_valid
        end
        
        it "content should be present" do
            user = users(:michael)
            post = user.posts.build(content: "Test di post", category: "Economia")
            post.content = " "
            expect(post).to_not be_valid
        end
        
        it "content should be at most 10000 characters" do
            user = users(:michael)
            post = user.posts.build(content: "Test di post", category: "Economia")
            post.content = "a" * 10001
            expect(post).to_not be_valid
        end
        
        it "order should be most recent first" do
            assert_equal posts(:most_recent), Post.first
        end
    end
end
