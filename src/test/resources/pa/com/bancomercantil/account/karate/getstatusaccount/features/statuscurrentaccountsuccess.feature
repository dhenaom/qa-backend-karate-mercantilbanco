Feature: Solicitud exitosa estado de cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getStatusACurrentAccount
  Scenario Outline: Solicitud exitosa de estado de cuenta corriente activa
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.currentAccount.AccountStatus.AccountStatus.StatusReason.Text == '<StatusReason>'
    And match response.data.currentAccount.AccountStatus.AccountStatusType == '<Status>'

    Examples:
        |   cif   |i|accountNumber| StatusReason    |Status|
        |  38258  |0| 5370000173  | Cuenta Activa   |  A   |
        |  38258  |1| 6201000874  | Cuenta Activa   |  A   |
        |  405041 |0| 639844185   | Cuenta Activa   |  A   |
        |  1574   |0| 1201001020  | Cuenta Activa   |  A   |
        |  1574   |0| 1201004604  | Cuenta Activa   |  A   |

  @getStatusICurrentAccount
  Scenario Outline: Solicitud exitosa de estado de cuenta corriente inactiva
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.currentAccount.AccountStatus.AccountStatus.StatusReason.Text == 'Cuenta Inactiva'
    And match response.data.currentAccount.AccountStatus.AccountStatus.StatusDateTime != null
    And match response.data.currentAccount.AccountStatus.AccountStatusType == 'I'

    Examples:
        |   cif   |i|accountNumber|
        |  118067  |0| 639067256  |
        |  1574    |0| 1201006649  |