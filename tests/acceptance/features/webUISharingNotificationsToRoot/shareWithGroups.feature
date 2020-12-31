@app-required @notifications-app-required @notToImplementOnOCIS
Feature: Sharing files and folders with internal groups
  As a user
  I want to share files and folders with groups
  So that those groups can access the files and folders

  Background:
    Given app "notifications" has been enabled
    And these users have been created with default attributes:
      | username |
      | user1    |
      | user2    |
      | user3    |
    And these groups have been created:
      | groupname |
      | grp1      |
    And user "user1" has been added to group "grp1"
    And user "user2" has been added to group "grp1"
    And user "user2" has logged in using the webUI


  Scenario: notifications about new share is displayed
    Given the setting "shareapi_auto_accept_share" of app "core" has been set to "no"
    And user "user3" has shared folder "/simple-folder" with group "grp1"
    And user "user3" has shared folder "/data.zip" with group "grp1"
    When the user reloads the current page of the webUI
    Then the user should see the notification bell on the webUI
    And the user should see 2 notifications on the webUI with these details
      | title                                        |
      | "User Three" shared "simple-folder" with you |
      | "User Three" shared "data.zip" with you      |
    When the user re-logs in as "user1" using the webUI
    Then the user should see 2 notifications on the webUI with these details
      | title                                        |
      | "User Three" shared "simple-folder" with you |
      | "User Three" shared "data.zip" with you      |

