Feature: Solicitud exitosa cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getcurrentaccountssuccess
    Scenario: Consulta de cuentas corriente exitosa
        Given url urlBase + '/v1/current-account/'+'118067' + '/detail/retrieve'
        And header page = 1
        And header pageLimit = 10
        And header transactionId = randomNumber
        And param status = 'ALL'
        When method get
        Then status 200





