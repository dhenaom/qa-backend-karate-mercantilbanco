Feature: Solicitud exitosa cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getAllCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa de todas las cuentas corriente del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'ALL'
    When method get
    Then status 200
    And match response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value == '<accountNumber>'

    Examples:
        |   cif   |i|accountNumber|
        |  38258  |0| 5370000173  |
        |  38258  |1| 6201000874  |
        |  405041 |0| 639844185   |
        |  118067 |0| 639067256   |
        |   1574  |0| 1201001020  |
        |   1574  |1| 1201004604  |

  @getAcurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa de las cuentas corriente habilitadas del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'ENABLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
        |   cif   |i|accountNumber|  status  |
        |  38258  |0| 5370000173  |   200    |
        |  38258  |1| 5370000173  |   200    |
        |  405041 |0| 639844185   |   200    |
        |  118067 |0| 639067256   |   204    |
        |   1574  |0| 1201001020  |   200    |
        |   1574  |0| 1201004604  |   200    |

  @getCCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa de las cuentas corriente CANCELED del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'CANCELED'
    When method get
    Then status <status>

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  215687 |0|  30041357   |   204    |

  @getICurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas corriente inhabilitadas del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DISABLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
        |   cif   |i|accountNumber|  status  |
        |  38258  |0| 5370000173  |   204    |
        |  405041 |0| 639844185   |   204    |
        |  118067 |0| 639067256   |   200    |
        |   1574  |0| 1201006649  |   200    |

  @getDCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas corriente DELETED del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DELETED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  119017 |0| 639076861   |   200    |

  @getOCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas corriente CONTROLLED del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'CONTROLLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
        |   cif   |i|accountNumber|  status  |
        |  28720  |0| 5300000964  |   200    |


  @getOCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas corriente EMBARGOED del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'EMBARGOED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  215687 |0|  30055207   |   200    |

  @getTCurrentAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas corriente solo depositos del cliente
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DEPOSIT_ONLY'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.currentAccounts[<i>].CurrentAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  167333 |0|  30041357   |   200    |







