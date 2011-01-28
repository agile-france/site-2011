Feature:Account
  Scenario: User can add personal informations, so that we know more of him
    Given I am a new, authenticated user
      And I am on "/"
    When I follow "Mon Compte"
    Then I should see "Biographie"