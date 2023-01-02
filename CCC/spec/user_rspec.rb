require "rails_helper"

RSpec.describe User, type: :model do
    subject{
        User.new(name: "Name User", surname:"User surname", email: "user.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    }

    fixtures :users
    
    describe "Validations" do

        it "should be valid" do
            expect(subject).to be_valid
        end
        
        it "name should be present" do
            subject.name = ""
            expect(subject).to_not be_valid
        end
        
        it "email should be present" do
            subject.email = ""
            expect(subject).to_not be_valid
        end
            
        it "name should not be too long" do
            subject.name = "a" * 51
            expect(subject).to_not be_valid
        end
        
        it "email should not be too long" do
            subject.email = "a" * 244 + "@example.com"
            expect(subject).to_not be_valid
        end
        
        it "email validation should accept valid addresses" do
            valid_addresses = %w[user.surname@uniroma1.it name.1234567@studenti.uniroma1.it]
            valid_addresses.each do |valid_address|
                subject.email = valid_address
                assert expect(subject).to be_valid, "#{valid_address.inspect} should be valid"
            end
        end
            
        it "email addresses should be unique" do
            duplicate_user = subject.dup
            subject.save
            expect(duplicate_user).to_not be_valid
        end
            
        it "email addresses should be saved as lowercase" do
            mixed_case_email = "NaMe.SunE@UnIRoMa1.iT"
            subject.email = mixed_case_email
            subject.save
            expect(mixed_case_email.downcase).to eq(subject.reload.email) 
        end
            
        it "password should be present (nonblank)" do
            subject.password = subject.password_confirmation = " " * 6
            expect(subject).to_not be_valid
        end
            
        it "password should have a minimum length" do
            subject.password = subject.password_confirmation = "a" * 5
            expect(subject).to_not be_valid
        end
        
        it "authenticated? should return false for a user with nil digest" do
            expect(subject).to_not be_authenticated(:remember, '')
        end
        
        it "associated posts should be destroyed" do
            subject.save
            subject.posts.create!(content: "Lorem ipsum", category: "Ingengeria")
            assert_difference 'Post.count', -1 do
                subject.destroy
            end
        end
        
        # it "should follow and unfollow a user" do
        #     michael = users(:michael)
        #     archer = users(:archer)
        #     expect(michael).to_not followed(archer)
        #     michael.follow(archer)
        #     expect(michael).to follow(archer)
        #     assert archer.followers.include?(michael)
        #     michael.unfollow(archer)
        #     assert_not michael.following?(archer)
            
        #     # Users can't follow themselves.
        #     michael.follow(michael)
        #     assert_not michael.following?(michael)
        # end
            
        it "feed should have the right posts" do
            michael = users(:michael)
            archer = users(:archer)
            lana = users(:lana)

            # Posts from followed user
            lana.posts.each do |post_following|
                assert michael.feed.include?(post_following)
            end
            
            # Self-posts for user with followers
            michael.posts.each do |post_self|
                assert michael.feed.include?(post_self)
            end
            
            # Posts from non-followed user
            archer.posts.each do |post_unfollowed|
                assert_not michael.feed.include?(post_unfollowed)
            end
        end
    end
end