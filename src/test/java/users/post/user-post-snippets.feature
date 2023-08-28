@Ignore
Feature: Reusable scenarios for post a user

  Background:
    * url "https://reqres.in"

  @Create-user
  Scenario: Post a user
    * path "/api/users/"
    Given request {  "name": "mauro",  "job": "qa"  }
    When method post
    Then status 201
    And def contactId = $.id

  @Create-user-table-variable
  Scenario: Post a user with table and variable received
    * path path
    Given request {  "name": "#(data.name)",  "job": "#(data.job)"  }
    When method post
    Then status 201
    And def contactId = $.id

  @Create-user-only-table
  Scenario: Post a user with only table received
    * path "/api/users/"
    Given request {  name: "#(name)",  job: '#(job)'  }
    When method post
    Then status 201
    And def contactId = $.id
    * print "el id del usuario creado es " + contactId


