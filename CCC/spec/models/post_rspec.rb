require "rails_helper"

RSpec.describe Post, type: :model do
    
    before(:all) do
        @post = create(:post)
        @user1 = @post.user
    end
    
    after(:all) do
        @post.destroy
        @user1.destroy
    end
    
    describe "validations" do
        
        it "post should be valid" do
            post = @user1.posts.build(category: @post.category, content: @post.content)
            assert post.valid?
        end
    
        it "user id should be present" do
            post = @user1.posts.build(category: @post.category, content: @post.content)
            post.user_id = nil
            expect(post).to_not be_valid
        end
        
        it "content should be present" do
            post = @user1.posts.build(category: @post.category, content: " ")
            expect(post).to_not be_valid
        end
        
        it "category should be present" do
            post = @user1.posts.build(category: " ", content: @post.content)
            expect(post).to_not be_valid
        end
        
        it "content should be at most 10000 characters" do
            post = @user1.posts.build(category: @post.category, content: "a" * 10001)
            expect(post).to_not be_valid
        end
        
        it "post should show comments" do
            post = @user1.posts.build(category: @post.category, content: @post.content)
            comment = post.comments.build(content: "Prova", user_id: @user1.id, post_id: post.id)
            expect(post.comments).to_not be_empty
        end

    end
end
