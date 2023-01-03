require "rails_helper"
require "rspec_helper"

RSpec.configure do |c|
    c.include Rspec_helper
end

RSpec.describe Relationship, type: :model do

    fixtures :users

    subject{
        Relationship.new(follower_id: users(:michael).id, followed_id: users(:archer).id)
    }

    describe "Validations" do
        
        it "should be valid" do
            assert subject.valid?
        end
        
        it "should require a follower_id" do
            subject.follower_id = nil
            expect(subject).to_not be_valid
        end
        
        it "should require a followed_id" do
            subject.followed_id = nil
            expect(subject).to_not be_valid
        end
    end
end
