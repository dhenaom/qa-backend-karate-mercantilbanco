Feature: Consulta fallida de firmantes de una cuenta
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber2 = randomUtils.generateRandomUtil(8,"number")
    * def randomNumber3 = randomUtils.generateRandomUtil(8,"number")
    * def date = new java.util.Date()
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    * formatter.setTimeZone(java.util.TimeZone.getTimeZone("UTC"))
    * def formattedDate = formatter.format(date)
    * def body = karate.read('classpath:pa/com/bancomercantil/account/karate/datapersistence/jsonrequest/create.json')



  @UnknowAccount
  Scenario: Solicitud fallida de firmantes de una cuenta con cuenta invalida
    Given url urlBase + '/v1/party-reference-data-directory/reference/'+ randomNumber +'/signatory/retrieve'
    And header transactionId = randomNumber2
    And request body
    When method get
    Then status 404
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data.errorDetails.code == '404'
    And match response.data.errorDetails.fields.exceptionType == 'NotFound'
    And match response.data.errorDetails.fields.exceptionMessage == '404 : \"{\"status_code\":\"404\",\"status\":\"NOT_FOUND\",\"message\":\"0009 : Numero de Referencia no Existe.\"}\"'


  @WithoutAccount
  Scenario: Solicitud fallida de firmantes de una cuenta sin numero de cuenta
    Given url urlBase + '/v1/party-reference-data-directory/reference/'+ '' +'/signatory/retrieve'
    And header transactionId = randomNumber
    And request body
    When method get
    Then status 400
    And match response.message == "Falta el parámetro requerido 'documenttype' en la solicitud."
    And match response.data.errorDetails.code == 'ERROR-400'
    And match response.data.errorDetails.fields.exceptionType == 'MissingServletRequestParameterException'
    And match response.data.errorDetails.fields.exceptionMessage == "Falta el parámetro requerido 'documenttype' en la solicitud."

  @withoutHeaderTransactionId
  Scenario: Solicitud fallida de firmantes de una cuenta sin header transactionId
    Given url urlBase + '/v1/party-reference-data-directory/reference/'+ '300000354' +'/signatory/retrieve'
    And request body
    When method get
    Then status 400
    And match response.message == "Falta el encabezado requerido 'transactionId' en la solicitud."
    And match response.data.errorDetails.code == 'ERROR-400'
    And match response.data.errorDetails.fields.exceptionType == 'MissingRequestHeaderException'
    And match response.data.errorDetails.fields.exceptionMessage == "Falta el encabezado requerido 'transactionId' en la solicitud."

  @EmptyTransactionId
  Scenario: Solicitud fallida de firmantes de una cuenta con transactionId vacio
    Given url urlBase + '/v1/party-reference-data-directory/reference/'+ '300000354' +'/signatory/retrieve'
    And header transactionId = ''
    And request body
    When method get
    Then status 400
    And match response.message == "exception.request.transactionId"
    And match response.data.errorDetails.code == '400 BAD_REQUEST'
    And match response.data.errorDetails.fields.message == 'El header transaction id no puede ir vacio'