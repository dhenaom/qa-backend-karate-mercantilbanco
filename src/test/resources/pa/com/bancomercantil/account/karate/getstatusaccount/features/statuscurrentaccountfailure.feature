Feature: Solicitud fallidas cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomString = randomUtils.generateRandomUtil(8,"s")


  @getCurrentAccountsSuccessNullTransactionId
  Scenario: Consulta fallida de cuentas corriente del cliente transactionId vacio
    Given url urlBase + '/v1/current-account/'+'118067' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = null
    And param status = 'ALL'
    When method get
    Then status 400

  @getCurrentAccountsSuccessWithOutHeaderTransactionId
  Scenario: Consulta fallida de cuentas corriente del cliente sin header de transactionId
    Given url urlBase + '/v1/current-account/'+'118067' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And param status = 'ALL'
    When method get
    Then status 400

  @getCurrentAccountsSuccessUnknowParamStatus
  Scenario: Consulta fallida de cuentas corriente del cliente con parametro status desconocido
    Given url urlBase + '/v1/current-account/'+'118067' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And param status = randomString
    When method get
    Then status 400

