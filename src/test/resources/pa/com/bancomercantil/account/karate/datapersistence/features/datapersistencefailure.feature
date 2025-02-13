Feature: Guardado de registros en tabla de persistencia de datos Exitoso
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def randomString = randomUtils.generateRandomUtil(8,"s")
    * def date = new java.util.Date()
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    * formatter.setTimeZone(java.util.TimeZone.getTimeZone("UTC"))
    * def formattedDate = formatter.format(date)
    * def body = karate.read('classpath:pa/com/bancomercantil/account/karate/datapersistence/jsonrequest/create.json')


  @CreateFailureTransactionIdNull
  Scenario: Solicitud Create Fallida transactionId nulo
    * set body.entity.createdAt = formattedDate
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = null
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'El transactionId no puede estar vacio.'

  @CreateFailureWithOutTransactionIdHeader
  Scenario: Solicitud Create Fallida sin header transactionId
    * set body.entity.createdAt = formattedDate
    Given url urlBase + '/v1/persistence/data/create'
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Required header 'transactionId' is not present."

  @CreateFailureDataTypeAliasNull
  Scenario: Solicitud Create Fallida dataTypeAlias nulo
    * set body.entity.createdAt = formattedDate
    * set body.dataTypeAlias = null
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'El campo DataTypeAlias no puede estar nulo'

  @CreateFailureInvalidDataTypeAlias
  Scenario: Solicitud Create Fallida dataTypeAlias invalido
    * set body.entity.createdAt = formattedDate
    * set body.dataTypeAlias = ''
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'Se ingreso un valor incorrecto para el campo dataTypeAlias'

  @CreateFailureObjectTypeNull
  Scenario: Solicitud Create Fallida objectType nulo
    * set body.entity.createdAt = formattedDate
    * set body.objectType = null
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'El campo objectType no puede estar vacio: '

  @CreateFailureInvalidObjectType
  Scenario: Solicitud Create Fallida objectType invalido
    * set body.entity.createdAt = formattedDate
    * set body.objectType = ' '
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'El campo objectType tiene un valor invalido.'

  @CreateFailureNullEntity
  Scenario: Solicitud Create Fallida entity nulo
    * set body.entity = null
    Given url urlBase + '/v1/persistence/data/create'
    And header transactionId = randomNumber
    And request body
    When method post
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == 'El campo entity no puede estar nulo'

  @GetFailureTransactionIdNull
  Scenario: Solicitud Get fallida con transactionId nulo
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = null
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El transactionId no puede estar vacio."

  @GetFailureWithOutHeaderTransactionId
  Scenario: Solicitud Get fallida sin header de transactionId
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
#    And header transactionId = null
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Required header 'transactionId' is not present."

  @GetFailureEmptyDataTypeAlias
  Scenario: Solicitud Get fallida con dataTypeAlias vacio
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
    And header dataTypeAlias = ''
    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo dataTypeAlias esta vacio."

  @GetFailureInvalidDataTypeAlias
  Scenario: Solicitud Get fallida con dataTypeAlias invalido
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
    And header dataTypeAlias = randomString
    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo dataTypeAlias tiene un valor invalido."

  @GetFailureWithOutHeaderDataTypeAlias
  Scenario: Solicitud Get fallida  sin header dataTypeAlias
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
#    And header dataTypeAlias = randomString
    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Required header 'dataTypeAlias' is not present."

  @GetFailureEmptyobjectType
  Scenario: Solicitud Get fallida con objectType vacio
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = ''
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo objectType esta vacio."

  @GetFailureInvalidobjectType
  Scenario: Solicitud Get fallida con objectType invalido
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
    And header dataTypeAlias = 'TYPE_BD_01'
    And header objectType = randomString
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo objectType tiene un valor invalido."

  @GetFailureWithOutHeaderobjectType
  Scenario: Solicitud Get fallida sin header objectType
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/retrieve'
    And header transactionId = randomNumber
    And header dataTypeAlias = 'TYPE_BD_01'
#    And header objectType = 'ENTITY_01'
    When method get
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Required header 'objectType' is not present."

  @UpdateFailureTransactionIdNull
  Scenario: Solicitud Update fallida con transactionId nulo
    * set body.entity.completedAt = formattedDate
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = null
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El transactionId no puede estar vacio."

  @UpdateFailureWithOutHeaderTransactionId
  Scenario: Solicitud Update fallida sin header transactionId
    * set body.entity.completedAt = formattedDate
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
#    And header transactionId = null
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Required header 'transactionId' is not present."

  @UpdateFailureInvalidDataTypeAlias
  Scenario: Solicitud Update fallida con dataTypeAlias invalido
    * set body.entity.completedAt = formattedDate
    * set body.dataTypeAlias = ''
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "Se ingreso un valor incorrecto para el campo dataTypeAlias"

  @UpdateFailureNullDataTypeAlias
  Scenario: Solicitud Update fallida con dataTypeAlias nulo
    * set body.entity.completedAt = formattedDate
    * set body.dataTypeAlias = null
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo DataTypeAlias no puede estar nulo"

  @UpdateFailureInvalidObjectType
  Scenario: Solicitud Update fallida con objectType invalido
    * set body.entity.completedAt = formattedDate
    * set body.objectType = randomString
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo objectType tiene un valor invalido."

  @UpdateFailureNullObjectType
  Scenario: Solicitud Update fallida con objectType nulo
    * set body.entity.completedAt = formattedDate
    * set body.objectType = null
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo objectType no puede estar vacio: "

  @UpdateFailureNullEntity
  Scenario: Solicitud Update fallida con entity nulo
    * set body.entity = null
    Given url urlBase + '/v1/persistence/data/67acf07891fd942e9faf6ccd/update'
    And header transactionId = randomNumber
    And request body
    When method put
    Then status 400
    And match response.status == 'ERROR'
    And match response.message == 'Ocurrió un error inesperado.'
    And match response.data == '#notnull'
    And match response.data.errorDetails.fields.exceptionMessage == "El campo entity no puede estar nulo"
