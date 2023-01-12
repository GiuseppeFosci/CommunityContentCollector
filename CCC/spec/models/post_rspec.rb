require "rails_helper"

RSpec.describe Post, type: :model do
    
    before(:all) do
        @user1 = create(:user)
    end
    
    describe "validations" do
        
        it "post should be valid" do
            post = @user1.posts.build(:post)
            assert post.valid?
        end
    
        it "user id should be present" do
            post = @user1.posts.build(:post)
            post.user_id = nil
            expect(post).to_not be_valid
        end
        
        it "content should be present" do
            post = @user1.posts.build(:post, content: " ")
            expect(post).to_not be_valid
        end
        
        it "content should be at most 10000 characters" do
            post = @user1.posts.build(:post, content: "a" * 10001)
            expect(post).to_not be_valid
        end
        
        it "order should be most recent first" do
            assert_equal posts(:most_recent), Post.first
        end
    end
end
