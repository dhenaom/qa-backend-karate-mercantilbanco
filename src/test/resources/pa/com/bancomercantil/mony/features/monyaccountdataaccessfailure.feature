Feature: validar casos failure servicios mony
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def pathget = '/v1/monyaccountdataaccess/data/retrieve'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
    * def readData = karate.read('classpath:pa/com/bancomercantil/mony/jsonResponse/data.json')
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
    * def messageerror = 'Ocurrió un error inesperado.'

  @GetFailureTransactionIdNull
  Scenario: Solicitud de consulta fallida con header transactionId nulo
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header transactionId = ''
    And header query = "email='yorbis07@gmail.com' and account = '420166082'"
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == "generated-fallback-transactionId"
    And match response.timestamp == isoformat

  @GetFailureWithOutTransactionIdHeader
  Scenario: Solicitud de consulta fallida sin header transactionId
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header query = "email='yorbis07@gmail.com' and account = '420166082'"
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == "generated-fallback-transactionId"
    And match response.timestamp == isoformat

  @GetFailureObjectTypeNull
  Scenario: Solicitud de consulta fallida con header object type nulo
    Given url urlBase + pathget
    And header objectType = ''
    And header transactionId = randomNumber
    And header query = "email='yorbis07@gmail.com' and account = '420166082'"
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @GetFailureWithOutObjectType
  Scenario: Solicitud de consulta fallida sin header objet type
    Given url urlBase + pathget
    And header transactionId = randomNumber
    And header query = "email='yorbis07@gmail.com' and account = '420166082'"
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @GetFailureQueryNull
  Scenario: Solicitud de consulta fallida header query nulo
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header transactionId = randomNumber
    And header query = ""
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @GetFailureWithOutQuery
  Scenario: Solicitud de consulta fallida sin header query
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header transactionId = randomNumber
    When method GET
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @GetFailureQuery
  Scenario: Solicitud de consulta fallida con error header query
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header transactionId = randomNumber
    And header query = "correo='yorbis07@gmail.com'"
    When method GET
    Then status 500
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @GetFailureQueryNotfoud
  Scenario: Solicitud de consulta sin datos error header query
    Given url urlBase + pathget
    And header objectType = 'ENTITY_01'
    And header transactionId = randomNumber
    And header query = "email='testpragma@pragma.com'"
    When method GET
    Then status 404
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat