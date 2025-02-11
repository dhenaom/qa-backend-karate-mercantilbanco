Feature: Generar token para autenticacion de la API de entrust

      Background:
     * def config = call read('classpath:karate-config.js')
     * karate.configure('connectTimeout', config.entrust.connectTimeout)
     * karate.configure('readTimeout', config.entrust.readTimeout)
     * def urlBase = config.entrust.urlBase
     * def baseBody = karate.read('classpath:pa/com/bancomercantil/authentication/karate/utils/jsonRequest/bodyapiauthenticate.json')

      @APIAuthenticate
      Scenario: Autenticacion exitosa de la API de entrust
        Given url urlBase + 'adminapi/authenticate'
        And header Content-Type = 'application/json'
        And header Accept = 'application/json'
        And request baseBody
        When method post
        Then status 200
        And print response
        And def token = response.authToken



