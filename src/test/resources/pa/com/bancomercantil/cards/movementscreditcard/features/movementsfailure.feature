Feature: validar casos failures servicio movimientos TDC
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def readBody = karate.read('classpath:pa/com/bancomercantil/cards/movementscreditcard/jsonRequest/body.json')
    * def baseBody = readBody.bodyOk
    * def path = '/v1/card-transaction-capture/transactions/retrieve'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
    * def messageerror = 'Ocurrió un error inesperado.'

  @FailureTransactionIdNull
  Scenario: Solicitud movimientos de tarjeta credito fallida transactionId nulo
    * def baseBody = readBody.bodyOk
    Given url urlBase + path
    And header transactionId = ''
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == "generated-fallback-transactionId"
    And match response.timestamp == isoformat

  @FailureWithOutTransactionIdHeader
  Scenario: Solicitud movimientos de tarjeta credito fallida sin transactionId en header
    * def baseBody = readBody.bodyOk
    Given url urlBase + path
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == "generated-fallback-transactionId"
    And match response.timestamp == isoformat

  @FailureCardNumberLength
  Scenario: Solicitud movimientos de tarjeta credito fallida tamaño CardNumber
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.CardNumber = 44550200031419915
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureCardNumberNotExist
  Scenario: Solicitud movimientos de tarjeta credito fallida CardNumber no existente
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.CardNumber = 5455020003141991
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 404
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureWithOutCardNumber
  Scenario: Solicitud movimientos de tarjeta credito fallida sin campo numero tarjeta
    * def baseBody = readBody.withOutCard
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureStartDateVsEndDate
  Scenario: Solicitud movimientos de tarjeta credito fecha inicial mayor que la fecha final
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.StartDate = '2025-01-02'
    * set baseBody.CardTransactionCapture.EndDate = '2025-01-01'
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureEqualDates
  Scenario: Solicitud movimientos de tarjeta credito fecha inicial igual que la fecha final
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.StartDate = '2025-01-01'
    * set baseBody.CardTransactionCapture.EndDate = '2025-01-01'
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureStartDateVsActualDate
  Scenario: Solicitud movimientos de tarjeta credito fecha inicial mayor que la fecha actual
    * def getFutureDate =
    """
    function(days) {
      var cal = java.util.Calendar.getInstance();
      cal.add(java.util.Calendar.DAY_OF_YEAR, days);
      return new java.text.SimpleDateFormat('yyyy-MM-dd').format(cal.getTime());
    }
    """
    * def futureDateStart = getFutureDate(5)
    * def futureDateEnd = getFutureDate(10)
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.StartDate = futureDateStart
    * set baseBody.CardTransactionCapture.EndDate = futureDateEnd
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureWithOutStartDate
  Scenario: Solicitud movimientos de tarjeta credito fallida sin fecha inicial
    * def baseBody = readBody.withOutStart
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureWithOutEndDate
  Scenario: Solicitud movimientos de tarjeta credito fallida sin fecha final
    * def baseBody = readBody.withOutEnd
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureWithOutVersion
  Scenario: Solicitud movimientos de tarjeta credito fallida sin campo service version
    * def baseBody = readBody.withOutVersion
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat

  @FailureVersionNull
  Scenario: Solicitud movimientos de tarjeta credito fallida campo service version null
    * def baseBody = readBody.bodyOk
    * set baseBody.CardTransactionCapture.ServiceVersion = ''
    Given url urlBase + path
    And header transactionId = randomNumber
    And request baseBody
    When method POST
    Then status 400
    And match response.message == messageerror
    And match response.status == 'ERROR'
    And match response.transactionId == randomNumber
    And match response.timestamp == isoformat