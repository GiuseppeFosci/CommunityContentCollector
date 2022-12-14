require "rails_helper"

RSpec.describe Relationship, type: :request do

    fixtures :relationships

    describe "Validations" do
        
        it "create should require logged-in user" do
            assert_no_difference 'Relationship.count' do
                post relationships_path
            end
            assert_redirected_to login_url
        end
        
        it "destroy should require logged-in user" do
            assert_no_difference 'Relationship.count' do
                delete relationship_path(relationships(:one))
            end
            assert_redirected_to login_url
        end
    end
end
