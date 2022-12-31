require "rails_helper"

RSpec.describe "route for home", type: :routing do
    it "routes/home to the home controller" do
        expect(get("/")).to route_to("static_pages#home")
    end 
end

RSpec.describe "route for help", type: :routing do
    it "routes/help to the help controller" do
        expect(get("/help")).to route_to("static_pages#help")
    end
end
