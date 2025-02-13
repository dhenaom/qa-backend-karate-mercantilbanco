Feature: Guardado de registros en tabla de persistencia de datos Exitoso
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def date = new java.util.Date()
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    * formatter.setTimeZone(java.util.TimeZone.getTimeZone("UTC"))
    * def formattedDate = formatter.format(date)
    * def body = karate.read('classpath:pa/com/bancomercantil/account/karate/datapersistence/jsonrequest/create.json')


  @CreateSuccess
  Scenario: Solicitud Create exitosa
    * set body.entity.createdAt = formattedDate
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Registro Creado Exitosamente.'
    And match response.data == '#notnull'
    And match response.data.id == '#string'
    And match response.timestamp == '#notnull'
    And match response.transactionId == randomNumber

  @GetSuccess
  Scenario: Solicitud Get exitosa
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber+1
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = 'ENTITY_01'
    When method get
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Consulta Generada Exitosamente.'
    And match response.data == '#notnull'

  @UpdateSuccess
  Scenario: Solicitud Update exitosa
    * set body.entity.completedAt = formattedDate
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber+2
    And request body
    When method put
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Registro Actualizado Exitosamente.'
    And match response.data == '#notnull'
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber+1
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = 'ENTITY_01'
    When method get
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Consulta Generada Exitosamente.'
    And match response.data == '#notnull'
    And match response.data.completedAt == formattedDate
