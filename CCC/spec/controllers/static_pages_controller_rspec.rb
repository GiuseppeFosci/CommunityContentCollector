require "rails_helper"

RSpec.describe StaticPagesController, type: :request do

    describe "Validations" do
        
        it "should get home" do
            get root_path
            assert_response :success
            assert_select "title", "Home | CCC"
        end
        
        it "should get help" do
            get help_path
            assert_response :success
            assert_select "title", "Aiuto | CCC"
        end
    end
end
