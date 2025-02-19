Feature: Actualización de contraseña en Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def requestBody = read('classpath:pa/com/bancomercantil/authentication/karate/managerPassword/jsonRequest/bodyRequestPassword.json')
    * def response200 = read('classpath:pa/com/bancomercantil/authentication/karate/managerPassword/jsonResponse/200.json')
    * def response400 = read('classpath:pa/com/bancomercantil/authentication/karate/managerPassword/jsonResponse/400.json')
    * def response404 = read('classpath:pa/com/bancomercantil/authentication/karate/managerPassword/jsonResponse/404.json')

  @updateSuccess
  Scenario: Actualización exitosa de la contraseña
    * def uuid = '740c9ec5-c78d-4ac5-b7c5-5719bcdcf292'
    Given path '/party-authentication/', uuid, '/password/update'
    And header transactionId = '123456789'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method PUT
    Then status 200
    And match response == response200.success_response

  @noTransactionId
  Scenario: Intento de actualización sin transactionId
    * def uuid = '740c9ec5-c78d-4ac5-b7c5-5719bcdcf292'
    Given path '/party-authentication/', uuid, '/password/update'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method PUT
    Then status 400
    And match response == response400.error_400_missing_transaction_id

  @invalidFormat
  Scenario: Intento de actualización con PasswordFormatType inválido
    * def uuid = '740c9ec5-c78d-4ac5-b7c5-5719bcdcf292'
    Given path '/party-authentication/', uuid, '/password/update'
    And header transactionId = '123456789'
    And header Content-Type = 'application/json'
    And request requestBody.invalid_format_request
    When method PUT
    Then status 400
    And match response == response400.error_400_invalid_format

  @userNotFound
  Scenario: Intento de actualización cuando el usuario no existe
    * def uuid = 'no-existe-12345'
    Given path '/party-authentication/', uuid, '/password/update'
    And header transactionId = '123456789'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method PUT
    Then status 404
    And match response == response404.error_404_user_not_found

  @invalidReference
  Scenario: Intento de actualización con ReturnPasswordReference en formato incorrecto
    * def uuid = '740c9ec5-c78d-4ac5-b7c5-5719bcdcf292'
    Given path '/party-authentication/', uuid, '/password/update'
    And header transactionId = '123456789'
    And header Content-Type = 'application/json'
    And request requestBody.invalid_reference_request
    When method PUT
    Then status 400
    And match response == response400.error_400_invalid_reference