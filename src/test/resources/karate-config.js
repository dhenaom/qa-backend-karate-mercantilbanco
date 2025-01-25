function fn() {
    var config = {
        user: 'dhenao_pragma',
        badUser: 'badUser',
        requestChallenge: {
            urlBase: 'http://localhost:8080/party-authentication/',
            connectTimeout: 3000, // Tiempo de conexión para este microservicio
            readTimeout: 3000     // Tiempo de lectura para este microservicio
        },
        userState: {
            urlBase: 'http://api.bancomercantil.com/user-state',
            authMethod: 'Basic',
            connectTimeout: 3000,
            readTimeout: 3000
        },
        validateChallenge: {
            urlBase: 'http://localhost:8080/party-authentication/',
            connectTimeout: 2000,
            readTimeout: 2000
        },
        entrust: {
                    urlBase: 'https://mercantilbanpadesa.us.trustedauth.com/api/web/v1/',
                    connectTimeout: 3000,
                    readTimeout: 3000
                }
    };
    karate.configure('logPrettyRequest', false);
    karate.configure('logPrettyResponse', false);

    return config;
}