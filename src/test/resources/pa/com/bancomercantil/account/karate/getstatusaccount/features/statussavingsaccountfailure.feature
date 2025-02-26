Feature: Solicitud exitosa estado de cuentas ahorros
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber2 = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber3 = randomUtils.generateRandomUtil(8,"number")
    * def randomString = randomUtils.generateRandomUtil(8,"s")


  @withOutAccountNumber
  Scenario: Solicitud fallida de estado de cuenta ahorros sin numero de cuenta
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request parameter 'accountNumber' for method parameter type String is not present"
    And match response.data..errorDetails.fields.exceptionType contains "MissingServletRequestParameterException"

  @unknownAccountNumber
  Scenario: Solicitud fallida de estado de cuenta ahorros con numero de cuenta desconocido
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
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
  Scenario: Solicitud fallida de estado de cuenta ahorros con numero de cuenta de tipo string
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
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
  Scenario: Solicitud fallida de estado de cuenta ahorros sin header transactionId
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request header 'transactionId' for method parameter type String is not present"
    And match response.data.errorDetails.fields.exceptionType contains "MissingRequestHeaderException"

  @emptyTransactionIdHeader
  Scenario: Solicitud fallida de estado de cuenta ahorros con header transactionId vacio
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = ''
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.data.errorDetails.code == '400 BAD_REQUEST'
    And match response.data.errorDetails.fields.message == "El header transaction id no puede ir vacio"

  @currentAccountInSavingsAccount
  Scenario: Solicitud fallida de estado de cuenta ahorros con numero de cuenta de corriente
    Given url urlBase + '/v1/savings-account/'+randomNumber + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = '300000530'
    When method get
    Then status 409
    And match response.data.errorDetails.code == '409'
    And match response.data.errorDetails.fields.exceptionMessage contains "El Numero de cuenta No pertenece a este Modulo"
    And match response.data.errorDetails.fields.exceptionType contains "Conflict"
