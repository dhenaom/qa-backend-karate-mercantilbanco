function fn() {
    var config = {
        user: 'ctorres_MBSA',
        badUser: 'badUser',
        requestChallenge: {
            urlBase: 'http://localhost:8080/party-authentication/',
            connectTimeout: 2000, // Tiempo de conexión para este microservicio
            readTimeout: 2000     // Tiempo de lectura para este microservicio
        },
        userState: {
            urlBase: 'https://api.bancomercantil.com/user-state',
            authMethod: 'Basic',
            connectTimeout: 1000,
            readTimeout: 1000
        },
        validateChallenge: {
            urlBase: 'https://api.bancomercantil.com/validate-challenge',
            authMethod: 'API-Key',
            connectTimeout: 1000,
            readTimeout: 1000
        }
    };

    return config;
}