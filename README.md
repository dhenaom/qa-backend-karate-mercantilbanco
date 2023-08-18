
```
java -jar karate-1.4.0.jar <ruta_del_archivo.feature>

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" -DbaseUrl=https://miotraurl.com ruta_del_archivo.feature

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" ruta_del_archivo.feature
```

### ejemplo

```
 java -jar karate-1.4.0.jar src/test/java/users/get/user-get.feature
```