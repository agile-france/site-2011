Feature: Authentication
  User should authenticate so that they can pay valuable conference items

  Scenario: password challenge
    Given I am not authenticated
    When I go to register
      And I fill in "mail" with "thierry.henrio@gmail.com"
      And I fill in "password" with "devise_rocks"
      And I fill in "password_confirmation" with "devise_rocks"
    Then I should see "successfully logged on"