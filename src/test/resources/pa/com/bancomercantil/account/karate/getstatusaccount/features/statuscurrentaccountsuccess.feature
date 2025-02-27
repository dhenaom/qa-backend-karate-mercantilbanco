@current-account
Feature: Solicitud exitosa estado de cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getStatusACurrentAccount
  Scenario Outline: Solicitud exitosa de estado de cuenta corriente <StatusReason>
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.currentAccount.AccountStatus.AccountStatus.StatusReason.Text == '<StatusReason>'
    And match response.data.currentAccount.AccountStatus.AccountStatusType == '<Status>'
    And match response.data.currentAccount.AccountStatus.StatusInvolvedParty == '#notnull'
    And match response.data.currentAccount.AccountStatus.AccountStatus.StatusDateTime == <sdt>

    Examples:
      |   cif   |i|accountNumber| StatusReason         |Status|    sdt    |
      |  38258  |0| 5370000173  | Cuenta Activa        |  A   |'#notpresent'|
      |  38258  |0| 6201000874  | Cuenta Activa        |  A   |'#notnull'|
      |  405041 |0| 639844185   | Cuenta Activa        |  A   |'#notpresent'|
      |  1574   |0| 1201001020  | Cuenta Activa        |  A   |'#notnull'|
      |  1574   |0| 1201004604  | Cuenta Activa        |  A   |'#notnull'|
      |  329316 |0| 6201000680  | Cuenta Activa        |  A   |'#notnull'|
      |  409599 |0| 639872402   | Cuenta Cerrada       |  C   |'#notnull'|
      |  118067 |0| 639067256   | Cuenta Inactiva      |  I   |'#notnull'|
      |  1574   |0| 1201006649  | Cuenta Inactiva      |  I   |'#notnull'|
      |  119017 |0| 639076861   | Cuenta Inactiva 2    |  D   |'#notnull'|
      |  28720  |0| 5300000964  | Cuenta Controlada    |  O   |'#notnull'|
      |  215687 |0| 30055207    | Cuenta Embargada     |  E   |'#notnull'|
      |  167333 |0| 30041357    | Acepta Solo Creditos |  T   |'#notnull'|