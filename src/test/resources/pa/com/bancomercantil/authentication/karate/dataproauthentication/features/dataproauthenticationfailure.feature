Feature: Autenticación de la API de DataPro fallida

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomAPIKey = randomUtils.generateRandomUtil(48,"password")

#  @API-KeyInvalid
#  Scenario: Autenticación fallida de la API de DataPro con API-Key inválido
#    Given url urlBase + '/datapro-authentication/authenticate/retrieve'
#    And header x-api-key = randomAPIKey
#    And header transactionId = randomNumber
#    When method get
#    Then status 401
#
#  @API-KeyNull
#  Scenario: Autenticación fallida de la API de DataPro con API-Key nulo
#    Given url urlBase + '/datapro-authentication/authenticate/retrieve'
#    And header x-api-key = null
#    And header transactionId = randomNumber
#    When method get
#    Then status 400
#
#  @WithOutAPI-KeyHeader
#  Scenario: Autenticación fallida de la API de DataPro sin header de API-Key
#    Given url urlBase + '/datapro-authentication/authenticate/retrieve'
#    And header transactionId = randomNumber
#    When method get
#    Then status 400

  @TransactionIdNull
  Scenario: Autenticación fallida de la API de DataPro con TransactionId nulo
    Given url urlBase + '/v1/datapro-authentication/authenticate/retrieve'
    And header transactionId = null
    When method get
    Then status 400

  @WithOutTransactionIdHeader
  Scenario: Autenticación fallida de la API de DataPro sin header de TransactionId
    Given url urlBase + '/v1/datapro-authentication/authenticate/retrieve'
    And header transactionId = null
    When method get
    Then status 400


