Feature: Autenticación de la API de DataPro exitosa

  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def i = 0
    * def dateFormat =
    """
    function(epoch) {
      var date = new Date(parseInt(epoch));
      return date.getFullYear() + '-' +
      ('0' + (date.getMonth() + 1)).slice(-2) + '-' +
      ('0' + date.getDate()).slice(-2) + ' ' +
      ('0' + date.getHours()).slice(-2) + ':' +
      ('0' + date.getMinutes()).slice(-2) + ':' +
      ('0' + date.getSeconds()).slice(-2);
    }
    """

  @HappyPath
  Scenario: Autenticación exitosa de la API de DataPro y retorno de token
    Given url urlBase + '/v1/datapro-authentication/authenticate/retrieve'
    And header transactionId = randomNumber
    When method get
    Then status 200
    And match response.data.accessToken != null
    And match response.data.refreshToken != null
    And match response.data.expiresIn != null
    And def responseToken = response.data.accessToken
    And def expiresIn = response.data.expiresIn
    And def now = new Date().getTime()
    And def differenceMin = Math.floor((parseInt(expiresIn) - now) / 60000)
    And assert differenceMin >= 5
    And print 'Diferencia en minutos:', differenceMin

  @Consistency
  Scenario: Autenticación exitosa de la API de DataPro y retorno de token con consistencia
    * def tokens = []
    * eval i = i + 1
    Given url urlBase + '/v1/datapro-authentication/authenticate/retrieve'
    And header transactionId = Math.floor(new Date().getTime() / 1000000) + i
    When method get
    Then status 200
    And match response.data.accessToken != null
    And match response.data.refreshToken != null
    And match response.data.expiresIn != null
    And karate.appendTo('tokens', response.data.accessToken)
    And eval i = i + 1
    And header transactionId = Math.floor(new Date().getTime() / 1000000) + i
    When method get
    Then status 200
    And match response.data.accessToken != null
    And match response.data.refreshToken != null
    And match response.data.expiresIn != null
    And karate.appendTo('tokens', response.data.accessToken)
    * eval i = i + 1
    And header transactionId = Math.floor(new Date().getTime() / 1000000) + i
    When method get
    Then status 200
    And match response.data.accessToken != null
    And match response.data.refreshToken != null
    And match response.data.expiresIn != null
    And karate.appendTo('tokens', response.data.accessToken)
    * eval i = i + 1
    And header transactionId = Math.floor(new Date().getTime() / 1000000) + i
    When method get
    Then status 200
    And match response.data.accessToken != null
    And match response.data.refreshToken != null
    And match response.data.expiresIn != null
    And karate.appendTo('tokens', response.data.accessToken)
    And def firstToken = tokens[0]
    And karate.forEach(tokens, function(token, index) { karate.log('Token ' + index + ':', token); karate.match(token, firstToken); })

