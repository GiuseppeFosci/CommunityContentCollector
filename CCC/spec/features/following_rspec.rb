require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

# RSpec.describe Following, type: :integration do

#   def setup
#     @user = users(:michael)
#     @other = users(:archer)
#     log_in_as(@user)
#   end
# end

RSpec.describe "FollowingTest", type: :controller do
    
    fixtures :users

    describe "Validations" do
        
        it "following page" do
            user= users(:michael)
            get following_user_path(user)
            assert_response :unprocessable_entity
            assert_not @user.following.empty?
            assert_match @user.following.count.to_s, response.body
            user.following.each do |user|
                assert_select "a[href=?]", user_path(user)
            end
        end
        
        it "followers page" do
            user= users(:michael)
            get followers_user_path(user)
            assert_response :unprocessable_entity
            assert_not @user.followers.empty?
            assert_match @user.followers.count.to_s, response.body
            user.followers.each do |user|
                assert_select "a[href=?]", user_path(user)
            end
        end
    end
end

# RSpec.describe Follow < Following do
    
#     it "should follow a user the standard way" do
#         assert_difference "@user.following.count", 1 do
#             post relationships_path, params: { followed_id: @other.id }
#         end
#         assert_redirected_to @other
#     end
    
#     it "should follow a user with Hotwire" do
#         assert_difference "@user.following.count", 1 do
#             post relationships_path(format: :turbo_stream), params: { followed_id: @other.id }
#         end
#     end
# end

# RSpec.describe Unfollow < Following do
    
#     def setup
#         super
#         @user.follow(@other)
#         @relationship = @user.active_relationships.find_by(followed_id: @other.id)
#     end
# end

# RSpec.describe UnfollowTes< Unfollow
  
#   test "should unfollow a user the standard way" do
#     assert_difference "@user.following.count", -1 do
#       delete relationship_path(@relationship)
#     end
#     assert_response :see_other
#     assert_redirected_to @other
#   end
  
#   test "should unfollow a user with Hotwire" do
#     assert_difference "@user.following.count", -1 do
#       delete relationship_path(@relationship, format: :turbo_stream)
#     end
#   end
# end