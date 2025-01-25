Feature: Obtener preguntas y respuestas de KBA challenge
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.validateChallenge.connectTimeout)
    * karate.configure('readTimeout', config.validateChallenge.readTimeout)
    * def urlBase = config.validateChallenge.urlBase
    * def kbaResponse = karate.call('classpath:pa/com/bancomercantil.authentication/karate/requestchallenge/features/requestchallengesuccess.feature@HappyPathKBA')
    * def tokenChallenge = kbaResponse.resp
    * def question1 = {Question:''}
    * def question1 = {Question:''}
    * def answer1 =
    """
    function() {
      if (question1 == '¿Cuándo es el aniversario de boda de sus padres?') return '0106';
      if (question1 == '¿En qué ciudad nació su madre?') return '04';
      if (question1 == '¿Cuáles son los 4 últimos números de la cédula de su esposo(a)?') return '1234';
      if (question1 == '¿Cuál era el modelo de su primer carro?') return '2007';
      if (question1 == '¿En qué sector/urb. vivía su mejor amigo(a) de bachillerato?') return '050036';
      return '';
    }
    """
    * def answer2 =
    """
    function() {
      if (question2 == '¿Cuándo es el aniversario de boda de sus padres?') return '0106';
      if (question2 == '¿En qué ciudad nació su madre?') return '04';
      if (question2 == '¿Cuáles son los 4 últimos números de la cédula de su esposo(a)?') return '1234';
      if (question2 == '¿Cuál era el modelo de su primer carro?') return '2007';
      if (question2 == '¿En qué sector/urb. vivía su mejor amigo(a) de bachillerato?') return '050036';
      return '';
    }
    """
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




