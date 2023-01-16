Feature: I want to create a user
  As a guest
  I want to create a user
  so that i can create a profile

Scenario: User create a profile
  Given I'm not logged in
  When I submit the signup form
  Then I should see the profile page