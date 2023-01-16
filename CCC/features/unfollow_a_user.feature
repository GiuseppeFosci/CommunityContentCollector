Feature: I want to unfollow a user
  As a user
  I want to unfollow another user
  so that i can unfollow another user

Scenario: Unfollow a user
  Given I am logged in
  When I click the "Smetti di seguire" button
  Then I should see the "Segui" button 