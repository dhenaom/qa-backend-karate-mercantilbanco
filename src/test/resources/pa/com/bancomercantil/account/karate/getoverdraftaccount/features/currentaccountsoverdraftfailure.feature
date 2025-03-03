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


  @withoutParamAccountNumber
  Scenario: Solicitud Fallida de sobregiro cuenta corriente sin parametro numero de cuenta
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    When method get
    Then status 400
    And match response.message == "Faltan headers o campos obligatorios"
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request parameter 'accountNumber' for method parameter type String is not present"
    And match response.data.errorDetails.fields.exceptionType == "MissingServletRequestParameterException"

  @emptyParamAccountNumber
  Scenario: Solicitud Fallida de sobregiro cuenta corriente con parametro numero de cuenta vacio
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = ''
    When method get
    Then status 400
    And match response.message == "Ocurrió un error en servicio externo"
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == '400 : \"{\"status_code\":\"400\",\"status\":\"BAD_REQUEST\",\"message\":\"For input string: \\\"\\\"\"}\"'
    And match response.data.errorDetails.fields.exceptionType == "BadRequest"

  @unknownAccountNumber
  Scenario: Solicitud Fallida de sobregiro cuenta corriente con numero de cuenta desconocido
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = randomNumber3
    When method get
    Then status 404
    And match response.message == "Ocurrió un error en servicio externo"
    And match response.data.errorDetails.code == '404'
    And match response.data.errorDetails.fields.exceptionMessage == '404 : \"{\"status_code\":\"404\",\"status\":\"NOT_FOUND\",\"message\":\"0009 : Numero de Referencia no Existe.\"}\"'
    And match response.data.errorDetails.fields.exceptionType == "NotFound"

  @stringOnParamAccountNumber
  Scenario: Solicitud Fallida de sobregiro cuenta corriente con parametro numero de cuenta tipo string
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = randomString
    When method get
    Then status 400
    And match response.message == "Ocurrió un error en servicio externo"
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == '400 : \"{\"status_code\":\"400\",\"status\":\"BAD_REQUEST\",\"message\":\"For input string: \\\"'+randomString+'\\\"\"}\"'
    And match response.data.errorDetails.fields.exceptionType == "BadRequest"

  @withoutHeaderTransactionId
  Scenario: Solicitud Fallida de sobregiro cuenta corriente sin header transactionId
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.message == "Faltan headers o campos obligatorios"
    And match response.data.errorDetails.code == '400'
    And match response.data.errorDetails.fields.exceptionMessage == "Required request header 'transactionId' for method parameter type String is not present"
    And match response.data.errorDetails.fields.exceptionType == "MissingRequestHeaderException"

  @emptyHeaderTransactionId
  Scenario: Solicitud Fallida de sobregiro cuenta corriente con header transactionId vacio
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = ''
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.message == "El transactionId no puede estar vacio."
    And match response.data.errorDetails.code == '400 BAD_REQUEST'
    And match response.data.errorDetails.fields.message == "El header transaction id no puede ir vacio"

  @savingAccountInCurrentAccount
  Scenario: Solicitud Fallida de sobregiro cuenta corriente con numero de cuenta de ahorros
    Given url urlBase + '/v1/current-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber2
    And param accountNumber = '20026160'
    When method get
    Then status 409
    And match response.message == "Ocurrió un error en servicio externo"
    And match response.data.errorDetails.code == '409'
    And match response.data.errorDetails.fields.exceptionMessage == '409 : \"{\"status_code\":\"409\",\"status\":\"CONFLICT\",\"message\":\"7193 : El Numero de cuenta No pertenece a este Modulo\"}\"'
    And match response.data.errorDetails.fields.exceptionType == "Conflict"