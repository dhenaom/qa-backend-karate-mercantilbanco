# *Introducción*

## *Propósito:*

El propósito de este plan es definir la estrategia y el enfoque de la validación funcional de los servicios, para garantizar que las APIs cumplan con los estándares de desarrollo definidos en BIAN que serán expuestos en capa media, y que deben cumplir con los requisitos técnicos del negocio.

Este Plan de Pruebas permitirá:

* Validar la correcta implementación de cada Enpoint, en función de los criterios funcionales y de negocio que se definieron en historias de usuario técnicas.

* Detectar defectos en la primera etapas de desarrollo, con el propósito de reducir costos en correcciones.

* Asegurar la estabilidad y confiabilidad de los servicios, antes de su puesta en producción.

* Proveer un marco estructurado para la ejecución y seguimiento de las pruebas.

## *Alcance:*

Este plan cubre la verificación funcional de los servicios expuestos en la capa media para la nueva banca en línea en sus versiones móvil y web (para las funcionalidades comunes)

#### 1. Componentes a ser probados

* Servicios REST expuestos para la comunicación entre frontend (móvil/web) y backend.

* Flujos de negocio clave, como:
      1. Autenticación y gestión de usuarios (Login contraseña , Login Face ID / Huella)
      2. Consulta de Clientes
      3. Consulta de Cuentas (Home)
      4. Consulta de TDC (Home)
      5. Consulta de Préstamos (Home)
      6. Consulta de Detalle de cuenta
      7. Débito y Crédito en cuenta
      8. Consulta Movimientos de cuentas
      9. Consulta detalle de TDC
      10. Consulta movimientos de TDC
      11. Consulta movimientos retenidos o bloqueados TDC (Tránsito)
      12. Bloqueo Provisional de TDC
      13. Desbloqueo de TDC
      14. Activar TDC
      15. Consulta detalle de Préstamo
      16. Pago de TDC mismo titular
      17. Canje de Puntos
      18. Cambio de PIN de TDC
      19. Visualización de TDC adicionales
      20. Transferencia ACH
      21. ACH Express
      22. Transferir con línea de sobregiro
      23. Autenticar transacciones
      24. Recarga de Zinli
      25. Crear beneficiarios
      26. Editar y Eliminar Beneficiarios
      27. Consulta de beneficiarios
      28. Estatus de TDC
      29. Recuperación de contraseña
      30. Cambio de correo Notificaciones
      31. Transferencia terceros mismo banco
      32. Notificaciones alertas
      33. Consulta de TDD
      34. Solicitud de PIN TDD
      35. Transferencia Internacional
      36. Pago de servicios
      37. Sección de DPF (Home)
      38. Consulta del detalle del DPF
      39. Configuración de token (Afiliar Token)
      40. Solicitud de seguro
      41. Bloqueo o cancelar token
      42. Protección de token
      43. Recuperación de pin de token
      44. Cashing/ Avance de efectivo
      45. Sistema de monitoreo (Cumplimiento)
      46. Afiliación​ e identificación del cliente.
            * Login cotitulares
            * Login menores de edad
      47. Crear Beneficiarios de pagos de servicios
      48. Transferencia MBU
      49. Agregar Beneficiario Zinli
      50. Editar  y Eliminar Beneficiarios Zinli
      51. Consulta de beneficiarios Zinli
* Validación de contratos de API para asegurar que los endpoints cumplen con los esquemas definidos (Swagger/OpenAPI).
* Manejo de errores y mensajes de respuesta, garantizando una experiencia de usuario consistente.

### 2. *Fuera de Alcance:*

* Pruebas de rendimiento y carga (cubiertas en otro plan de pruebas específico).
* Pruebas de seguridad (aunque se validarán requisitos básicos como autenticación y autorización).

## *Definiciones, acrónimos y abreviaturas:*

| Siglas / Definiciones       | Significado                             |
| -------------               | -------------                           |
| API                         |Application Programming Interface.       |
| BIAN                        |Banking Industry Architecture Network.   |
| Swagger                     |Herramienta para documentar APIs.        |
| DPF                         |Depósito a Plazo Fijo                    |
| MBU                         |Mercantil Banco Universal                |
| TDD                         |Tarjeta de Débito                        |
| TDC                         |Tarjeta de Crédito                       |

