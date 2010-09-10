Feature: Authentication
  User should authenticate so that they can propose valuable sessions that foster participation

  Scenario: I should complete registration with email and password confirmation challenge
    Given I am not authenticated
    When I go to register
      And I fill in "user_email" with "thierry.henrio@gmail.com"
      And I fill in "user_password" with "devise_rocks"
      And I fill in "user_password_confirmation" with "devise_rocks"
      And I press "user_submit"
    Then I should see "Bonjour thierry.henrio@gmail.com"

  Scenario: I should sign in using email and password
    Given I have one user "gitster@git.org" with password "git rocks"
    When I go to the user session page
      And I fill in "user_email" with "gitster@git.org"
      And I fill in "user_password" with "git rocks"
      And I press "user_submit"
    Then I should see "Bonjour gitster@git.org"

  Scenario: I should be redirected to current conference when signing in
    Given I am not authenticated
      And I am on conferences/agile-france/2011
    When I go to the user session page
      And I fill in "user_email" with "gitster@git.org"
      And I fill in "user_password" with "git rocks"
      And I press "user_submit"
    Then I should be on conferences/agile-france/2011
