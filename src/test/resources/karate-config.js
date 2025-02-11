function fn() {
    var config = {
        user: 'dhenao_pragma',
        badUser: 'badUser',
        urlBase: 'http://qa-nova-gw.mercantilbanco.com.pa',
        connectTimeout: 3000,
        readTimeout: 3000,
        userState: {
            urlBase: 'http://api.bancomercantil.com/user-state',
            authMethod: 'Basic',
            connectTimeout: 3000,
            readTimeout: 3000
        },
        entrust: {
                    urlBase: 'https://mercantilbanpadesa.us.trustedauth.com/api/web/v1/',
                    connectTimeout: 3000,
                    readTimeout: 3000
                }
    };
    karate.configure('logPrettyRequest', false);
    karate.configure('logPrettyResponse', false);
    karate.configure('report', {
            type: 'json',
            dir: 'target/karate-reports' // Carpeta de salida donde se guardarán los informes JSON
        });

    return config;
}