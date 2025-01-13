Feature: Validar autenticación fallida con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.requestChallenge.connectTimeout)
    * karate.configure('readTimeout', config.requestChallenge.readTimeout)
    * def urlBase = config.requestChallenge.urlBase
    * def baseBody = karate.read('../jsonRequest/bodyRequestChallenge.json')
    * def responseBody1 = karate.read('../jsonResponse/invalidOtpDeliveryType.json')
    * def responseBody2 = karate.read('../jsonResponse/emptyOtpDeliveryType.json')
    * def responseBody3 = karate.read('../jsonResponse/missingParameters.json')
    * def responseBody4 = karate.read('../jsonResponse/500.json')
    * def responseBody5 = karate.read('../jsonResponse/404.json')
    * def responseBody6 = karate.read('../jsonResponse/403.json')
    * def NameUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.NameUtils')
    * def randomName = NameUtils.generateRandomName(6)

  @InvalidOtpDeliveryType
  Scenario: Intento de autenticación OTP con otpdeliveryType no válido
    Given url urlBase + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = randomName
    * print modifiedBody
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody1.message

  @EmptyOtpDeliveryType
  Scenario: Intento de autenticación OTP con otpdeliveryType null
    Given url urlBase + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = ""
    * print modifiedBody
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody2.message

  @MissingParameters
  Scenario Outline: Intento de autenticación <authenticateType> con parametros faltantes
    Given url urlBase + user + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment = {}
    * print modifiedBody
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody3.message

    Examples:
      | authenticateType |
      | OTP              |
      | TOKEN            |
      | KBA              |

  @UserIDEmpty
  Scenario Outline: Intento de autenticación <authenticateType> con userID vacio
    Given url urlBase + '//' + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment = {}
    * print modifiedBody
    And request modifiedBody
    When method post
    Then status 500
    And match response.message == responseBody4.message

    Examples:
      | authenticateType |
      | OTP              |
      | TOKEN            |
      | KBA              |

  @InvalidUserID
  Scenario Outline: Intento de autenticación <authenticateType> con userID invalido
    Given url urlBase + '/'+randomName+'/' + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 404
    And match response.message == responseBody5.message

    Examples:
      | authenticateType |
      | OTP              |
      | TOKEN            |
      | KBA              |

  @AuthenticationTypeEmpty
  Scenario: Intento de autenticación OTP con otpdeliveryType null
    Given url urlBase + user + '/authenticators/' + '' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 500
    And match response.message == responseBody4.message

  @InvalidAuthenticationType
  Scenario: Intento de autenticación OTP con otpdeliveryType null
    Given url urlBase + user + '/authenticators/' + randomName + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 403
    And match response.message == responseBody6.message
