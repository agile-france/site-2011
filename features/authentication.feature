Feature: Authentication
  User should authenticate so that they can pay valuable conference items

  Scenario: password challenge
    Given I am not authenticated
    When I go to register
    When I fill in "user_email" with "thierry.henrio@gmail.com"
      And I fill in "user_password" with "devise_rocks"
      And I fill in "user_password_confirmation" with "devise_rocks"
      And I press "user_submit"
    Then I should see "Signed in as thierry.henrio@gmail.com"