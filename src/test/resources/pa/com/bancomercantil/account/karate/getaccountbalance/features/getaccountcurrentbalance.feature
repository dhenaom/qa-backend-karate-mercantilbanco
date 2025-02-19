@consultaSaldos
Feature: Consulta de saldos de cuentas bancarias

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def savingsResponses = read('classpath:pa/com/bancomercantil/account/karate/getaccountbalance/jsonResponse/savings_responses.json')
    * def currentResponses = read('classpath:pa/com/bancomercantil/account/karate/getaccountbalance/jsonResponse/current_responses.json')


  @SACC001 @consultaSaldoAhorro
  Scenario: PR-ConsultaBalanceCuentaAhorro-Exitosa
    Given path '/v1/savings-account/109663/balance/retrieve'
    And param accountNumber = '20026160'
    And header transactionId = '2323'
    When method GET
    Then status 200
    And match response == savingsResponses.success

  @SACC002 @consultaSaldoAhorroError
  Scenario: PR-ConsultaBalanceCuentaAhorro-CuentaInvalida
    Given path '/v1/savings-account/109663/balance/retrieve'
    And param accountNumber = '00000000'
    And header transactionId = '2323'
    When method GET
    Then status 404
    And match response == savingsResponses.invalidAccount

  @SACC003 @consultaSaldoAhorroError
  Scenario: PR-ConsultaBalanceCuentaAhorro-SinTransactionId
    Given path '/v1/savings-account/109663/balance/retrieve'
    And param accountNumber = '20026160'
    When method GET
    Then status 400
    And match response == savingsResponses.missingTransactionId

  @CACC001 @consultaSaldoCorriente
  Scenario: PR-ConsultaBalanceCuentaCorriente-Exitosa
    Given path '/v1/current-account/1060/balance/retrieve'
    And param accountNumber = '300000530'
    And header transactionId = '2323'
    When method GET
    Then status 200
    And match response == currentResponses.success
    And match response.timestamp == '#string'

  @CACC002 @consultaSaldoCorrienteError
  Scenario: PR-ConsultaBalanceCuentaCorriente-CuentaInvalida
    Given path '/v1/current-account/1060/balance/retrieve'
    And param accountNumber = '00000000'
    And header transactionId = '2323'
    When method GET
    Then status 404
    And match response == currentResponses.invalidAccount

  @CACC003 @consultaSaldoCorrienteError
  Scenario: PR-ConsultaBalanceCuentaCorriente-SinTransactionId
    Given path '/v1/current-account/1060/balance/retrieve'
    And param accountNumber = '300000530'
    When method GET
    Then status 400
    And match response == currentResponses.missingTransactionId