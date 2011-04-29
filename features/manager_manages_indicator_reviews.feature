Feature: A contract manager can manage indicator reviews
  As a contract manager
  I want to create, edit, and delete indicator reviews
  So that my facility will be charged and penalized for non-compliance
  in accordance with our contracts.

  Background:
    Given I am a logged in contract manager
    And   the indicator "Clothes and Amenities" is due this month

  Scenario: I can create and edit an indicator review
    When  I go to the PPPAMS Home page
    And   I follow "Create a new review for this indicator"
    Then  I should see "New PPPAMS Review"
    When  I select "Compliant" from "Score"
    And   I fill in the following:
      | Observation ref   | Some observation Reference             |
      | Documentation ref | Some documentation that refers to this |
      | Interview ref     | I talked to Joe                        |
      | Notes             | And these are my notes                 |
    And   I press "Create"
    Then  I should see "Pppams Review was successfully created"
    And   I should see the link "Edit the review for this indicator"
    When I follow "Edit the review for this indicator"
    Then  I should see "Editing PPPAMS Review"
    And   I should see "Some observation Reference"
    And   I fill in the following:
      | Observation ref | Other ref |
    And   I select "Non-Compliant" from "Score"
    And   I press "Save"
    Then  I should see "Pppams Review was successfully updated"

  Scenario: I cannot edit a locked indicator review
    Given the review's "status" is "Locked"
    When  I go to the PPPAMS Home page
    Then  I should not see the link "Edit the review for this indicator"

  Scenario: I can edit an indicator review for old indicators (and they show up as 1 thru 10)
    Given I am on the PPPAMS Home page
    When I select "2010" from "Live indicators this month"
    And   I follow "Create a new review for this indicator"
    Then  "0 - Non-performance" should be an option in "Score"


