Feature: Post user to Reqres

  Background:
    * configure logPrettyResponse = true
    * configure logPrettyRequest = true
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
    * print response


# -> #(rolesTest.firstRol) extrae objeto definido desde karate-config.js
    Examples:
      | varName | job                   |
      | mauro   | #(rolesTest.firstRol) |
      | leandro | leader                |
      | pedro   | developer             |


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

  Scenario: Post a user with function en file JAVA
    * def randomUtils = Java.type('users.utils.NameUtils')
    * def randomName = randomUtils.generateRandomName()
    Given request {  "name": "#(randomName)",  "job": "qa"  }
    When method post
    Then status 201
    And match $.name == '#string'



#TODO pendiente Ejecuciones por consola, Tables, Matchers

#  * table data
#  | user     | account_type     | account_number     | state     |
#  | '<user>' | '<account_type>' | '<account_number>' | '<state>' |
#
#  * def resultList = call read('../listpockets/list_pockets.feature@SnippetListPocket') {data: data, pocket_number: '#(pocket_number)'}
#
#  * def dataRequest = { account_type: '#(data.account_type)', account_number:'#(data.account_number)', state: '#(data.state)'}

