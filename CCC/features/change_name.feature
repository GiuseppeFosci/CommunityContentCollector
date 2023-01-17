Feature: I want to change my name
  As a user
  I want to update my profile
  so that i can change my name
  
Scenario: Change my name
  Given I'm logged in
  When I submit the profile form changing my name
  Then I should see the profile page with the name updated