Feature: validar casos failure servicios cache
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def readBody = karate.read('classpath:pa/com/bancomercantil/account/karate/transversalfunctioncache/jsonRequest/bodyRequestCreateCache.json')
    * def pathcreate = '/api/v1/fn/cache-management/create'
    * def pathget = '/api/v1/fn/cache-management/retrieve/'
    * def formatresponse404 = karate.read('classpath:pa/com/bancomercantil/account/karate/transversalfunctioncache/jsonResponse/404.json')
    * def messageerror = 'Datos de entrada inválidos.'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'

    @CreateFailureTransactionIdNull
    Scenario: Solicitud de creacion fallida transactionId nulo
      * def baseBody = readBody.bodyOk
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = ''
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == "N/A"
      And match response.timestamp == isoformat


    @CreateFailureWithOutTransactionIdHeader
    Scenario: Solicitud de creacion fallida sin transactionId en header
      * def baseBody = readBody.bodyOk
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == "N/A"
      And match response.timestamp == isoformat

    @CreateFailureWithOutCacheKey
    Scenario: Solicitud de creacion fallida sin campo cacheKey
      * def baseBody = readBody.withOutCacheKey
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat

    @CreateFailureCacheKey
    Scenario: Solicitud de creacion fallida error campo cacheKey
      * def baseBody = readBody.withOutCacheKey
      * set baseBody.cacheKey = 12345
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat

    @CreateWithOutValue
    Scenario: Solicitud de creacion fallida sin value
      * def baseBody = readBody.withOutValue
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat

    @CreateFailureValue
    Scenario: Solicitud de creacion error value
      * def baseBody = readBody.withOutValue
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.value = 'Hola Mundo'
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 400
      And match response.message == messageerror
      And match response.status == 'ERROR'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat

    @GetFailureTransactionIdNull
    Scenario: Solicitud de obtener transactionId nulo
      * def cacheKey = 'testCache'
      Given url urlBase + pathget + cacheKey
      And header transactionId = ''
      When method GET
      Then status 400
      And match response.message == messageerror
      And match response.transactionId == "N/A"
      And match response.timestamp == isoformat

    @GetFailureTransactionId
    Scenario: Solicitud de obtener error transactionId
      * def cacheKey = 'testCache'
      Given url urlBase + pathget + cacheKey
      And header transaction-Id = '3b1a0f90-79af-4d2f-97bd-2e5b573e43f8'
      When method GET
      Then status 400
      And match response.message == messageerror
      And match response.transactionId == "N/A"
      And match response.timestamp == isoformat

    @GetFailureWithOutTransactionId
    Scenario: Solicitud de obtener sin transactionId en header
      * def cacheKey = 'testCache'
      Given url urlBase + pathget + cacheKey
      When method GET
      Then status 400
      And match response.message == messageerror
      And match response.transactionId == "N/A"
      And match response.timestamp == isoformat

    @GetFailureCacheKeyNull
      Scenario: Solicitud de obtener cacheKey nulo
        Given url urlBase + pathget + ''
        And header transactionId = randomNumber
        When method GET
        Then status 404
        And match response.message == 'Resource not found'

    @GetFailureCacheKey
    Scenario: Solicitud de obtener error cacheKey
      * def cacheKey = 12345
      Given url urlBase + pathget + cacheKey
      And header transactionId = randomNumber
      When method GET
      Then status 404
      And match response.message == 'Dato no encontrado.'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat

    @GetFailureWithOutCacheKey
    Scenario: Solicitud de obtener sin cacheKey
      Given url urlBase + pathget
      And header transactionId = randomNumber
      When method GET
      Then status 404
      And match response.message == 'Resource not found'

    @GetTtlExpired
    Scenario: Solicitud get ttl vencido
      * def baseBody = readBody.bodyOk
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '1'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 201
      * eval java.lang.Thread.sleep(1000)
      Given url urlBase + pathget + baseBody.cacheKey
      And header transactionId = randomNumber
      When method GET
      Then status 404
      And match response.message == 'Dato no encontrado.'
      And match response.transactionId == randomNumber
      And match response.timestamp == isoformat