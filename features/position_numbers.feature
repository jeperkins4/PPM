Feature: Active/Inactive Position Number flags
  In order to reuse position numbers
  As a Facility manager
  I want to be able to change the 'active' state of a position number

  Scenario: Set a position number to inactive
    Given I am a logged in facility manager for the facility "Acme"
    And the facility has a position "Clerk"
    And the position has a position_number "12345"
    And the facility has an employee "Bob Keyt"
    And the the employee is assigned to the position_number
    And I am on the Position Numbers page
    When I follow "edit"
    Then the "Active" checkbox should be checked
    When I uncheck "Active"
    And I press "Save"
    Then I should see "Inactive position number"

  Scenario: Employee position functionality should allow entry of inactive position numbers
    Given I am set up to use position_numbers for "Acme"
    And the facility has an inactive position_number "444555222"
    And I am on the employee position history page
    When I fill in the following:
      | Position Number | 444555222  |
      | Employee        | Bob Keyt   |
      | Start Date      | 2007-01-01 |
      | End Date        | 2008-01-01 |
    And I press "Save"
    Then I should see /444555222.*Bob Keyt/ within "tr"


