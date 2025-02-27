Feature: Creación de usuario con credenciales iniciales en Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def requestBody = read('classpath:pa/com/bancomercantil/authentication/karate/createuser/jsonRequest/bodyRequestCreateUser.json')
    * def response201 = read('classpath:pa/com/bancomercantil/authentication/karate/createuser/jsonResponse/201.json')
    * def response400 = read('classpath:pa/com/bancomercantil/authentication/karate/createuser/jsonResponse/400.json')
    * def response409 = read('classpath:pa/com/bancomercantil/authentication/karate/createuser/jsonResponse/409.json')
    * header Content-Type = 'application/json'

  @createSuccess @smoke @regression
  Scenario: Creación exitosa de usuario en Entrust
    * def randomNum = Math.floor(Math.random() * 10000)
    * def email = 'testcorreo' + randomNum + '@example.com'
    * def userId = '98765' + randomNum
    * set requestBody.CustomerReference.PartyReference.CustomerEmail = email
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.UserIdentifier = userId
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.ExternalCustomerId = userId
    * set requestBody.CustomerReference.PartyReference.PartyName.UserPrincipalName = email
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 201
    And match response == response201.created_response
    And match response.data.CustomerReference.PartyReference.CustomerEmail == email


  @invalidMobile
  Scenario: Intento de creación con CustomerMobileNumber inválido
    * def invalidMobile = 'abcd1234'
    * set requestBody.CustomerReference.PartyReference.CustomerMobileNumber = invalidMobile
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 400
    And match response == response400.error_400_invalid_mobile

  @userExists
  Scenario: Intento de creación con usuario ya existente
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 409
    And match response == response409.error_409_user_exists

  @noTransactionId @ignore
  Scenario: Intento de creación sin transactionId
    * remove requestBody.$.transactionId
    * def randomNum = Math.floor(Math.random() * 10000)
    * def email = 'testcorreo' + randomNum + '@example.com'
    * def userId = '98765' + randomNum
    * set requestBody.CustomerReference.PartyReference.CustomerEmail = email
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.UserIdentifier = userId
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.ExternalCustomerId = userId
    * set requestBody.CustomerReference.PartyReference.PartyName.UserPrincipalName = email
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 400
    And match response == response400.error_400_missing_transaction_id

  @invalidState
  Scenario: Intento de creación con UserAuthenticationState inválido
    * def randomNum = Math.floor(Math.random() * 10000)
    * def email = 'testcorreo' + randomNum + '@example.com'
    * def userId = '98765' + randomNum
    * set requestBody.CustomerReference.PartyReference.CustomerEmail = email
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.UserIdentifier = userId
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.ExternalCustomerId = userId
    * set requestBody.CustomerAuthenticationAssessmentUser.UserAuthenticationState = 'DISABLED'
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 400
    And match response == response400.error_400_invalid_state

  @invalidEmail
  Scenario: Intento de creación con CustomerEmail inválido
    * def randomNum = Math.floor(Math.random() * 10000)
    * def userId = '98765' + randomNum
    * set requestBody.CustomerReference.PartyReference.CustomerEmail = 'invalid@@email.com'
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.UserIdentifier = userId
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.ExternalCustomerId = userId
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 400
    And match response == response400.error_400_invalid_email

  @invalidLanguage
  Scenario: Intento de creación con Language no soportado
    * def randomNum = Math.floor(Math.random() * 10000)
    * def email = 'testcorreo' + randomNum + '@example.com'
    * def userId = '98765' + randomNum
    * set requestBody.CustomerReference.PartyReference.CustomerEmail = email
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.UserIdentifier = userId
    * set requestBody.CustomerReference.PartyReference.PartyIdentification.PartyIdentification.ExternalCustomerId = userId
    * set requestBody.CustomerAccessAgreement.LocaleConfiguration.Language = 'deaaaaa'
    Given path '/customer-access-entitlement/user/create'
    And request requestBody
    When method POST
    Then status 400
    And match response == response400.error_400_invalid_language
