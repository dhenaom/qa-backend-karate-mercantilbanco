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
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomPassword1 = randomUtils.generateRandomUtil(9,"password")
    * def randomPassword2 = randomUtils.generateRandomUtil(9,"password")
    * def randomToken = randomUtils.generateRandomUtil(796,"password")
    * set body2.Question.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[0].Answer = randomPassword1
    * set body2.Question.AuthenticationSecretQuestionValue.KbaChallenge.UserQuestions[1].Answer = randomPassword2

  @QuestionAndAnswer
  Scenario: Evaluar respuestas fallidas de KBA
    Given url urlBase + '/party-authentication/' + user + '/question/evaluate'
    And header Authorization = tokenChallenge
    And request body2
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def extractedJson = exceptionMessage.substring(16)
    And def parsedJson = karate.fromString(extractedJson)
    And match parsedJson.errorCode == 'invalid_user_response'

  @InvalidToken
  Scenario: Evaluar respuestas de KBA con token de autorizacion invalido
    Given url urlBase + '/party-authentication/' + user + '/question/evaluate'
    And header Authorization = randomToken
    And request body2
    When method post
    Then status 401
    And def exceptionMessage = response.data.errorDetails.fields.exceptionType
    And match exceptionMessage == 'Unauthorized'

  @BadUser
  Scenario: Evaluar respuestas de KBA con usuario invalido
    Given url urlBase + '/party-authentication/' + badUser + '/question/evaluate'
    And header Authorization = tokenChallenge
    And request body2
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionType
    And match exceptionMessage == 'Forbidden'

  @InvalidKBAChallengeId
  Scenario: Evaluar respuestas de KBA con KBAChallengeId invalido
    Given url urlBase + '/party-authentication/' + user + '/question/evaluate'
    And header Authorization = tokenChallenge
    And request body2
    When method post
    Then status 403
    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
    And def extractedJson = exceptionMessage.substring(16)
    And def parsedJson = karate.fromString(extractedJson)
    And match parsedJson.errorCode == 'invalid_user_response'

  @NullTokenAuthorization
  Scenario: Evaluar respuestas de KBA con KBAChallengeId invalido
    Given url urlBase + '/party-authentication/' + user + '/question/evaluate'
    And header Authorization = null
    And request body2
    When method post
    Then status 401
#    And def exceptionMessage = response.data.errorDetails.fields.exceptionMessage
#    And def extractedJson = exceptionMessage.substring(16)
#    And def parsedJson = karate.fromString(extractedJson)
#    And match parsedJson.errorCode == 'invalid_user_response'

