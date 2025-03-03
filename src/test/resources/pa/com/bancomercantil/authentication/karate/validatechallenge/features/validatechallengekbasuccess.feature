Feature: Validar autenticación exitosa con distintos tipos de autenticación y delivery type

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def body2 = karate.read('../jsonRequest/body2ValidateChallenge.json')
    * def kbaResponse = karate.call('classpath:pa/com/bancomercantil/authentication/karate/validatechallenge/features/getquestionsandanswers.feature@getAnswers')
    * def tokenChallenge = kbaResponse.tokenChallenge
    * def questions = kbaResponse.body
    * set body2.Question = questions

  @QuestionAndAnswer
  Scenario: Evaluar valides de las respuestas de KBA
    Given url urlBase + '/party-authentication/' + user + '/question/evaluate'
    And header Authorization = tokenChallenge
    And request body2
    When method post
    Then status 200