# *Referencias:*

| Documento                         | Ruta                                    |
| -------------                     | -------------                           |
| Estrategia de Pruebas             |[Frente de Pruebas - OneDrive](https://mercantilpanama-my.sharepoint.com/personal/ctorres_mercantilbanco_com_pa/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fctorres%5Fmercantilbanco%5Fcom%5Fpa%2FDocuments%2FProyectos%2FBanca%20Digital%2FDocumentos%20de%20Proyecto%2FFrente%20de%20Pruebas&sortField=FileLeafRef&isAscending=true&FolderCTID=0x01200075A890595C93084D8040782658522091&view=0&OR=Teams%2DHL&CT=1734646290436&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDExMDExNTcyNCIsIkhhc0ZlZGVyYXRlZFVzZXIiOnRydWV9&noAuthRedirect=1)|
| Documentación BIAN                | Pendiente ruta                          |
| DataPro Documento Criterios Aceptación APIs | [Nova Digital - pragma - Insumos - Todos los documentos]() |
| Funcionalidades de Banca Móvil    | Nova Digital Matriz Funcionalidades (HU por Olas).xlsx |
| Priorización HUs y Relación HTs   | Nova Digital - Priorización de HUs y Relación con HTs (Enero 2025).xlsx |
| Matriz Funcionalidades            | Nova Digital Matriz Funcionalidades.xlsx|

# *Plan de Gestión de Pruebas:*

## Organización de Pruebas

| Roles                       | Nombres               |                             |
| -------------               | -------------         | ----------                  |
| Líder Técnico               | Neymar Pimentel       | Gestión                     |
| Líder Técnico               | Manuel Mayora         | Gestión                     |
| Líder Funcional             | Gabriela Sisinno      | Gestión / Stakeholder       |
| Líder de Pruebas            | Orlin Moreno          | Planificación y Gestión     |
| Especialista de Calidad     | Venicia Villamil      | Gestión y Ejecución         |
| QA Técnico                  | David Henao           | Análisis y Ejecución        |
| QA Técnico                  | Mateo Arroyave        | Análisis y Ejecución        |
| QA Técnico                  | Luis Mindiola         | Análisis y Ejecución        |

## *Responsabilidades:*

| Rol |Responsabilidades|Backup|
| -------------   | --------         | ----------                  |
|Líder QA | <ul><li> El Monitorear avance de las pruebas y asignar prioridades.</li> <li> Asegurar que los recursos necesarios se encuentren disponibles para las pruebas.</li> <li> Formar parte y avalar las decisiones de la Mesa de Incidencias (incluye la categorización de incidentes) </li> <li>Coordinar la ejecución de las pruebas con apoyo del Administrador de Ambientes.</li> <li> Actuar como vínculo entre los usuarios expertos y el equipo de proyecto. </li> <li>Avalar escenarios, casos y scripts de pruebas con el apoyo de los key users. </li><li>Garantizar que se cumplan los criterios de Aceptación y el cronograma de pruebas. </li> <li>Garantizar un enfoque holístico de calidad.</li></ul>|Especialista de Calidad Funcional|
| Especialistas Funcional / Técnico | <ul> <li> Análisis y diseño de casos de prueba</li><li>Ejecutar los casos de pruebas</li><li>Cargar en herramienta escenarios de prueba, casos de prueba y resultados esperados</li><li>Determinar las necesidades de datos</li><li>Detección, registro y seguimiento de los incidentes producto de la ejecución de las pruebas </li><li>Re-ejecución de casos de prueba que presentaron incidentes</li><li> Respaldar los resultados de la ejecución de las pruebas.</li></ul>|Todo el equipo|
| QA Automatizador | <ul><li> Diseñar y mantener los scripts de pruebas automatizadas de las pruebas API.</li><li> Gestionar los entornos para las pruebas automatizadas.</li><li>Validar los ciclos definidos para la automatización.</li></ul> |Especialista Técnico

## Recursos:

| Recurso               | Descripción           |
| -------------         | --------              |
|Software / Frameworks  | <ul><li>Jira framework para tracking de historias y sprints.</li><li>Xray para gestión de pruebas.</li><li>Postman para pruebas de Servicios y automatizción de las APIs.</li><li> Lambdatest simulador para pruebas móviles.</li><li>AzureDevops para integración continua.</li></ul>|
| Equipos               | <ul><li> Laptops </li><li> Equipos Móviles (Android, IOS)</li></ul>|
|Comunicaciones         | <ul><li>Teams</li><li>Skype (gestión DataPro)</li><li>Correo Outlook</li></ul>|
|Infraestructura        |<ul><li>Ambiente de pruebas DataPro</li><li> Ambiente de pruebas Pragma</li><li>Azure Devops Pipelines</li><li>Sala de reuniones</li><li>Sharepoint</li></ul>|

# ***Estrategia de Pruebas:***

La Estrategia de Pruebas describe cómo se implementará el proceso de calidad para las APIs, en términos de los tipos, niveles y técnicas de pruebas que debemos ejecutar para garantizar la calidad de nuestro producto desde el nivel Core y Capa Media.

## Niveles de Pruebas:
El plan de pruebas de APIs para el proyecto NOVA Digital (ND) debe incluir diferentes niveles de pruebas para validar cada aspecto de los servicios y aplicar técnicas de pruebas estructuradas basadas en ISTQB para diseñar casos de prueba efectivos.
<details>
<summary>Lista de Niveles y Tipos de Prueba</summary>

- ***Pruebas Unitarias:*** se debe enfocar en probar cada Enpoint de la API de forma aislada, con el propósito de validar que funcionen de manera individual correctamente a los parámetros de entrada y devuelva los valores esperados. (Estas pruebas generalmente las realiza el desarrollador para integrar los servicios) por eso forman parte del plan de prueba.
- ***Pruebas de Funcionales / Integración:*** para validar las interacciones entre los distintos servicios y/o módulos, se verifica que las APIs se comunican correctamente con las bases de datos, microservicios, etc. Se aplicará además para las pruebas que peguen a los flujos de negocio que combinen múltiples Enpoints, además de probar el comportamiento esperado de las APIs.
- ***Pruebas de Sistema:*** válidas para evaluar las APIs como un todo dentro del ecosistema de pruebas para la aplicación, validación de los requisitos funcionales y no funcionales.
- ***Pruebas de Aceptación:*** para asegurar si las APIs cumplen con los requerimientos del banco y son seguras para desplegarlas. En este nivel de pruebas se involucra el equipo de QA como soporte para los stakeholders (La validación final se hará básicamente una vez se tenga integrado el back con el front)

#### Tipos de Pruebas:
- ***Pruebas funcionales:*** Validación de respuestas esperadas según los casos de uso.
- ***Pruebas de integración:*** Asegurar que las APIs se comuniquen correctamente con otros sistemas internos y externos.
- ***Pruebas de regresión:*** Garantizar que nuevas funcionalidades o correcciones no impacten servicios existentes.
- ***Pruebas de validación de datos:*** Confirmar que la información procesada por las APIs es coherente y se refleja correctamente en las aplicaciones de usuario. (Ejemplo: Core Bancario e-iBS)

</details>

## Técnicas de Pruebas:

> **Estás técnicas serán aplicadas, únicamente cuándo se identifique en las HTs los valores de entrada y salidas esperadas, lo que llevará a la aplicación de la técnica de prueba más adecuada ara cada caso:**

1. Basadas en la Especificación:

|                             |                             |
| -------------               | -------------               |
| - Partición de Equivalencia | Técnica que podemos usar para agrupar datos de entrada en clases “Válidas” e “Inválidas” para reducir el número de casos de prueba sin perder la cobertura.|
|Análisis de Valores Límites  |Probar valores en los extremos de los rangos aceptados.|
|Tabla de Decisión            |Probar combinaciones de condiciones para verificar respuestas esperadas de cada API.        |
|Transición de Estado         | Técnica que podemos abordar si la API maneja estados, por ejemplo, Estado activo del cliente → Estado inactivo del cliente, para probar cada transición posible.|
| Caso de Uso                 | Para definir posibles escenarios de propios del banco que representen cómo se usará la API en la práctica.|

2. Basadas en la Experiencia:

|                             |                             |
| -------------               | -------------               |
| Error Guessing              |Posible técnica a utilizar, usando el conocimiento y experiencia del equipo de QA para identificar posibles errores sin seguir un caso de prueba rígido con su paso a paso.|
|Ataques a APIs               |Intentar explotar debilidades en las APIs, con manipulación de headers o llamadas no autenticadas.|

## Criterios de Entrada y Salida:

| Criterios de Entrada        | Criterios de Salida         |
| -------------               | -------------               |
| Los contratos de API documentados y actualizados, con la disposición de la especificación de entrada y salida de cada servicio (códigos de respuestas, estructuras JSON, yml, headers requeridos, etc.)| Ejecución de todos los casos de prueba dispuestos en el plan de pruebas se han completado.| 
| Ambiente configurado, validado  y disponible (QA DataPro, QA Pragma) | Los escenarios críticos o claves del negocio se han cubierto (ej.: datos inválidos, valores límites, etc.) |
| Tools necesarios para las pruebas (Postman) | Defectos críticos resueltos, sobre los servicios probados. (Re-ejecución de las pruebas como punto de foco)|
| <p> Enpoints por cada servicio DataPro disponibles <br> Métodos HTTP requeridos: <br> GET. POST, PUT, DELETE (cuando apliquen)| <p> Cumplimiento del desarrollo de las APIs  con la funcionalidad esperada según los requisitos del banco y los contratos definidos. <br> Considerando que los códigos de respuesta y mensajes de error son correctos, de acuerdo a la historias de usuario técnicas. |
| <p> Enpoints por cada servicio Capa media Pragma disponibles <br> Métodos HTTP requeridos: <br> GET. POST, PUT, DELETE (cuando apliquen)| Validación de los servicios en las pruebas de integración, de forma exitosa.|
| Datos de pruebas preparados en el entorno para cada escenario (ej: usuarios, CIF, cuentas, transacciones, etc.) |
| Reporte semanal del proceso de pruebas | Identificación de escenarios positivos y negativos para la validación de cada Enpoint. |
| Escenarios alternos serán utilizados de acuerdo a la complejidad de los Enpoints. | Reporte final de pruebas, con el resumen de las ejecuciones, bugs encontrados, y estados finales, para los stakeholders. |
| Dependencias solventadas: integraciones con terceros o sistemas internos (Core bancario, autenticación, pasarelas de pagos, entre otros) deben estar listas para la ejecución de pruebas. |

# Planificación de Pruebas

## Cronograma:


| Funcionalidades en Pruebas |

| Sprint    | Fecha Inicio    | Fecha Fin | Pragma    |
| -------   | -------         |------     | -----     |
| 1         | 19-dic-24       | 10-ene-25 |           |
| 2         | 13-ene-25       | 24-ene-25 |           |
| 3         | 27-ene-25       | 07-feb-25 |           |
| 4         | 10-feb-25       | 21-feb-25 |           |
| 5         | 24-feb-25       | 07-mar-25 |           |
| 6         | 10-mar-25       | 21-mar-25 |           |
| 7         | 24-mar-25       | 04-abr-25 |           |
| 8         | 07-abr-25       | 18-abr-25 |           |
| 9         | 21-abr-25       | 02-may-25 |           |
| 10        | 05-may-25       | 16-may-25 |           |
| 11        | 19-may-25       | 30-may-25 |           |
| 12        | 02-jun-25       | 13-jun-25 |           |

## Hitos:

Definir los hitos importantes del proyecto de pruebas.

## Matriz de Trazabilidad:

Ver Reporte de Trazabilidad (Ruta para su generación)  Traceability - MBP HelpDesk

## Gestión de Riesgos

| ID | Riesgo Identificado | Impacto | Probabilidad | Nivel de Riesgo | Plan de Mitigación |
|-------    | -------   | -------      | ------- | -------  |-------|
| R1 | Retraso en las entregas de los componentes críticos por parte de los proveedores. | ALTO | MEDIO | CRITICO | |
| R2 |Probabilidad de no tener acceso a los ambientes de pruebas | ALTO | MEDIO | CRITICO | |
| R3 | Fallos en la integración entre APIs y sistemas del e-IBS  | ALTO | ALTO | CRITICO | Realizar pruebas de integración en etapas tempranas. Simular con datos reales (Cuándo aplique)|
| R4 | Inconsistencia en los datos retornados por las APIs  | ALTO | MEDIO | ALTO | Validar estructura de las respuestas contra los contratos (Swagger, OpenAPI). Implementar pruebas automatizadas de validación de datos.|
| R5 | Probabilidad de errores de autenticación (OAuth, API Keys)  | ALTO | ALTO | CRITICO | Probar escenarios con usuarios sin permisos, autenticaciones inválidas y accesos no autorizados. Realizar pruebas de seguridad en enpoints críticos.|
| R6 | Cobertura de pruebas limitada por los tiempos de ajustados de la entrega | ALTO | BAJO |MEDIO | Incluir pruebas funcionales y de integración en un entorno similar a producción. Validar flujos completos de negocio. |
| R7 | Probabilidad de errores en el manejo de excepciones y respuestas de errores poco intuitivas.  | MEDIO | ALTO | ALTO | Diseñar casos de pruebas bien específicos, para validación de códigos de respuesta (200, 400, 401, 408, 500, etc). Si es posible revisar logs para identificar problemas ocultos.|
| R8 | Data de prueba insuficiente o no representativa | ALTO | BAJO | MEDIO | |
| R9 | Dependencia de servicios externos (APIs de terceros, pasarelas de pagos, entre otros)  | ALTO | MEDIO | ALTO | Utilizar mocks y simuladores (si es factible) cuando los servicios externos no estén disponibles. Establecer planes de contingencias |
| R10 | Identificación tardía de bugs críticos  | ALTO | MEDIO | ALTO |Implementar en el plan de pruebas un enfoque Shift Left, considerando las pruebas unitarias e integración desde inicio del proyecto. |
| R11 |Degradación del rendimiento al aumentar la carga de usuarios concurrentes  | ALTO | MEDIO | ALTO | Ejecutar pruebas de carga y estrés en enpoints críticos.  Definir umbrales de rendimiento aceptables. |
| R12 | Inestabilidad de los ambientes de prueba  | MEDIO | MEDIO | ALTO | |
| R13 | Falta de automatización en la ejecución de las pruebas  | MEDIO | BAJO | ALTO | Implementar un framework de pruebas automatizadas para evaluar continuamente las APIs en cada despliegue.|

!!! warning "Análisis de Riesgos"
- Los riesgos **CRÍTICOS** deben mitigarse antes de la ejecución de pruebas en Producción.
- Los riesgos **ALTOS** requieren un plan de acción específico dentro del plan de pruebas.
- Los riesgos **MEDIOS** pueden abordarse en fases posteriores o con monitoreo continuo.
- Los riesgos **BAJO** requieren la monitorización y gestión preventiva.

# Control de Pruebas

## Seguimiento y Control:

### Informes de Pruebas:

* Informes semanales en la Weekly del Proyecto, usando la plantilla definida en proyecto
* Reporte QA por sprint del resultado de pruebas

### Cierre de Pruebas

El cierre de pruebas de las APIs se cumplirá cuando se cumplan los siguientes criterios, asegurando que la calidad del servicio es la adecuada y que los riesgos han sido mitigados.

### Criterios de Cierre:

 
|           |           |
|------     |------     |
| Ejecución completa del Plan de Pruebas | <ul><li> Se han ejecutado el 100% de los casos de prueba planificados (válidos) para los servicios de la capa media. </li><li>Se ha validado la funcionalidad de cada API según los requerimientos definidos.</li></ul>|
|Resolución de bugs críticos y altos | <ul><li> No hay bugs críticos o bloqueantes pendientes para la salida a producción. </li><li> Los bugs de prioridad altos y medios se han corregido y validados en las pruebas de regresión. </li><li> Todo bugs de prioridad baja fue documentado para ser resuelto en futuras versiones.</li></ul>|
| Cumplimiento de los criterios de calidad |          |
| Pruebas de regresión exitosas |                     |
| Pruebas de rendimiento y estabilidad (si aplica)|   |
| Documentación y reportes finalizados |              |
| Aprobación por parte de los Stakeholders| <ul><li> El equipo de calidad ha validado que las APIs cumplen con los criterios de aceptación definidos en las HTs.</li><li> Se ha obtenido la aprobación del negocio, desarrollo y arquitectura para el pase a producción.</li></ul>
