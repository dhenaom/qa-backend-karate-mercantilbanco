Feature: Consulta de información de un cliente en Entrust

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def response200 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/200.json')
    * def response400 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/400.json')
    * def response401 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/401.json')
    * def response403 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/403.json')
    * def response404 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/404.json')
    * def response500 = read('classpath:pa/com/bancomercantil.authentication/karate/getentrustuser/jsonResponse/500.json')

  @consultaExitosa
  Scenario: Consulta exitosa de un usuario en Entrust
    Given path '/party-reference-data-directory/dhenao_pragma/entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 200
    And match response == response200.success_response
    And match response.data contains { id: '#string', userId: '#string', email: '#string', state: '#string', locked: '#boolean', lastAuthTime: '#string' }

  @usuarioNulo
  Scenario: Intento de consulta con usuario nulo
    Given path '/party-reference-data-directory/null/entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 404
    And match response == response404.error_404_user_not_found
    And match response.data.errorDetails.code == 'user_not_found_response'

  @usuarioVacio
  Scenario: Intento de consulta con usuario vacío
    Given path '/party-reference-data-directory//entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 400
    And match response == response404.error_404_resource_not_found


  @usuarioInexistente
  Scenario: Intento de consulta con usuario inexistente
    Given path '/party-reference-data-directory/usuarioNoRegistrado123/entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 404
    And match response == response404.error_404_user_not_found

  @usuarioInvalido
  Scenario: Intento de consulta con usuario con caracteres inválidos
    Given path '/party-reference-data-directory/!@#$%^&*()/entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 404
    And match response == response404.error_404_user_not_found

  @sinAutenticacion #este cambia la respuesta para el futuro cuando se envie un token en el header
  Scenario: Intento de consulta sin autenticación
    Given path '/party-reference-data-directory/dhenao_pragma/entrust-user/retrieve'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 200
    And match response == response200.success_response

  @tokenInvalido
  Scenario: Intento de consulta con token inválido
    Given path '/party-reference-data-directory/dhenao_pragma/entrust-user/retrieve'
    And header Authorization = 'Bearer ABC123XYZ'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 200
    And match response == response200.success_response

  @errorSistema @ignore
  Scenario: Prueba de manejo de errores del sistema Entrust
    Given path '/party-reference-data-directory/juanPerez123/entrust-user/retrieve'
    And header Authorization = 'Bearer valid-token'
    And header transactionId = '69d2e073-df61-4587-aa7a-112b3a495b2b'
    When method GET
    Then status 500
    And match response == response500.error_500