Feature: Play the Star Wars quotes Game

  Scenario: Answer the questions correctly
    Given I am on the main game page
    When I put my name as "Adrian"
    And I give the right answers 
    Then I should see a message "Congratulations Adrian! You are a true Star Wars fan!"


