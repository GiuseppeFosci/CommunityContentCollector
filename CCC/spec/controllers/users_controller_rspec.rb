require "rails_helper"
require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe UsersController, type: :request do

    fixtures :users
    
    # subject{    
    #     @user = users(:michael)
    #     @other_user = users(:archer)
    # }

    describe "Validations" do
        
        it "should get new" do
            get users_new_url
            assert_response :success
        end
        
        it "should redirect index when not logged in" do
            get users_path
            assert_redirected_to login_url
        end
        
        it "should redirect edit when not logged in" do
            user= users(:michael)
            get edit_user_path(user)
            assert_not flash.empty?
            assert_redirected_to login_url
        end
        
        it "should redirect update when not logged in" do
            user= users(:michael)
            patch user_path(user), params: { user: { name: user.name, email: user.email } }
            assert_not flash.empty?
            assert_redirected_to login_url
        end
        
        it "should redirect edit when logged in as wrong user" do
            user= users(:michael)
            other_user= users(:archer)
            log_in_as(other_user)
            get edit_user_path(user)
            assert flash.empty?
            assert_redirected_to root_url
        end
        
        it "should redirect update when logged in as wrong user" do
            user= users(:michael)
            other_user= users(:archer)
            log_in_as(other_user)
            patch user_path(user), params: { user: { name: user.name, email: user.email } }
            assert flash.empty?
            assert_redirected_to root_url
        end
        
        it "should redirect destroy when not logged in" do
            user= users(:michael)
            assert_no_difference 'User.count' do
                delete user_path(user)
            end
            assert_response :see_other
            assert_redirected_to login_url
        end
        
        it "should redirect destroy when logged in as a non-admin" do
            user= users(:michael)
            other_user= users(:archer)
            log_in_as(other_user)
            assert_no_difference 'User.count' do
                delete user_path(user)
            end
            assert_response :see_other
            assert_redirected_to root_url
        end
        
        it "should redirect following when not logged in" do
            user= users(:michael)
            get following_user_path(user)
            assert_redirected_to login_url
        end
        
        it "should redirect followers when not logged in" do
            user= users(:michael)
            get followers_user_path(user)
            assert_redirected_to login_url
        end
    end
end