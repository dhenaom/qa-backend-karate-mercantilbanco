Feature: Actualización del estado del usuario en Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def requestBody = read('classpath:pa/com/bancomercantil.authentication/karate/userstatus/jsonRequest/bodyRequestStatus.json')
    * def response200 = read('classpath:pa/com/bancomercantil.authentication/karate/userstatus/jsonResponse/200.json')
    * def response400 = read('classpath:pa/com/bancomercantil.authentication/karate/userstatus/jsonResponse/400.json')
    * def response401 = read('classpath:pa/com/bancomercantil.authentication/karate/userstatus/jsonResponse/401.json')
    * def response503 = read('classpath:pa/com/bancomercantil.authentication/karate/userstatus/jsonResponse/503.json')
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  @updateSuccess
  Scenario: Actualización exitosa del estado del usuario en Entrust
    * def uuid = 'e2beb200-11ad-47aa-8b5a-5fbbc750f8e0'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 200
    And match response == response200.success_response
    And match response.message == "Recurso Actualizado Exitosamente"

  @systemError
  Scenario: Prueba de manejo de errores cuando el usuario no existe
    * def uuid = '987e6543-e21b-45c6-a789-123456789abc'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 404
    And match response.statusCode == '404'
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data.errorDetails.fields.exceptionMessage contains 'User not found with ID'

  @invalidStatus
  Scenario: Prueba de longitud máxima del campo estado
    * def uuid = '987e6543-e21b-45c6-a789-123456789abc'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.invalid_status_request
    When method PUT
    Then status 400
    And match response == response400.error_400_invalid_status
    And match response.data.errorDetails.fields.PartyReferenceStatus == "El valor ingreso es invalido, este solo puede ser ACTIVE o INACTIVE"


  @invalidUUIDLength
  Scenario: Prueba de longitud máxima del campo usuario
    * def uuid = '987e6543-e21b-45c6-a789-123456789abc123456'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 404
    And match response.statusCode == '404'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data.errorDetails.fields.exceptionMessage contains 'User not found with ID'

  @emptyStatus
  Scenario: Intento de actualización con estado vacío
    * def uuid = '987e6543-e21b-45c6-a789-123456789abc'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.empty_status_request
    When method PUT
    Then status 400
    And match response == response400.error_400_empty_status
    And match response.data.errorDetails.fields.PartyReferenceStatus == "El campo no puede ser nulo ni estar vacio"

  @nullStatus
  Scenario: Intento de actualización con estado nulo
    * def uuid = '987e6543-e21b-45c6-a789-123456789abc'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.null_status_request
    When method PUT
    Then status 400
    And match response == response400.error_400_null_status
    And match response.data.errorDetails.fields.PartyReferenceStatus == "El campo no puede ser nulo ni estar vacio"

  @emptyUser
  Scenario: Intento de actualización con usuario vacío
    * def uuid = ''
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 404
    And match response == { statusCode: 404, message: "Resource not found" }

  @existingStatus
  Scenario: Intento de actualización con usuario que ya posee el estado
    Given path '/party-authentication/e2beb200-11ad-47aa-8b5a-5fbbc750f8e0/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 200
    And match response == response200.already_has_status_response

  @invalidUUID
  Scenario: Intento de actualización con usuario inválido (caracteres especiales)
    Given path '/party-authentication/!@#$$%^&*()_+/user-status/update'
    And header Authorization = 'Bearer valid-token'
    And request requestBody.valid_request
    When method PUT
    Then status 404
    And match response.statusCode == '404'
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data.errorDetails.fields.exceptionMessage contains 'User not found with ID'

  @invalidToken
  Scenario: Intento de actualización con token inválido
    * def uuid = 'e2beb200-11ad-47aa-8b5a-5fbbc750f8e0'
    Given path '/party-authentication/', uuid, '/user-status/update'
    And header Authorization = 'Bearer INVALID_TOKEN.123.xyz'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method PUT
    Then status 200