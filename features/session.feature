Feature: Session
  User should propose sessions that make a good program, so that people attend

  Scenario: I should post a new session when logged
    Given I am a new, authenticated user
    And the following conference exists:
      |id |name |edition|
      |1  |xp   |2033   |
    When I go to "/conferences/1/sessions/new"
      And I fill in "session_title" with "courage"
      And I press "session_submit"
    Then show me the page
      And I should be on "/conferences/1"
      And I should see "courage"
