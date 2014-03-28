Feature: Diary

  In order to keep track of all the data in one place
  As a health tracker
  I want to see an area that summarizes all the data

Scenario: view results that are in the danger zone
  Given I visit the homepage
  Then I should be able to see the latest entry
  And I should see the results that I should be aware of
