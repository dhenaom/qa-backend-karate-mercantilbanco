function fn() {
    karate.configure('connectTimeout', 7000);
    karate.configure('readTimeout', 7000);
    karate.configure('ssl', true);

//  karate.propetiores definida desde entorno de ejecucion
    let baseUrl = karate.properties['baseUrl'] || 'https://reqres.in'

//  Las propiedades se pueden definir de manera abierta (segun se necesiten setear desde el entorno de ejecucion), ejemplo
//  let apicEnv = karate.properties['apicEnv'] || 'testing'
//  let pathBase = 'api/v1/private-holaMundo/'+ apicEnv +'/v1/operations/products'

    return {
        api: {
            baseUrl: baseUrl // + '/' + pathBase
        },
        rolesTest: {
            firstRol: "qa",
            secondRol: "leader",
            thirdRol: "developer",
        }
    };
}