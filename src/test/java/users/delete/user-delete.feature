Feature: Delete user on Reqres

  @Calls-Reused
  Scenario: Delete a user
    #llamamps un escenario que crea al usuario y guarda el id en la variable 'contactId'
    * call read("../post/user-post-snippets.feature@Create-user")
    Given url "https://reqres.in" + "/api/users/" + contactId
    When method delete
    Then status 204

  @Tables-Calls
  Scenario: Delete a user with table a variable sent
    * table data
      | name    | job  |
      | "mauro" | "qa" |
    #llamamps un escenario que crea al usuario y guarda el id en la variable 'contactId'
    * call read("../post/user-post-snippets.feature@Create-user-table-variable") {data: data, path: "/api/users/"}
    Given url "https://reqres.in" + "/api/users/" + contactId
    When method delete
    Then status 204

  @Tables-Calls-Conditionals-only-table
  Scenario: Delete a user only table sent
    * table data1
      | name    | job         |
      | "mauro" | "qa-junior" |
    * table data2
      | name    | job         |
      | "johan" | "qa-master" |
    * def option = 2
    * def data = option == 1 ? data1 : data2
    #llamamos un escenario que crea al usuario y guarda el id en la variable 'contactId'
    * def results = call read("../post/user-post-snippets.feature@Create-user-only-table") data
    * print results
    Given url "https://reqres.in" + "/api/users/" + results.contactId
    When method delete
    Then status 204



