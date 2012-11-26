Feature: Merge Articles Prelim
  As a blog administrator
  In order be avoid similar duplicate articles from multiple bloggers
  I want to be able to merge articles on my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel
	And the following articles exist:
	|id| title        | body   									| author  | published |
	|2| Merge Me 1    | It was a dark and stormy night.  		| admin   | 1	      |
	|3| Merge Me 2    | Snoopy was reading "A Wrinkle in Time". | asprose | 1	      |

  Scenario: A new article should not allow merging
	Given I am on the new article page
	Then I should not see "Merge Articles"
	
  Scenario: An admin can merge articles
	Given I am on the edit article 1 page
	Then I should see "Merge Articles"

  Scenario: A non-admin cannot merge two articles
	Given I am logged in as a "contributor"
	And I am on the edit article 1 page
	Then I should not see "Merge Articles"
	
  Scenario: When articles are merged, the merged article should contain the text of both previous articles
 	Given I am logged in as an "admin"
	And I am on the edit article 2 page
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should be on the admin content page	
    When I go to the home page
    Then I should see "Merge Me 2 new"
    When I follow "Merge Me 2 new"
    Then I should see "dark and stormy"
	And I should see "Snoopy"
	And I should see "admin"
	And I should not see "asprose"