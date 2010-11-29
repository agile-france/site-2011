Feature: Admin
  An admin can perform administrative functions on site, so that site is in good shape
  
  Scenario: A signed in admin gains an admin link on standard layout
    Given the following user exists:
      |email            |password   |admin|
      |gitster@pobox.com|git rocks  |true |
      And I complete sign in form with email "gitster@pobox.com" and password "git rocks"
    Then I should see an "Admin" link
    
  Scenario: A signed in admin can search for users
    Given the following user exists:
      |email                |password   |admin  |
      |gitster@pobox.com    |git rocks  |true   |
      |learnyousome@git.com |git rocks  |false  |
      |gitter@nobox.com     |git rocks  |false  |
      And I complete sign in form with email "gitster@pobox.com" and password "git rocks"
      And I go to "/admin/users"
      And I fill in "q" with "/^git/"
      And I press "Search"
    Then I should see "gitster@pobox.com"
      And I should not see "learnyousome@git.com"

    
  
  
  
  
  