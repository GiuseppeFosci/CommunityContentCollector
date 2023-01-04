Feature: I want to add a post
  As a user
  I want to add a post
  so that i can add posts to my profile

Scenario: User add a post
  Given I'm logged in
  When I create the post
  And I press the "Post" button
  Then I should see the post