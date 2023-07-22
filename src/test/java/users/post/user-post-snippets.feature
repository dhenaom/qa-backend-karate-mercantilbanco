@Ignore
Feature: Reusable scenarios for post a user

  Background:
    * url "https://reqres.in"
    * path "/api/users/"
    * def req = {  "name": "mauro",  "job": "qa"  }

  @Create-user
  Scenario: Post a user
    Given request req
    When method post
    Then status 201
    And def contactId = $.id


