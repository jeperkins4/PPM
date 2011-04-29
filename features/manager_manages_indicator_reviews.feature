Feature: A contract manager can manage indicator reviews
  As a contract manager
  I want to create, edit, and delete indicator reviews
  So that my facility will be charged and penalized for non-compliance
  in accordance with our contracts.

  Background:
    Given I am a logged in contract manager
    And   the indicator "Clothes and Amenities" is due this month

  Scenario: I can create an indicator review
    When  I go to the PPPAMS Home page
    And   I follow "Create a new review for this indicator"
    Then  I should see "New PPPAMS Review"
    When  I select "Compliant" from "Score"
    And   I press "Create"
    Then  I should see "errors prohibited"

  @wip
  Scenario: I can edit an indicator review

  @wip
  Scenario: I cannot edit a locked indicator review

  @wip
  Scenario: I can edit an indicator review for old indicators (and they show up as 1 thru 10)
