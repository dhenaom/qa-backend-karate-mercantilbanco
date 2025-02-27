Feature: validar casos failures servicio detalles TDC
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.connectTimeout)
    * karate.configure('readTimeout', config.readTimeout)
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def urlBase = config.urlBase
    * def readBody = karate.read('classpath:pa/com/bancomercantil/cards/detailscreditcard/jsonRequest/body.json')
    * def baseBody = readBody.bodyOk
    * def path = '/v1/credit-card/details/retrieve'
    * def isoformat = '#regex ^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})$'
    * def messageerror = 'Ocurrió un error inesperado.'
