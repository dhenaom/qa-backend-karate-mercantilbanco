# proyecto-base-karate-full


## Name
Proyecto base de karate full.

## Description
En este proyecto base puede encontrar diferentes casos de uso con las diferentes funcionalidades de Karate. Como: Config | Scenarios outline | Variables | Reutilización - Calls | Read | Matchers y fuzzy matching | Retry | Expresiones regulares | tables | JS functions | Java functions | Condicionales | Paralelización | print | Ejecución con Runners | Variables de entorno y ejecución desde consola.

## Consideraciones
    - El proyecto usa como servicio base el servicio demo Reqres, el correcto funcionamiento de los casos de uso dependeran de la       disponibilidad del servicio demo en cuestion


## ✅ Technologies
### This project required:
- [JDK java] 
- [Karate] 
- [Gradle] 


## Project status
<h4 align="center"> 🚧 Proyecto en construcción 🚧 </h4> 

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## 📁 Access to project

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/calidad_de_software/digital-assests/pruebas-backend/karate/proyecto-base-karate-full.git
git branch -M develop
git push -uf origin develop
```

### Run con java jar
```
java -jar karate-1.4.0.jar <ruta_del_archivo.feature>

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" -DbaseUrl=https://miotraurl.com ruta_del_archivo.feature

java -jar karate-1.4.0.jar -Dkarate.options="--config karate-config.js" ruta_del_archivo.feature
```

#### ejemplo run con java jar

```
 java -jar karate-1.4.0.jar src/test/java/users/get/user-get.feature
 
```

### Run con gradle

```

 test --tests <nombre_de_clase>.<nombre_del_método> -D<propiedades_del_sistema>
 
 test --tests SampleTesClassRunner -DbaseUrl=https://reqres.in 
 
 test --tests SampleTesClassRunner.testTagsMethod -DbaseUrl=https://reqres.in 
 
 test -Dtest=SampleTesClassRunner#testTagsMethod
 
```

#### ejemplo run con gradle

```
 gradle test --tests ManagementUserTest.testParallel -DbaseUrl=https://reqres.in 
 
 gradle test --tests UserGetRunner -DbaseUrl=https://reqres.in 
 gradle test --tests UserGetRunner.userGet -DbaseUrl=https://reqres.in 
 
 gradle test -Dtest=UserGetRunner#userGet -DbaseUrl=https://reqres.in 
 
```

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Authors and acknowledgment

| [<img src="https://gitlab.com/uploads/-/system/user/avatar/13437423/avatar.png?width=400" width=115><br><sub>Mauro L. Ibarra P.</sub>](https://gitlab.com/mauro.ibarrap) <br/> | [<img src="https://secure.gravatar.com/avatar/4fd1b4dbc11df94113fb462a97f549ab?s=800&d=identicon" width=115><br><sub>Johan E. Agudelo</sub>](https://gitlab.com/johan.agudelov) |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

## License
Open source project.


