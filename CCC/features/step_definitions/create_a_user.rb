Given("I'm not logged in") do
    visit signup_path
    fill_in "user_name", with: "Nome"
    fill_in "user_surname", with: "Cognome"
    fill_in "user_email", with: "email.utente@uniroma1.it"
    fill_in "user_password", with: "Password Utente"
    fill_in "user_password_confirmation", with: "Password Utente"
  end
  
  When /I submit the signup form/ do
    click_button "Crea il mio account"
  end
  
  Then("I should see the profile page") do
    expect(page).to have_content("Controlla la tua email" )
  end