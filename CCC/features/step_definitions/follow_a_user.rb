Given("I am logged in") do

    @user= User.new(name: "Name User", surname:"User surname", email: "user.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    @user.activate
    @user.save
    @user2= User.new(name: "Name User 2", surname:"User surname 2", email: "user2.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    @user2.activate
    @user2.save
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
end

When /I click the "Segui" button/ do
    visit @user2_path
    click_on "commit"
end

Then("I should see the Smetti di seguire button") do
    expect(page).to have_content("Smetti di seguire")
end