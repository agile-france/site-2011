Feature: Session
  User should propose sessions that make a good program, so that people attend

  Scenario: I should post a new session when logged
    Given I am a new, authenticated user
      And the following conference exists:
        |id                         |name |edition|
        |123456789012345678901234   |xp   |2033   |
    When I go to "/conferences/123456789012345678901234/sessions/new"
      And I fill in "session_title" with "courage"
      And I press "session_submit"
    Then I should be on "/conferences/123456789012345678901234"
      And I should see "courage"
