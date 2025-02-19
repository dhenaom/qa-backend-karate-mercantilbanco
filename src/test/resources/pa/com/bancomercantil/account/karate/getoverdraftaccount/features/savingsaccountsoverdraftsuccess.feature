Feature: Solicitud exitosa cuentas ahorro
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getAllSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa de todas las cuentas Ahorros del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'ALL'
    When method get
    Then status 200
    And match response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value == '<accountNumber>'

    Examples:
      |   cif     |i|accountNumber|
      |  340324   |0| 10116006289 |
      |  340324   |1| 3115019697  |
      |  414122   |0| 1420000973  |
      |  75083    |0| 200025463   |
      |  324418   |0| 10116005841 |

  @getASavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros habilitadas del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'ENABLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif     |i|accountNumber|  status  |
      |  340324   |0| 10116006289 |   200    |
      |  340324   |1| 3115019697  |   200    |
      |  414122   |0| 1420000973  |   200    |
      |  118067   |0| 639067256   |   204    |
      |   75083   |0| 200025463   |   204    |
      |   324418  |0| 1201004604  |   200    |

  @getCSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros CANCELED del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'CANCELED'
    When method get
    Then status <status>

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  215687 |0|  30041357   |   204    |

  @getISavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros inhabilitadas del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DISABLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  340324 |0| 5370000173  |   204    |
      |  414122 |0| 639844185   |   204    |
      |  75083  |0| 200025463   |   200    |
      |  324418 |0| 1201006649  |   204    |
      |  351732 |0| 10246000091  |   200    |
      |  351732 |0| 10246000091  |   200    |

  @getDSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros DELETED del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DELETED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  119017 |0| 639076861   |   204    |

  @getOSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros CONTROLLED del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'CONTROLLED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      | 150284  |0|  20028603   |   200    |


  @getOSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros EMBARGOED del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'EMBARGOED'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |  46888  |0| 4200040594  |   200    |

  @getTSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa las cuentas Ahorros solo depositos del cliente
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/detail/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param status = 'DEPOSIT_ONLY'
    When method get
    Then status <status>
    And def account = (response.status == 200? response.data.savingsAccounts[<i>].SavingsAccountNumber.AccountIdentification.IdentifierValue.Value:'<accountNumber>')
    And match account == '<accountNumber>'

    Examples:
      |   cif   |i|accountNumber|  status  |
      |   1517  |0|  200000166  |   200    |
    