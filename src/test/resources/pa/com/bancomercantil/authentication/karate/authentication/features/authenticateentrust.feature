Feature: Autenticación con Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa/v1/entrust-authentication'
    * header Accept = 'application/json'
    * def requestBody = read('classpath:pa/com/bancomercantil/karate/authentication/jsonRequest/bodyRequestEntrust.json')

  @smoke
  Scenario: Autenticación exitosa
    Given path '/authenticate/provide'
    And header transactionId = '123456'
    And request requestBody
    When method POST
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.data.authToken == '#present'
    And match response.data.creationTime == '#present'
    And match response.data.expirationTime == '#present'
    * def authToken = response.data.authToken

  @logging
  Scenario: Registro de log por cada solicitud
    Given path '/authenticate/provide'
    And header transactionId = '123456'
    And request requestBody
    When method POST
    Then status 200
    * def logFile = karate.properties['user.dir'] + '/target/karate.log'
    And match response.data.authToken == '#present'

  @validation
  Scenario: Validación del formato del token generado
    Given path '/authenticate/provide'
    And header transactionId = '123456'
    And request requestBody
    When method POST
    Then status 200
    And match response.data.authToken == '#present'
    * def tokenLength = response.data.authToken.length()
    And assert tokenLength >= 50 && tokenLength <= 2000

  @expired
  Scenario: Solicitar un token expirado después del tiempo límite
    * def expiredToken = 'eyJhbGciOiJIUzI1...'
    Given path '/authenticate/provide'
    And header Authorization = 'Bearer ' + expiredToken
    And header transactionId = '123456'
    And request requestBody
    When method POST
    Then status 401
    And match response.message == '#present'

  @validation
  Scenario: Autenticación con atributos adicionales no permitidos
    Given path '/authenticate/provide'
    And header transactionId = '123456'
    * def invalidBody = requestBody
    * set invalidBody.extraParam = '123'
    And request invalidBody
    When method POST
    Then status 400
    And match response.message contains 'Atributos adicionales no permitidos'

  @concurrent
  Scenario: Generación concurrente del token para la misma cuenta
    * def concurrent =
  """
  function(i) {
    var RequestThread = Java.type('java.lang.Thread');
    RequestThread.sleep(100);
    return karate.call('classpath:pa/com/bancomercantil/karate/authentication/features/authenticateentrust.feature@smoke');
  }
  """
    * def result = karate.repeat(4, concurrent)
    * def firstToken = result[0].authToken
    * match each result contains { authToken: '#(firstToken)' }