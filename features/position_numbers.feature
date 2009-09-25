Feature: Active/Inactive Position Number flags
  In order to reuse position numbers
  As a Facility manager
  I want to be able to change the 'active' state of a position number

  Scenario: Set a position number to inactive
    Given I am a logged in facility manager
    And I am assigned to a facility "Acme"
    And the facility has a position "Clerk"
    And the facility has a position_number "12345"
    And the facility has an employee "Bob Keyt"
    And the the employee is assigned to the position_number
    And I am on the Position Numbers page
    When I follow edit "Bob Keyt"
    And I click "active"
    And I submit the form
    Then I should see "Active? Inactive"
