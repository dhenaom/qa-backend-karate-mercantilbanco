@consultaVinculacionMONY
Feature: Consulta de vinculación de cuentas a MONY

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def monyResponses = read('classpath:pa/com/bancomercantil/account/karate/getaccountvinculatetoMONY/jsonResponse/link_mony_responses.json')

  @MONY001 @cuentaCorriente
  Scenario Outline: Consulta de vinculación de cuenta corriente a MONY
    Given path '/v1/current-account/1060/LinkMony/retrieve'
    And param accountNumber = '<account_number>'
    And header transactionId = '12345'
    When method GET
    Then status <status>
    And match response == monyResponses[<response_type>]

    Examples:
      | account_number | status | response_type           |
      | 420166082      | 200    | 'currentAccountLinked'  |
      #| 123456789      | 200    | 'currentAccountNotLinked'  |
      | 999999999      | 404    | 'accountNotFound'       |
      | abc123         | 404    | 'invalidAccountFormat'  |

  @MONY002 @cuentaAhorro
  Scenario Outline: Consulta de vinculación de cuenta de ahorros a MONY
    Given path '/v1/savings-account/1060/LinkMony/retrieve'
    And param accountNumber = '<account_number>'
    And header transactionId = '1234'
    When method GET
    Then status <status>
    And match response == monyResponses[<response_type>]

    Examples:
      | account_number | status | response_type          |
      | 420166082      | 200    | 'savingsAccountLinked' |
      #| 123456789      | 200    | 'savingsAccountNotLinked' |
      | 999999999      | 404    | 'accountNotFound'      |
      | abc123         | 404    | 'invalidAccountFormat' |

  @MONY003 @parametroFaltante
  Scenario Outline: Consulta sin proporcionar número de cuenta
    Given path '<path>'
    And header transactionId = '12345'
    When method GET
    Then status 400
    And match response == monyResponses['missingAccountNumber']

    Examples:
      | path                                         |
      | /v1/current-account/1060/LinkMony/retrieve   |
      | /v1/savings-account/1060/LinkMony/retrieve   |