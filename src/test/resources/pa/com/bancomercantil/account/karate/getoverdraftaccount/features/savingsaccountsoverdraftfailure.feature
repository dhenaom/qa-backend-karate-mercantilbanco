Feature: Solicitud exitosa sobregiro cuenta ahorros
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros sin parametro numero de cuenta
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros con parametro numero de cuenta vacio
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros con numero de cuenta desconocido
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros con parametro numero de cuenta tipo string
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros sin header transactionId
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
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
  Scenario: Solicitud Fallida de sobregiro cuenta de Ahorros con header transactionId vacio
    Given url urlBase + '/v1/savings-account/'+''+randomNumber+'' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = ''
    And param accountNumber = randomNumber3
    When method get
    Then status 400
    And match response.message == "El transactionId no puede estar vacio."
    And match response.data.errorDetails.code == '400 BAD_REQUEST'
    And match response.data.errorDetails.fields.message == "El header transaction id no puede ir vacio"
