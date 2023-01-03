require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe SessionsHelper, type: :request do

    fixtures :users

    describe "Validations" do
        
        it "current_user returns right user when session is nil" do
            user = users(:michael)
            remember(user)
            assert_equal user, current_user
            assert is_logged_in?
        end
        
        it "current_user returns nil when remember digest is wrong" do
            user = users(:michael)
            remember(user)
            user.update_attribute(:remember_digest, User.digest(User.new_token))
            assert_nil current_user
        end
    end
end