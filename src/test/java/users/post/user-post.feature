Feature: Post user to Reqres

  Background:
    * configure logPrettyResponse = true
    * configure logPrettyRequest = true
    * url api.baseUrl
    * path "/api/users/"
    * def req = {  "name": "mauro",  "job": "qa"  }

  @Retry #Intenta 3 veces por defecto con intervalo de 3 segundos
  Scenario: Post a user with retry
    Given request req
    And retry until responseStatus != 201
    When method post
    Then status 204

  @Retry_with_configuration
  Scenario: Post a user with retry with configuration
    * configure retry = { count: 4, interval: 5000 }
    Given request req
    And retry until responseStatus != 502 && responseStatus != 504
    When method post
    Then status 201
    And match $.name == 'mauro'

  @Outline-variables
  Scenario Outline: Post some users
    Given request  {  "name": "#(varName)",  "job": "<job>"  }
    When method post
    Then status 201
    * print response
# -> #(rolesTest.firstRol) extrae objeto definido desde karate-config.js
    Examples:
      | varName | job                   |
      | mauro   | #(rolesTest.firstRol) |
      | leandro | leader                |
      | pedro   | developer             |


  @Js_functions-fuzzy_matching
  Scenario: Post a user with function js
    * def uuid = function(){ return java.util.UUID.randomUUID() + ""}
    * def generateRandomName =
        """
        function(){
          var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
          var randomString = '';
          for (var i = 0; i < 10; i++) {
            var randomIndex = Math.floor(Math.random() * chars.length);
            randomString += chars.charAt(randomIndex);
          }
          return randomString;
        }
        """
    * def randomName = generateRandomName()
    Given request {  "name": "#(randomName)",  "job": "#(uuid())"  }
    When method post
    Then status 201
    And match $.name == '#string'

  @Java_functions-fuzzy_matching
  Scenario: Post a user with function en file JAVA
    * def randomUtils = Java.type('users.utils.NameUtils')
    * def randomName = randomUtils.generateRandomName()
    Given request {  "name": "#(randomName)",  "job": "qa"  }
    When method post
    Then status 201
    And match $.name == '#string'






