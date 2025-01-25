Feature: Generar OTP de entrust

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.entrust.connectTimeout)
    * karate.configure('readTimeout', config.entrust.readTimeout)
    * def urlBase = config.entrust.urlBase
    * def baseBody = karate.read('classpath:pa/com/bancomercantil.authentication/karate/utils/jsonRequest/bodygenerateotp.json')

  @OTPGenerator
  Scenario: Generar OTP exitosamente desde Entrust
    * def apiResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/utils/features/apiaauthenticate.feature@APIAuthenticate')
    * def token = apiResponse.token
    Given url urlBase + 'otps'
    And header Authorization = token
    And header Content-Type = 'application/json'
    And request baseBody
    When method post
    Then status 200
    And def otp = response.otp
    And def tokenR = response.token
    And print 'OTP: ' + otp
    And print 'Token: ' + tokenR
