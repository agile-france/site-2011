Feature: Rate a session
  User can rate a session, so he participate to program
  
  @javascript
  Scenario: I can rate another's session when signed in
    Given I signed in as "kent@beck.org"
      And "kent@beck.org" propose following session:
        |id                           |title        |description            |
        |123456789012345678901234     |explained    |installed and explained|
      And I signed out
      And I sign in as "ron@jeffries.org"
      And I go to "/sessions/123456789012345678901234"
    When I follow "J'adore"
    Then I should see "1 vote"
      And I should see "Moyenne : 5.0"