Feature: validar casos failures servicio movimients TDC
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
  Scenario: Solicitud fallida transactionId nulo
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
  Scenario: Solicitud fallida sin transactionId en header
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
  Scenario: solicitud fallida tamaño
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

  @FailureWithOutCardNumber
  Scenario: solicitud fallida sin campo numero tarjeta
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
  Scenario: solicitud fecha inicial mayor que la fecha final
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
  Scenario: solicitud fecha inicial igual que la fecha final
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
  Scenario: solicitud fecha inicial mayor que la fecha actual
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
  Scenario: solicitud fallida sin fecha inicial
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
  Scenario: solicitud fallida sin fecha final
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
  Scenario: solicitud fallida sin campo version
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
  Scenario: solicitud fallida sin campo service version
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