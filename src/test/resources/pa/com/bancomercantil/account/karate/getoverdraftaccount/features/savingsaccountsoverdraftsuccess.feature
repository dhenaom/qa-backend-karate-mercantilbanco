Feature: Solicitud exitosa sobregiro cuenta ahorros
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getAllSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa de sobregiro cuenta de Ahorros
    Given url urlBase + '/v1/savings-account/'+'<cif>' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.savingsAccount.SavingsAccountNumber.AccountIdentification.IdentifierValue.Value == '<accountNumber>'
    And match response.data.savingsAccount.AccountBalance[0].BalanceAmount == '#notnull'
    And match response.data.savingsAccount.AccountBalance[0].BalanceType == 'overdraftAvailableBalance'
    And match response.data.savingsAccount.AccountBalance[1].BalanceAmount == '#notnull'
    And match response.data.savingsAccount.AccountBalance[1].BalanceType == 'overdraftUsedBalance'

    Examples:
      |   cif     |i|accountNumber|
      |  340324   |0| 10116006289 |
      |  340324   |1| 3115019697  |
      |  414122   |0| 1420000973  |
      |  75083    |0| 200025463   |
      |  324418   |0| 10116005841 |
