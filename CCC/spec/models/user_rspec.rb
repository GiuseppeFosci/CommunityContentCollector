require "rails_helper"

RSpec.describe User, type: :model do
    
    before(:all) do
        @user1 = create(:user)
    end
    
    after(:all) do
        @user1.destroy
    end
    
    describe "Validations" do

        it "should be valid" do
            expect(@user1).to be_valid
        end
        
        it "name should be present" do
            user2 = build(:user, name: "", email: "joe.beans@uniroma1.it")
            expect(user2).to_not be_valid
        end
        
        it "email should be present" do
            user2 = build(:user, email: "")
            expect(user2).to_not be_valid
        end
        
        it "email should be unique" do
            user2 = build(:user)
            expect(user2).to_not be_valid
        end
            
        it "name should not be too long" do
            user2 = build(:user, name: "a" * 51, email: "joe.beans@uniroma1.it")
            expect(user2).to_not be_valid
        end
        
        it "email should not be too long" do
            user2= build(:user, email: "a" * 244 + ".a" + "@uniroma1.it")
            expect(user2).to_not be_valid
        end
        
        it "email validation should only accept valid addresses" do
            valid_addresses = %w[user.surname@uniroma1.it name.1234567@studenti.uniroma1.it]
            valid_addresses.each do |valid_address|
                user2 = build(:user, email: valid_address)
                assert expect(user2).to be_valid, "#{valid_address.inspect} should be valid"
            end
        end
            
        it "password should be present (nonblank)" do
            password = " " * 6
            user2 = build(:user, password: password, password_confirmation: password)
            expect(user2).to_not be_valid
        end
            
        it "password should have a minimum length" do
            password = "a" * 5
            user2 = build(:user, password: password, password_confirmation: password)
            expect(user2).to_not be_valid
        end
        
        it "authenticated? should return false for a user with nil remember digest" do
            expect(@user1).to_not be_authenticated(:remember, '')
        end
        
        it "associated posts should be destroyed" do
            user2 = build(:user, email: "joe.beans@uniroma1.it")
            user2.save
            user2.posts.create!(content: "Lorem ipsum", category: "Ingengeria")
            expect do
              user2.destroy
            end.to change{ Post.count }.from(1).to(0)
        end
        
        it "should follow and unfollow a user" do
            user2 = build(:user, email: "joe.beans@uniroma1.it")
            expect(@user1.following?(user2)).to be false
            @user1.follow(user2)
            expect(@user1.following?(user2)).to be true
            assert user2.followers.include?(@user1)
            @user1.unfollow(user2)
            expect(@user1.following?(user2)).to be false
            
            # Users can't follow themselves.
            @user1.follow(@user1)
            expect(@user1.following?(@user1)).to be false
        end
            
        it "feed should have the right posts" do
            user2 = build(:user, email: "joe.beans@uniroma1.it")
            user3 = build(:user, email: "joe.zucchini@uniroma1.it")

            # Posts from followed user
            user3.posts.each do |post_following|
                assert @user1.feed.include?(post_following)
            end
            
            # Self-posts for user with followers
            @user1.posts.each do |post_self|
                assert @user1.feed.include?(post_self)
            end
            
            # Posts from non-followed user
            user2.posts.each do |post_unfollowed|
                expect(@user1.feed).to_not include(post_unfollowed)
            end
        end
    end
end
