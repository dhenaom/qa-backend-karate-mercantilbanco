Feature: Validar autenticación fallida con distintos tipos de autenticación y delivery type
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def baseBody = karate.read('../jsonRequest/bodyRequestChallenge.json')
    * def responseBody1 = karate.read('../jsonResponse/invalidOtpDeliveryType.json')
    * def responseBody2 = karate.read('../jsonResponse/emptyOtpDeliveryType.json')
    * def responseBody3 = karate.read('../jsonResponse/missingParameters.json')
    * def responseBody4 = karate.read('../jsonResponse/500.json')
    * def responseBody5 = karate.read('../jsonResponse/404.json')
    * def responseBody6 = karate.read('../jsonResponse/403.json')
    * def NameUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomName = NameUtils.generateRandomUtil(6,"")

  @InvalidOtpDeliveryType
  Scenario: Intento de autenticación OTP con otpdeliveryType no válido
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = randomName
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody1.message

  @EmptyOtpDeliveryType
  Scenario: Intento de autenticación OTP con otpdeliveryType null
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = ""
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody2.message

  @MissingParameters
  Scenario: Intento de autenticación OTP con parametros faltantes
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment = {}
    And request modifiedBody
    When method post
    Then status 400
    And match response.message == responseBody3.message

  @UserIDEmpty
  Scenario Outline: Intento de autenticación <authenticateType> con userID vacio
    Given url urlBase + '/party-authentication/' + '' + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment = {}
    And request modifiedBody
    When method post
    Then status 404
#    And match response.message == "Resource not found" or match response.message == "Ocurrió un error inesperado en el servidor."

    Examples:
      | authenticateType |
      | OTP              |
      | Token            |
      | KBA              |
      | Password         |

  @InvalidUserID
  Scenario Outline: Intento de autenticación <authenticateType> con userID invalido
    Given url urlBase + '/party-authentication/' +randomName + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 404 or 500
#    And match response.message == responseBody5.message

    Examples:
      | authenticateType |
      | OTP              |
      | TOKEN            |
      | KBA              |
      | PASSWORD         |

  @AuthenticationTypeEmpty
  Scenario: Intento de autenticación con AuthenticationType nulo o vacio
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + '' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 404
    And match response.message == "Resource not found"

  @InvalidAuthenticationType
  Scenario: Intento de autenticación con AuthenticationType Invalido
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + randomName + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    And request modifiedBody
    When method post
    Then status 403
    And match response.message == responseBody6.message
