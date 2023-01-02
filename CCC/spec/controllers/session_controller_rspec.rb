require "rails_helper"

RSpec.describe SessionsController, type: :request do

    describe "Validations" do
        
        it"should get new" do
            get login_path
            assert_response :success
        end
    end
end