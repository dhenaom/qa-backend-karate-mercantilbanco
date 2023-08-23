### Con java jar
```
java -jar karate-1.4.0.jar <ruta_del_archivo.feature>

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" -DbaseUrl=https://miotraurl.com ruta_del_archivo.feature

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" ruta_del_archivo.feature
```

#### ejemplo con java jar

```
 java -jar karate-1.4.0.jar src/test/java/users/get/user-get.feature
 
```

### Con gradle

```

 test --tests <nombre_de_clase>.<nombre_del_método> -D<propiedades_del_sistema>
 
 test --tests SampleTesClassRunner -DbaseUrl=https://reqres.in 
 
 test --tests SampleTesClassRunner.testTagsMethod -DbaseUrl=https://reqres.in 
 
 test -Dtest=SampleTesClassRunner#testTagsMethod
 
```

#### ejemplo con gradle

```
 gradle test --tests ManagementUserTest.testParallel -DbaseUrl=https://reqres.in 
 
 gradle test --tests UserGetRunner -DbaseUrl=https://reqres.in 
 gradle test --tests UserGetRunner.userGet -DbaseUrl=https://reqres.in 
 
 gradle test -Dtest=UserGetRunner#userGet -DbaseUrl=https://reqres.in 
 
```