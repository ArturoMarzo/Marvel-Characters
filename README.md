# Marvel-Characters

## Arquitectura
El proyecto es sencillo y se podría haber empleado una arquitectura clean más sencilla como un MVP. Sin embargo, me he decantado por una arquitectura VIPER porque es en la que llevo desarrollando los últimos 2 años y quería mostrar que puedo dominar arquitecturas más complejas.

### Infrastructure
Contiene clases encargadas de la funcionalidad básica de la app como las peticiones a red, inyección de dependencias, configuración de endpoints...

#### Container
- `Container.swift`:
Se puede emplear para inicializar la `UIWindow` para situaciones diferentes. Como que la app se encuentre logada o no. 
- `Container+Builders.swift`:
Inyector de dependencias que proporciona los constructores que generarán las diferentes vistas.
- `RepositoriesContainer.swift`:
Inyector de dependencias que proporciona los repositorios. En este caso solamente uno dada la simplicidad del proyecto.

#### Network
Dispone de una serie de clases encargadas de hacer las peticiones de red y configurar los endpoints para diferentes entornos en base al fichero `Configuration.plist`.

#### Utils
Una colección de extensiones y un fichero `Utils.swift` para reunir diferentes funciones genéricas útiles.

### Repository
Aquí se reune la funcionalidad encargada del tratamiento de los datos. Dispone de una clase `CharacterRepository` que se encarga de gestionar las peticiones de red y el parseo de los datos de los personajes Marvel empleando la librería del sistema `JSONDecoder`. En caso de que se realizase persistencia de datos igualmente se encargaría de gestionar esta funcionalidad.

En la carpeta _Model_ se encuentran las clases para la gestión de los datos. La información procedente del servidor se parsea en objetos _Entity_ de tipo `Codable` a fin de poderse emplear para el parseo. Posteriormente estos datos son convertidos a estructuras que se emplean para la distribución de la información a lo largo de la app.

El empleo de estructuras en lugar de clases para almacenar los datos previene el problema la mutabilidad de los datos. 

### Presentation
En este carpeta se reunen las clases encargadas de los diferentes casos de uso de las vistas.

#### Modules
Dado que hay 2 vistas en la app existen 2 carpetas:
- `CharactersList`:
Para mostrar el listado de personajes
- `CharacterDetail:`
Para mostrar el detalle de un personaje

Los modulos generan vistas empleando la arquitectura VIPER.

https://medium.com/build-and-run/clean-architecture-en-ios-viper-893c8c3a75a4

La definición de protocolos en las clases `Contract` facilita posteriormente la escritura de tests para cualquier capa. Los datos que se proporcionan a la capa de la vista no siguen la estructura empleada para su transporte a lo largo de la app. En su lugar hay unas clases `ViewModelBuilder` que se encargan de generar una estructura de datos adecuada para su presentación por la vista.

La capa de la vista debe de ser lo más _sencilla_ posible. De forma que no tenga conocimiento de la lógica de negocio y se limite a comunicar a la capa presenter las acciones realizadas por el usuario. Sin indicar a esta las acciones que debe de realizar ya que no forma parte de sus competencias.

La capa del interactor se encarga de suministrar los datos a la capa presenter. Finalmente la capa router es la responsable de la navegación por la app siguiendo las directrices de la capa presenter. 

#### Common
En esta carpeta se reunen componentes visuales reutilizables como una celda para cargar más datos en el listado. Además se incluyen como clases base para heredar funcionalidades a partir de ellas.

#### Resources
Directorio con ficheros básicos como el repositorio de imágenes o el fichero de cadenas localizadas.

## Tests
Aunque se pretendía cubrir con tests toda la capa presenter por falta de tiempo únicamente se ha testeado `CharactersListPresenter`.

Se emplea una clase `CharacterProvider` para proporcionar datos con los que alimentar a la capa presenter y al `ViewModelBuilder`.

Se crean versiones _dummy_ de las capas vista, router, interactor, etc. mediante la adopción de los protocolos definidos en los contratos para testear el correcto comportamiento de la capa presenter.

## Cocoapods
Se han empleado Cocoapods para instalar librerías sencillas que falicitasen el desarrollo de la app. Una para mostrar una ventana de carga y otra simplificar la descarga y persistencia temporal de las imágenes procedentes de la red.
