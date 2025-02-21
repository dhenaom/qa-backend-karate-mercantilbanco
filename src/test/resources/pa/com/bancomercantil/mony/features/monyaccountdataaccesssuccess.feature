Feature: validar casos success servicios mony
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def pathget = '/v1/monyaccountdataaccess/data/retrieve'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
    * def readData = karate.read('classpath:pa/com/bancomercantil/mony/jsonResponse/data.json')

  @GetSuccessEmail&Account
    Scenario: Solicitud get query email y account
      Given url urlBase + pathget
      And header transactionId = randomNumber
      And header objectType = 'ENTITY_01'
      And header query = "email='yorbis07@gmail.com' and account = '420166082'"
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Consulta Generada Exitosamente.'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.data == readData.emailandaccount.data

  @GetSuccessAccount
    Scenario: solicitud get account
      Given url urlBase + pathget
      And header transactionId = randomNumber
      And header objectType = 'ENTITY_01'
      And header query = "account = '639893050'"
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Consulta Generada Exitosamente.'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.data == readData.emailandaccount.data

  @GetSuccessEmail
    Scenario: solicitud get email
      Given url urlBase + pathget
      And header transactionId = randomNumber
      And header objectType = 'ENTITY_01'
      And header query = "email = 'ccampos@mercantilbanco.com.pa'"
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Consulta Generada Exitosamente.'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.data == readData.email.data

  @GetSuccessCustomerType&Account
    Scenario: solicitud get costumer type y account
      Given url urlBase + pathget
      And header transactionId = randomNumber
      And header objectType = 'ENTITY_01'
      And header query = "customerType = 'Natural' and account = '639923170'"
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Consulta Generada Exitosamente.'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.data == readData.customertypeandaccount.data

  @GetSuccessCustomerType&Email
  Scenario: solicitud get costumer type y email
    Given url urlBase + pathget
    And header transactionId = randomNumber
    And header objectType = 'ENTITY_01'
    And header query = "customerType = 'Natural' and  email = 'contrato@home.com'"
    When method GET
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Consulta Generada Exitosamente.'
    And match response.timestamp == isoformat
    And match response.transactionId == randomNumber
    And match response.data == readData.customertypeandemail.data

  @GetSuccessCustomerType&Account&Email
  Scenario: solicitud get costumer type, account y email
    Given url urlBase + pathget
    And header transactionId = randomNumber
    And header objectType = 'ENTITY_01'
    And header query = "customerType = 'Natural' and account = '639764243' and  email = 'vuo@home.com'"
    When method GET
    Then status 200
    And match response.status == 'SUCCESS'
    And match response.message == 'Consulta Generada Exitosamente.'
    And match response.timestamp == isoformat
    And match response.transactionId == randomNumber
    And match response.data == readData.customertypeandaccountandemail.data