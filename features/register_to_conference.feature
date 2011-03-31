Feature: Register to conference

  Scenario: User can register to a conference
    Given I signed in as "kent@beck.org"
      And the following conference exists:
        |name |edition|
        |xp   |2033   |
      And the latest conference has the following offers for product "place":
        |ref    |quantity |price  |
        |early  |100      |220    |
    When I go to "/conferences/xp-2033/registrations/new?locale=fr"
    Then I should see /reste 100 places/
    When I fill in "orders[][quantity]" with "1"
      And I press "Valider"
    Then I should see /inscription(.+)enregistrée/
    
    