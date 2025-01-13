Feature: Validar autenticación exitosa con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.requestChallenge.connectTimeout)
    * karate.configure('readTimeout', config.requestChallenge.readTimeout)
    * def urlBase = config.requestChallenge.urlBase
    * def baseBody = karate.read('../jsonRequest/bodyRequestChallenge.json')

  @HappyPath
  Scenario Outline: Solicitud exitosa con <authenticateType> y <deliveryType>
    Given url urlBase + user + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = '<deliveryType>'
    * print modifiedBody
    And request modifiedBody
    When method post
    Then status 200

    Examples:
      | authenticateType | deliveryType |
      | OTP              | EMAIL        |
      | OTP              | SMS          |
      | OTP              | VOICE        |
      | TOKEN            | SMS          |
      | KBA              | VOICE        |
      | PASSWORD         | EMAIL        |
