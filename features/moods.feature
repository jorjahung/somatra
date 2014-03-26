Feature: Mood Checker
In order to get a better picture of my overall wellbeing
As a health tracker 
I want to be able to track my moods

Scenario: Asks me what I am feeling
Given I am connected to the API
When I go to the homepage
Then mood-checker to should ask me how I'm feeling
And offer a way for me to tell it 

Scenario: Responds with a relevant greeting if I am feeling down
When I say I am feeling bad
Then mood-checker says sorry you are having a bad day

Scenario: Responds with a relevant greeting if I am feeling happy
When I say I am feeling happy
Then mood-checker says its glad I am in a good mood


Scenario: Stores that data in table that I can access later
When I go to the moods page
Then I should see a summary of all of my moods data