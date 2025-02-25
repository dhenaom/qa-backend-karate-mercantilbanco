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
    * def dataJson = karate.read('classpath:pa/com/bancomercantil/account/karate/monyaccountdataaccess/jsonResponse/data.json')

  @GetSuccessEmail&Account
    Scenario: Solicitud get a mony account access con query email y account
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
      And match response.data == dataJson.emailandaccount.data

  @GetSuccessAccount
    Scenario: solicitud get a mony account access con query account
      Given url urlBase + pathget
      And header transactionId = randomNumber
      And header objectType = 'ENTITY_01'
      And header query = "account = '420166082'"
      When method GET
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.message == 'Consulta Generada Exitosamente.'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.data == dataJson.emailandaccount.data

  @GetSuccessEmail
    Scenario: solicitud get a mony account access con query email
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
      And match response.data == dataJson.email.data

  @GetSuccessCustomerType&Account
    Scenario: solicitud get a mony account access con query costumer type y account
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
      And match response.data == dataJson.customertypeandaccount.data

  @GetSuccessCustomerType&Email
    Scenario: solicitud get a mony account access con query costumer type y email
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
      And match response.data == dataJson.customertypeandemail.data

  @GetSuccessCustomerType&Account&Email
    Scenario: solicitud get a mony account access con query costumer type, account y email
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
      And match response.data == dataJson.customertypeandaccountandemail.data