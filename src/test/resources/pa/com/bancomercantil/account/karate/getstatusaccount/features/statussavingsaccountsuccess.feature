Feature: Solicitud exitosa estado de cuentas ahorros
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getStatusSavingsAccount
  Scenario Outline: Solicitud exitosa de estado de cuenta ahorros <StatusReason>
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/status/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.savingAccount.AccountStatus.AccountStatus.StatusReason.Text == '<StatusReason>'
    And match response.data.savingAccount.AccountStatus.AccountStatusType == '<Status>'
    And match response.data.savingAccount.AccountStatus.StatusInvolvedParty == '#notnull'
    And match response.data.savingAccount.AccountStatus.AccountStatus.StatusDateTime == <sdt>

    Examples:
      |   cif   |i|accountNumber| StatusReason         |Status|    sdt    |
      |  38258  |0| 20026160    | Cuenta Activa        |  A   |'#notnull'|
      |  340324 |0| 10116006289 | Cuenta Activa        |  A   |'#notnull'|
      |  414122 |0| 1420000973  | Cuenta Activa        |  A   |'#null'|
      |  12384  |0| 2200000295  | Cuenta Activa        |  A   |'#notnull'|
      |  3331   |0| 200001030   | Cuenta Activa        |  A   |'#null'|
      |  324418 |0| 10116005841 | Cuenta Activa        |  A   |'#notnull'|
      |  12384  |0| 2200000295  | Cuenta Activa        |  A   |'#notnull'|
      |  49999  |0| 4200051992  | Cuenta Cerrada       |  C   |'#notnull'|
      |  75083  |0| 200025463   | Cuenta Inactiva      |  I   |'#notnull'|
      |  351732 |0| 10246000091 | Cuenta Inactiva      |  I   |'#notnull'|
      |  3391   |0| 200001054   | Cuenta Inactiva 2    |  D   |'#notnull'|
      |  150284 |0| 20028603    | Cuenta Controlada    |  O   |'#null'|
      |  46888  |0| 4200040594  | Cuenta Embargada     |  E   |'#notnull'|
      |  1517   |0| 200000166   | Acepta Solo Creditos |  T   |'#notnull'|
