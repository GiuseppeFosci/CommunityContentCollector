Given("I'm logged in") do

    @user= User.new(name: "Name User", surname:"User surname", email: "user.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    @user.activate
    @user.save
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
end

When /I create the post/ do
    click_on "Home"
    fill_in "post_content", with: "Prova"
    select "Ingegneria", from: "post_category"
end

When /I press the "Post" button/ do
    click_button "Post"
end

Then("I should see the post") do
    expect(page).to have_content("Prova")
end