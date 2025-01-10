Feature: Validar autenticación exitosa con distintos tipos de autenticación

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.requestChallenge.connectTimeout)
    * karate.configure('readTimeout', config.requestChallenge.readTimeout)
    * def urlBase = config.requestChallenge.urlBase
    * def body = karate.read('../jsonRequest/bodyRequestChallenge.json')

  Scenario Outline: Solicitud exitosa con distintos métodos de autenticación
    Given url urlBase + user + '/authenticators/' + '<authenticateType>' + '/evaluate'
    And request body
    When method post
    Then status 200

    Examples:
      | authenticateType |
      | otp              |
      | token            |
      | kba              |