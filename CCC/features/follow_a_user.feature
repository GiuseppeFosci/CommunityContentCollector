Feature: I want to follow a user
  As a user
  I want to follow another user
  so that i can follow another user

Scenario: Follow a user
  Given I am logged in
  When I click the "Segui" button
  Then I should see the "Smetti di seguire" button 
