Feature: validar casos success servicio movimients TDC
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def readBody = karate.read('classpath:pa/com/bancomercantil/cards/movementscreditcard/jsonRequest/body.json')
    * def path = '/v1/card-transaction-capture/transactions/retrieve'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'

  @MovementsSuccess
    Scenario: solicitud post exitosa
      * def baseBody = readBody.bodyOk
      * def refMillis = karate.toMillis(baseBody.StartDate)
      * def checkDate = function(fecha){ return karate.toMillis(fecha) >= refMillis }
    Given url urlBase + path
      And header transactionId = randomNumber
      And request baseBody
      When method POST
      Then status 200
      And match response.status == 'SUCCESS'
      And match response.timestamp == isoformat
      And match response.transactionId == randomNumber
      And match response.message == 'Successfully processed the card transaction.'
      And match response.data == '#notnull'
      And match response.data.CardTransactionCaptureDetail == '#notnull'
      And match response.data.CardTransactionCaptureDetail.CardTransactionStatus == '#notnull'
      And match response.data.CardTransactionCaptureDetail.CardTransactionStatus contains {Status: "#string", StatusCode: "#string",StatusMessage: "#string"}
      And match response.data.CardTransactionCaptureDetail.TransactionDetails == '#notnull'
      And match each response.data.CardTransactionCaptureDetail.TransactionDetails contains { TransactionMerchant: '#string', TransactionDate: '#string', TransactionTime: '#string', TransactionCurrencyCode: '#string', TransactionAmount: '#string', TransactionType: '#string', TransactionAuthNumber: '#string', TransactionMCCCode: '#string', TransactionMCCCategory: '#string' }
