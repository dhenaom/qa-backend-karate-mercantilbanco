Feature: Consultas exitosa de firmantes de una cuenta y su información
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def urlBase = config.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def date = new java.util.Date()
    * def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
    * formatter.setTimeZone(java.util.TimeZone.getTimeZone("UTC"))
    * def formattedDate = formatter.format(date)
    * def body = karate.read('classpath:pa/com/bancomercantil/account/karate/datapersistence/jsonrequest/create.json')


  @AccountSignatorsSuccess
  Scenario Outline: Solicitud exitosa de firmante de una cuenta
    Given url urlBase + '/v1/party-reference-data-directory/reference/'+'<accountNumber>'+'/signatory/retrieve'
    And header transactionId = randomNumber
    And request body
    When method get
    Then status 200
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyIdentification.PartyIdentification.IdentifierValue.Value == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyName.GivenName == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyName.MiddleName == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyName.Surname == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyName.SecondSurname == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyName.MarriedSurname == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.ContactDetails.EmailAddress == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.DemographicData.PersonalData.GenderCode == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.DemographicData.PersonalData.MaritalStatus == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyIdentification.PartyIdentificationType == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.DemographicData.PersonalData.CountryOfNationality == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartySignature.SignatureType == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartySignature.SignatureCode == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartySignature.SignatureDescription == '#present'
    And match response.data.SignatoryParties[<Signator>].ProductInstanceReference.ProductInstanceLimit == '#present'
    And match response.data.SignatoryParties[<Signator>].PartyReference.PartyNote.NoteText == '#present'


    Examples:
      | accountNumber |Signator|
      | 300000354     | 0      |
      | 300000354     | 1      |
      | 300000354     | 2      |
      | 300000354     | 3      |
      | 300000354     | 4      |
