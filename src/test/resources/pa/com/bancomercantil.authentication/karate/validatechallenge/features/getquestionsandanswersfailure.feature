Feature: Obtener preguntas y respuestas de KBA challenge fallida
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.validateChallenge.connectTimeout)
    * karate.configure('readTimeout', config.validateChallenge.readTimeout)
    * def urlBase = config.validateChallenge.urlBase
    * def kbaResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathKBA')
    * def tokenChallenge = kbaResponse.resp
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomPassword = randomUtils.generateRandomUtil(9,"password")

  @getAnswers
  Scenario: obtener preguntas KBA
    Given url urlBase + user + '/question/retrieve'
    And header Authorization = tokenChallenge
    When method get
    Then status 200
    And def body = response.data.Question
    And def question1 = body.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[0].Question
    And def question2 = body.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[1].Question
    And def idKBA = body.AuthenticationSecretQuestionValue.KbaChallenge.Id
    And def aw1 = call answer1
    And def aw2 = call answer2
    And set body.AuthenticationSecretQuestionValue.KbaChallenge.Id = idKBA
    And set body.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[0].Answer = aw1
    And set body.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[1].Answer = aw2




