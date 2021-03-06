Feature: internationalization
  User should see native message, so that language value is preserved and communication enhanced
  
  Scenario: I can see message in default locale, when I do not specify any else
    When I go to "/"
    Then I should see "Se connecter"
      
  Scenario: I can see message in the locale I provide
    When I go to "/?locale=en"
      Then I should see "Sign in"

  Scenario: Provided locale is preserved on query string
    Given I am on "/?locale=en"
    When I follow "Sign in"
    Then I should have the following query string:
      |locale|en|