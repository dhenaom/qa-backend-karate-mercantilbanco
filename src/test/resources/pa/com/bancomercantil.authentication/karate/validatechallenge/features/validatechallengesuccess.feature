Feature: Validar autenticación exitosa con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.validateChallenge.connectTimeout)
    * karate.configure('readTimeout', config.validateChallenge.readTimeout)
    * def urlBase = config.validateChallenge.urlBase
    * def body1 = karate.read('../jsonRequest/body1ValidateChallenge.json')
    * def body2 = karate.read('../jsonRequest/body2ValidateChallenge.json')

  @ValidateOTP
  Scenario: Validar Challenge exitoso Con OTP
    * def otpResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/utils/features/otpgenerator.feature@OTPGenerator')
    * def tokenChallenge = otpResponse.tokenR
    * def otp = otpResponse.otp
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = otp
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 200

  @ValidateToken
  Scenario: Validar Challenge exitoso Con Token
    * def tokenResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathToken')
    * def tokenChallenge = tokenResponse.tokenR
    # Remplazar con el valor entregado por la app de softToken
    * def otp = '38040007'
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = ""+otp+""
    * set modifiedBody.PartyAuthenticationAssessment.AuthenticationType = 'TOKEN'
    * print modifiedBody
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 200

  @ValidatePassword
  Scenario: Validar Challenge exitoso Con Password
    * def passwordResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathPassword')
    * def tokenChallenge = passwordResponse.tokenR
    * def otp = 'Dhmejia51'
    * def modifiedBody = JSON.parse(JSON.stringify(body1))
    * set modifiedBody.Password.AuthenticationPasswordPresentedValue = ""+otp+""
    * set modifiedBody.PartyAuthenticationAssessment.AuthenticationType = 'PASSWORD'
    * print modifiedBody
    Given url urlBase + user + '/password/evaluate'
    And header Authorization = 'Bearer ' + tokenChallenge
    And request modifiedBody
    When method post
    Then status 200

