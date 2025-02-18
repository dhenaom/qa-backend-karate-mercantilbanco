Feature: validar casos success servicios cache
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def readBody = karate.read('classpath:pa/com/bancomercantil/cache/jsonRequest/bodyRequestCreateCache.json')
    * def baseBody = readBody.bodyOk
    * def pathcreate = '/api/v1/fn/cache-management/create'
    * def pathget = '/api/v1/fn/cache-management/retrieve/'



  @CreateSuccess
    Scenario: Solicitud create exitosa
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '5'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 201
      And match response.status == 'SUCCESS'
      And match response.message == 'Registro Almacenado Exitosamente.'
      And match response.timestamp == '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
      And match response.transactionId == randomNumber
      And match response.data.cacheKey == baseBody.cacheKey
      And match response.data.ttl == baseBody.ttl

  @GetSuccess
    Scenario: Solicitud get exitosa
      * set baseBody.cacheKey = 'testCache'
      * eval java.lang.Thread.sleep(3000)
      Given url urlBase + pathget + baseBody.cacheKey
      And header transactionId = randomNumber
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Obtenido con éxito.'
      And match response.timestamp == '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
      And match response.transactionId == randomNumber
      And match response.data.cacheKey == baseBody.cacheKey
      And match response.data.value == baseBody.value
      * eval if (response.data.ttl >= baseBody.ttl) karate.fail('TTL es mayor o igual')

  @getTtlExpired
    Scenario: Solicitud get fallida por tiempo
      * set baseBody.cacheKey = 'testCache'
      * eval java.lang.Thread.sleep(3000)
      Given url urlBase + pathget + baseBody.cacheKey
      And header transactionId = randomNumber
      When method GET
      Then status 404

  @CreateSuccessTtl
    Scenario: Solicitud create exitosa ttl grande
      * set baseBody.cacheKey = 'testCache'
      * set baseBody.ttl = '3600'
      Given url urlBase + pathcreate
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 201
      And match response.status == 'SUCCESS'
      And match response.message == 'Registro Almacenado Exitosamente.'
      And match response.timestamp == '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
      And match response.transactionId == randomNumber
      And match response.data.cacheKey == baseBody.cacheKey
      And match response.data.ttl == baseBody.ttl