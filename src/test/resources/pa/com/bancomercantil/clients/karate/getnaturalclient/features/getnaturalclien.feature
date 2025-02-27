@party-reference-data-directory
@consultaClientes
Feature: Consulta de datos de clientes Panama Venezuela

  Background:
    * url 'http://qa-nova-gw.mercantilbanco.com.pa'
    * def clientResponses = read('classpath:pa.com.bancomercantil/client.karate/getnaturalclient/jsonResponse/client_responses.json')

  @CLIE001 @consultaDetailVenezuela
  Scenario Outline: Consulta detalle de cliente venezolano
    Given path '/v1/party-reference-data-directory/<document>/detail-venezuela/retrieve'
    And param documenttype = '<document_type>'
    And header transactionId = '<transaction_id>'
    When method GET
    Then status <status>
    And match response == clientResponses[<response_type>]

    Examples:
      | document   | document_type | transaction_id | status | response_type        |
      | V23712176  | V            | 123456         | 200    | 'detailSuccess'      |
      | V23712176  | XX           | 123456         | 400    | 'invalidDocumentType' |
      | V23712176  |              | 123456         | 400    | 'invalidDocumentType' |
      | 123456789  | V            | 123456         | 400    | 'invalidFormat'      |
      | V23712176  | V            |                | 400    | 'missingTransaction'  |

  @CLIE002 @consultaDetailPanama
  Scenario Outline: Consulta detalle de cliente panameño
    Given path '/v1/party-reference-data-directory/<document>/detail-panama/retrieve'
    And param documenttype = '<document_type>'
    And header transactionId = '<transaction_id>'
    When method GET
    Then status <status>
    And match response == clientResponses[<response_type>]

    Examples:
      | document            | document_type | transaction_id | status | response_type        |
      | 00-E-08101-000057  | CE           | 123456         | 200    | 'detailPanama'       |
      | 00-E-08101-000057  | XX           | 123456         | 400    | 'invalidDocumentType' |
      | 00-E-08101-000057  |              | 123456         | 400    | 'invalidDocumentType' |
      | 123456789          | CE           | 123456         | 400    | 'invalidFormat'      |
      | 00-E-08101-000057  | CE           |                | 400    | 'missingTransaction'  |

  @CLIE003 @consultaDemogVenezuela
  Scenario Outline: Consulta demografica de cliente venezolano
    Given path '/v1/party-reference-data-directory/demographics/<document>/demog-venezuela/retrieve'
    And param documenttype = '<document_type>'
    And header transactionId = '<transaction_id>'
    When method GET
    Then status <status>
    And match response == clientResponses[<response_type>]

    Examples:
      | document   | document_type | transaction_id | status | response_type        |
      | V23712176  | V            | 123456         | 200    | 'demogSuccess'       |
      | V23712176  | XX           | 123456         | 400    | 'invalidDocumentType' |
      | V23712176  |              | 123456         | 400    | 'invalidDocumentType' |
      | 123456789  | V            | 123456         | 400    | 'invalidFormat'      |
      | V23712176  | V            |                | 400    | 'missingTransaction'  |

  @CLIE004 @consultaDemogPanama
  Scenario Outline: Consulta demografica de cliente panameño
    Given path '/v1/party-reference-data-directory/demographics/<document>/demog-panama/retrieve'
    And param documenttype = '<document_type>'
    And header transactionId = '<transaction_id>'
    When method GET
    Then status <status>
    And match response == clientResponses[<response_type>]

    Examples:
      | document            | document_type | transaction_id | status | response_type        |
      | 00-E-08101-000057  | CE           | 123456         | 200    | 'demogPanama'        |
      | 00-E-08101-000057  | XX           | 123456         | 400    | 'invalidDocumentType' |
      | 00-E-08101-000057  |              | 123456         | 400    | 'invalidDocumentType' |
      | 123456789          | CE           | 123456         | 400    | 'invalidFormat'      |
      | 00-E-08101-000057  | CE           |                | 400    | 'missingTransaction'  |