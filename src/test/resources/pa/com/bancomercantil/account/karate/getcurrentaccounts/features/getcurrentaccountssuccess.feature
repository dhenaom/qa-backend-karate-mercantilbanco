Feature: Solicitud exitosa cuentas corriente
  Background:
    * def config = call read('classpath:karate-config.js')
    * karate.configure('connectTimeout', config.dataPro.connectTimeout)
    * karate.configure('readTimeout', config.dataPro.readTimeout)
    * def urlBase = config.dataPro.urlBase
    * def randomUtils = Java.type('pa.com.bancomercantil.authentication.karate.utils.RandomUtils')
    * def randomNumber = randomUtils.generateRandomUtil(8,"number")
    * def i = 0
