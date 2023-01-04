Given("I am logged in") do

    @user= User.new(name: "Name User", surname:"User surname", email: "user.user@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    @user.activate
    @user.save
    @altro= User.new(name: "Altro", surname:"Scaltro", email: "user.tser@uniroma1.it", password: "foobar", password_confirmation: "foobar")
    @altro.activate
    @altro.save
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
end

When /I click the "Segui" button/ do
    visit search_path
    fill_in "Nome", with: @altro.name
    fill_in "Cognome", with: @altro.surname
    click_on "Cerca utente"
    click_on @altro.name
    click_button "Segui"
end

Then /I should see the "Smetti di seguire" button/ do
    expect(page).to have_selector(:link_or_button, "Smetti di seguire")
end
