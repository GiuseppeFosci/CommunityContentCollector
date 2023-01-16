When /I submit the profile form changing my name/ do
    visit edit_user_path(@user)
    fill_in "Nome", with: @user.name+"_updated"
    click_button "Salva modifiche"
end

Then("I should see the profile page with the name updated") do
    expect(page).to have_content(@user.name+"_updated")
end