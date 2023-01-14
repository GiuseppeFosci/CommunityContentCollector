require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe UsersController, type: :request do

    before(:all) do
        @user1 = create(:user, admin: true)
        @user2 = create(:user, email: "joe.banana@uniroma1.it")
    end

    describe "Validations" do
        
        it "should get signup page" do
            get users_new_url
            expect(response).to have_http_status(:success)
        end

        it "should redirect index when not logged in" do
            get users_path
            assert_redirected_to login_url
        end
        it "should redirect edit when not logged in" do
            get edit_user_path(@user1)
            expect(flash).to_not be_empty
            assert_redirected_to login_url
        end
        
        it "should redirect update when not logged in" do
            patch user_path(@user1), params: { user: { name: @user1.name, email: @user1.email } }
            expect(flash).to_not be_empty
            assert_redirected_to login_url
        end

        it "should create new user with activation" do 
            post users_path, params: { user: { name: @user1.name, surname: @user1.surname, email: "studente.1234567@studenti.uniroma1.it", password: @user1.password, password_confirmation: @user1.password } }
            expect(flash).to_not be_empty
            User.last.activate
            expect(User.last).to be_valid
        end
          
        it "should redirect edit when logged in as wrong user" do
            log_in_as(@user2)
            get edit_user_path(@user1)
            expect(flash).to be_empty
            assert_redirected_to root_url
        end
        
        it "should redirect update when logged in as wrong user" do
            log_in_as(@user2)
            patch user_path(@user1), params: { user: { name: @user1.name, email: @user1.email } }          
            assert_redirected_to root_url
        end
        
        it "should redirect destroy when not logged in" do
            expect do
              delete user_path(@user1)
            end.to_not change{ User.count }
            expect(response).to have_http_status(:see_other)
            assert_redirected_to login_url
        end
        
        it "should redirect destroy when logged in as a non-admin" do
            log_in_as(@user2)
            expect do
              delete user_path(@user1)
            end.to_not change{ User.count }
            expect(response).to have_http_status(:see_other)
            assert_redirected_to root_url
        end
        
        it "should redirect following when not logged in" do
            get following_user_path(@user1)
            assert_redirected_to login_url
        end
        
        it "should redirect followers when not logged in" do
            get followers_user_path(@user1)
            assert_redirected_to login_url
        end

        it "admin should destroy user " do
            log_in_as(@user1)
            expect do
                delete user_path(@user2)
            end.to change {User.count}.from(2).to(1)      
        end

        
  
    end
end
