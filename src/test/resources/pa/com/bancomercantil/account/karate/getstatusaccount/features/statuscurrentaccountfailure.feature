@current-account
Feature: Solicitud fallidas cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber2 = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber3 = randomUtils.generateRandomUtil(8,"number")
    * def randomString = randomUtils.generateRandomUtil(8,"s")


  @withOutAccountNumber
  Scenario: Solicitud fallida de estado de cuenta corriente sin numero de cuenta
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request parameter 'accountNumber' for method parameter type String is not present"
    And match response.data..errorDetails.fields.exceptionType contains "MissingServletRequestParameterException"

  @unknownAccountNumber
  Scenario: Solicitud fallida de estado de cuenta corriente con numero de cuenta desconocido
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = randomNumber3
    When method get
    Then status 404
    And match response.data.errorDetails.code == '404'
    And match response.data.errorDetails.fields.exceptionMessage contains "Numero de Referencia no Existe"
    And match response.data.errorDetails.fields.exceptionType contains "NotFound"

  @stringAccountNumber
  Scenario: Solicitud fallida de estado de cuenta corriente con numero de cuenta de tipo string
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = randomString
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == '400 : \"{\"status_code\":\"400\",\"status\":\"BAD_REQUEST\",\"message\":\"For input string: \\\"'+randomString+'\\\"\"}\"'
    And match response.data.errorDetails.fields.exceptionType contains "BadRequest"

  @withOutTransactionIdHeader
  Scenario: Solicitud fallida de estado de cuenta corriente sin header transactionId
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request header 'transactionId' for method parameter type String is not present"
    And match response.data.errorDetails.fields.exceptionType contains "MissingRequestHeaderException"

  @emptyTransactionIdHeader
  Scenario: Solicitud fallida de estado de cuenta corriente con header transactionId vacio
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = ''
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400 BAD_REQUEST'
    And match response.data.errorDetails.fields.message == "El header transaction id no puede ir vacio"

  @savingsAccountInCurrentAccount
  Scenario: Solicitud fallida de estado de cuenta corriente con numero de cuenta de ahorros
    Given url urlBase + '/v1/current-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = randomNumber3
    When method get
    Then status 404
    And match response.data.errorDetails.code == '404'
    And match response.data.errorDetails.fields.exceptionMessage contains "Numero de Referencia no Existe"
    And match response.data.errorDetails.fields.exceptionType contains "NotFound"
