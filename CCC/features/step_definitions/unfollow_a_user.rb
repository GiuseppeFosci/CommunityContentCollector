When /I click the "Smetti di seguire" button/ do
    visit search_path
    fill_in "Nome", with: @altro.name
    fill_in "Cognome", with: @altro.surname
    click_on "Cerca utente"
    click_on @altro.name
    click_button "Segui"
    click_button "Smetti di seguire"
end

Then /I should see the "Segui" button/ do
    expect(page).to have_selector(:link_or_button, "Segui")
end
