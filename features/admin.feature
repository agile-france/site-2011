Feature: Admin
  An admin can perform administrative functions on site, so that site is in good shape
  
  Scenario: A signed in admin gains an 'Admin' link
    Given the following user exists:
      |email            |password   |admin|
      |gitster@pobox.com|git rocks  |true |
      And I complete sign in form with email "gitster@pobox.com" and password "git rocks"
    Then I should see "Admin"
  
  
  
  
  