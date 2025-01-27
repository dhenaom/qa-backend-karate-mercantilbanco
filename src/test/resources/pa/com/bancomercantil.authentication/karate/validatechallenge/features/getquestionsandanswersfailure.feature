Feature: Obtener preguntas y respuestas de KBA challenge casos fallidos
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.validateChallenge.connectTimeout)
    * karate.configure('readTimeout', config.validateChallenge.readTimeout)
    * def urlBase = config.validateChallenge.urlBase
    * def kbaResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathKBA')
    * def tokenChallenge = kbaResponse.resp
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomPassword = randomUtils.generateRandomUtil(796,"password")

  @getAnswersInvalidUser
  Scenario: solicitud de preguntas KBA usuario invalido
    Given url urlBase + badUser + '/question/retrieve'
    When method get
    Then status 404
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def exceptionDetails = exceptionMessage.substring(exceptionMessage.indexOf(': "') + 3, exceptionMessage.lastIndexOf('"'))
    And def exceptionJson = karate.fromString(exceptionDetails)
    And match exceptionJson.errorCode == 'user_not_found'

  @getAnswersInvalidUser
  Scenario: solicitud de preguntas KBA usuario nulo
    Given url urlBase + '/question/retrieve'
    When method get
    Then status 404

