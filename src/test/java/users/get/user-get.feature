Feature: Get user from Reqres

  Background:
    * url "https://reqres.in"

  Scenario: Get a user
    Given path "/api/users/" + "2"
    When method get
    Then status 200

  Scenario: Get user list
    * def jsonResponse = read("../json/list_of_users.json")
    Given path "/api/users?page=1"
    When method get
    Then status 200
    And match $  == jsonResponse