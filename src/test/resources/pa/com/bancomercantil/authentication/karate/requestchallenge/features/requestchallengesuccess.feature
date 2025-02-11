Feature: Validar solicitud de challenge exitosa con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def baseBody = karate.read('classpath:pa/com/bancomercantil/authentication/karate/requestchallenge/jsonRequest/bodyRequestChallenge.json')

  @HappyPath
  Scenario Outline: Solicitud exitosa con <authenticateType> y <deliveryType>
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + '<authenticateType>' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = '<deliveryType>'
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
  @HappyPathOTP
  Scenario: Solicitud exitosa con OTP y EMAIL
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'OTP' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = 'EMAIL'
    And request modifiedBody
    When method post
    Then status 200

  @HappyPathToken
  Scenario: Solicitud exitosa con TOKEN y EMAIL
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'TOKEN' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = 'EMAIL'
    And request modifiedBody
    When method post
    Then status 200
    And def tokenR = response.data.Password.AuthenticationPasswordPresentedValue

  @HappyPathKBA
  Scenario: Solicitud exitosa con KBA y EMAIL
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'KBA' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = 'EMAIL'
    And request modifiedBody
    When method post
    Then status 200
    And def resp = response.data.Password.AuthenticationPasswordPresentedValue

  @HappyPathPassword
  Scenario: Solicitud exitosa con PASSWORD y EMAIL
    Given url urlBase + '/party-authentication/' + user + '/authenticators/' + 'PASSWORD' + '/evaluate'
    * def modifiedBody = JSON.parse(JSON.stringify(baseBody))
    * set modifiedBody.PartyAuthenticationAssessment.OtpDeliveryType = 'EMAIL'
    And request modifiedBody
    When method post
    Then status 200
    And def tokenR = response.data.Password.AuthenticationPasswordPresentedValue

  @after
  Scenario: Comprimir reportes después de cada escenario
    * def ZipUtil = Java.type('pa.com.bancomercantil.authentication.karate.utils.ZipUtil')
    * def reportDir = '/Users/DHM_Pragma/Documents/Mercantil/qa-backend-karate-mercantilbanco/src/test/resources/target/karate-reports'
    * def zipFile = 'target/karate-report-' + Date.now() + '.zip'
    * def run = ZipUtil.zipDirectory(reportDir, zipFile)
