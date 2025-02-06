Feature: Desbloqueo de usuario y autenticadores en Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def requestBody = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonRequest/bobyRequestUnlockUser.json')
    * def response200 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/200.json')
    * def response400 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/400.json')
    * def response401 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/401.json')
    * def response403 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/403.json')
    * def response404 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/404.json')
    * def response500 = read('classpath:pa/com/bancomercantil.authentication/karate/unlockuser/jsonResponse/500.json')
    * header Content-Type = 'application/json'

  @unlockSuccess
  Scenario: Desbloqueo exitoso del usuario y autenticadores
    * def uuid = 'e2beb200-11ad-47aa-8b5a-5fbbc750f8e0'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "#(uuid)" }
    When method POST
    Then status 200
    And match response == response200.unlock_success_response

  @nullUserId
  Scenario: Intento de desbloqueo con id de usuario nulo
    * def uuid = '11111111-1111-1111-1111-111111111111'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": null }
    When method POST
    Then status 404
    And match response.statusCode == '404'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data.errorDetails.fields.exceptionMessage contains 'User not found with ID'

  @emptyUserId
  Scenario: Intento de desbloqueo con id de usuario vacío
    Given path '/party-authentication//password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "" }
    When method POST
    Then status 404
    And match response == response404.error_404_not_found

  @invalidUserId
  Scenario: Intento de desbloqueo con id de usuario inválido
    Given path '/party-authentication/!@#$$%^&*()_+/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "!@#$$%^&*()_+" }
    When method POST
    Then status 400
    And match response.statusCode == '400'
    And match response.data.errorDetails.fields.exceptionType == 'BadRequest'

  @noAuth
  Scenario: Intento de desbloqueo sin autorización
    * def uuid = '95197ac4-8b08-4210-9b2c-d3da2d128a49'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "#(uuid)" }
    When method POST
    Then status 200
    And match response == response200.unlock_success_response

  @invalidToken
  Scenario: Intento de desbloqueo con token inválido
    * def uuid = '95197ac4-8b08-4210-9b2c-d3da2d128a49'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer ABC123XYZ'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "#(uuid)" }
    When method POST
    Then status 200
    And match response == response200.unlock_success_response

  @systemError @ignore #aplica para las de carga
  Scenario: Prueba de manejo de errores del sistema Entrust
    * def uuid = '95197ac4-8b08-4210-9b2c-d3da2d128a49'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "#(uuid)" }
    When method POST
    Then status 500
    And match response.statusCode == '500'
    And match response.message == 'Error en el desbloqueo del usuario. Consulte la documentación de manejo de errores.'

  @userNotFound
  Scenario: Intento de desbloqueo con usuario inexistente
    * def uuid = '11111111-1111-1111-1111-111111111111'
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request { "userId": "#(uuid)", "transactionId": "123456" }
    When method POST
    Then status 404
    And match response == response404.error_404_user_not_found
  @alreadyUnlocked
  @alreadyUnlocked
  Scenario: Intento de desbloqueo cuando el usuario ya está desbloqueado
    * def uuid = '95197ac4-8b08-4210-9b2c-d3da2d128a49'
    * def requestBody = { "userId": "#(uuid)", "transactionId": "123456", "data": {} }
    Given path '/party-authentication/', uuid, '/password/user-unlock/evaluate'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '123456'
    And header Content-Type = 'application/json'
    And request requestBody
    When method POST
    Then status 200
    And match response == response200.unlock_success_response