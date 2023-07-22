Feature: Post user to Reqres

  Background:
    * url "https://reqres.in"
    * path "/api/users/"
    * def req = {  "name": "mauro",  "job": "qa"  }

  Scenario: Post a user
    Given request req
    When method post
    Then status 201
    And match $.name == 'mauro'

  Scenario Outline: Post some users
    Given request  {  "name": "#(varName)",  "job": "<job>"  }
    When method post
    Then status 201

    Examples:
      | varName | job       |
      | mauro   | qa        |
      | leandro | leader    |
      | pedro   | developer |