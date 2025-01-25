Feature: Validar autenticación fallida con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.validateChallenge.connectTimeout)
    * karate.configure('readTimeout', config.validateChallenge.readTimeout)
    * def urlBase = config.validateChallenge.urlBase
    * def body1 = karate.read('../jsonRequest/body1ValidateChallenge.json')
    * def body2 = karate.read('../jsonRequest/body2ValidateChallenge.json')
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomPassword = randomUtils.generateRandomUtil(9,"password")

  @FailedOTPValidation
  Scenario: Validar Challenge fallido con OTP
    * def otpResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/utils/features/otpgenerator.feature@OTPGenerator')
    * def tokenChallenge = otpResponse.tokenR
    * def otp = randomNumber
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = otp
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def extractedJson = exceptionMessage.substring(16)
    And def parsedJson = karate.fromString(extractedJson)
    And match parsedJson.errorCode == 'invalid_user_response'

  @FailedTokenValidation
  Scenario: Validar Challenge fallido Con Token
    * def tokenResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathToken')
    * def tokenChallenge = tokenResponse.tokenR
    * def otp = 'randomNumber'
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = ""+otp+""
    * set modifiedBody.PartyAuthenticationAssessment.AuthenticationType = 'TOKEN'
    * print modifiedBody
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def extractedJson = exceptionMessage.substring(16)
    And def parsedJson = karate.fromString(extractedJson)
    And match parsedJson.errorCode == 'invalid_user_response'

  @FailedPasswordValidation
  Scenario: Validar Challenge fallido Con Password
    * def passwordResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathPassword')
    * def tokenChallenge = passwordResponse.tokenR
    * def otp = randomPassword
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = ""+otp+""
    * set modifiedBody.PartyAuthenticationAssessment.AuthenticationType = 'PASSWORD'
    * print modifiedBody
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def extractedJson = exceptionMessage.substring(16)
    And def parsedJson = karate.fromString(extractedJson)
    And match parsedJson.errorCode == 'invalid_user_response'

