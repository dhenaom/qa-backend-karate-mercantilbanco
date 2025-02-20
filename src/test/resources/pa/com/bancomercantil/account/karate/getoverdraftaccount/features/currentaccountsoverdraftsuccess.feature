Feature: Solicitud exitosa sobregiro cuenta corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")


  @getAllSavingAccountsSuccess
  Scenario Outline: Solicitud exitosa de sobregiro cuenta de Ahorros
    Given url urlBase + '/v1/current-account/'+'<cif>' + '/overdraft/retrieve'
    And header page = 1
    And header pageLimit = 10
    And header transactionId = randomNumber
    And param accountNumber = '<accountNumber>'
    When method get
    Then status 200
    And match response.data.currentAccount.CurrentAccountNumber.AccountIdentification.IdentifierValue.Value == '<accountNumber>'
    And match response.data.currentAccount.AccountBalance[0].BalanceAmount == '#notnull'
    And match response.data.currentAccount.AccountBalance[0].BalanceType == 'overdraftAvailableBalance'
    And match response.data.currentAccount.AccountBalance[1].BalanceAmount == '#notnull'
    And match response.data.currentAccount.AccountBalance[1].BalanceType == 'overdraftUsedBalance'

    Examples:
      |   cif     |i|accountNumber|
      |  329316   |0| 6201000680 |
      |  340324   |1| 1201006649  |
      |  405041   |0| 639844185  |
      |  167333   |0| 30041357  |
      |  28720   |0| 5300000964  |
