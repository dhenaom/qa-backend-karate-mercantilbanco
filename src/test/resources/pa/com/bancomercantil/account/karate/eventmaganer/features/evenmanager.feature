Feature: Publicación de eventos en el sistema

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def requestBody = read('classpath:pa/com/bancomercantil/account/karate/eventmaganer/jsonRequest/bodyRequestEventManager.json')
    * def response200 = read('classpath:pa/com/bancomercantil/account/karate/eventmaganer/jsonResponse/200.json')
    * def response400 = read('classpath:pa/com/bancomercantil/account/karate/eventmaganer/jsonResponse/400.json')

  @publishSuccess
  Scenario: Publicación exitosa de un evento en el sistema
    Given path '/v1/events/publish'
    And header transactionId = 'f7c2b2cb-7936-4e20-b8db-f01dd5f0fa76'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method POST
    Then status 200
    And match response == response200.success_response
    And match response.transactionId == 'f7c2b2cb-7936-4e20-b8db-f01dd5f0fa76'

  @noTransactionId
  Scenario: Intento de publicación sin transactionId
    Given path '/v1/events/publish'
    And header Content-Type = 'application/json'
    And request requestBody.valid_request
    When method POST
    Then status 400
    And match response == response400.error_400_missing_transaction_id

  @noEventName
  Scenario: Intento de publicación con eventName nulo o vacío
    Given path '/v1/events/publish'
    And header transactionId = 'f7c2b2cb-7936-4e20-b8db-f01dd5f0fa76'
    And header Content-Type = 'application/json'
    And request requestBody.empty_event_name_request
    When method POST
    Then status 200
    And match response == response200.success_response

  @invalidPayload
  Scenario: Intento de publicación con eventPayload mal estructurado
    Given path '/v1/events/publish'
    And header transactionId = 'f7c2b2cb-7936-4e20-b8db-f01dd5f0fa76'
    And header Content-Type = 'application/json'
    And request requestBody.invalid_payload_request
    When method POST
    Then status 200
    And match response == response200.success_response

  @invalidValues
  Scenario: Intento de publicación con valores inválidos en eventPayload
    Given path '/v1/events/publish'
    And header transactionId = 'f7c2b2cb-7936-4e20-b8db-f01dd5f0fa76'
    And header Content-Type = 'application/json'
    And request requestBody.invalid_values_request
    When method POST
    Then status 200
    And match response == response200.success_response