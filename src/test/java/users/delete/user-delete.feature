Feature: Delete user on Reqres

  Scenario: Delete a user
    #llamamps un escenario que crea al usuario y guarda el id en la variable 'contactId'
    * call read("../post/user-post-snippets.feature@Create-user")
    Given url "https://reqres.in" + "/api/users/" + contactId
    When method delete
    Then status 204