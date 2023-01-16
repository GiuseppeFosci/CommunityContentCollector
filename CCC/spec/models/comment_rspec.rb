require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe Comment, type: :model do

    before(:all) do
        @post = create(:post)
        @user=@post.user
        @user1 = create(:user, email: "joe.banana@uniroma1.it")
    end

    after(:all) do
        @user.destroy
        @user1.destroy
        @post.destroy
    end

    describe "Validations" do {}
        before do
            @comment = @post.comments.build(content: "Commento di prova", user_id: @user1.id, post_id: @post.id)
            @comment.user_id
        end
        
        it "should be valid" do
            expect(@comment).to be_valid
        end
        
        it "should belong to an user" do
            expect(@comment.user_id).to be(@user1.id)
        end
        
        it "should belong to a post" do
            expect(@comment.post).to be(@post)
        end

        it "should belong only to the correct user" do
          expect(@comment.user).to_not be(@user)
        end

        it "should have content" do
          @comment.content= " "
          expect(@comment).to_not be_nil
        end
    end
end
