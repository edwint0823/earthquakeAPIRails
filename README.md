# Challenge FROGMI

Proyecto sobre prueba de codificación para el cargo Software Development Engineer en FROGMI por Edwin Tobias Ariza Tellez


## Prerrequisitos
Para un correcto funcionamiento debe contar con las siguientes tecnologías instaladas en su equipo

| Herramienta   | Versión            | link de descarga o comando                                 |
|:--------------|:-------------------|:-----------------------------------------------------------|
| Base de datos | **PostgreSQL 15+** | [PostgreSQL](https://www.postgresql.org/download/windows/) |
| Ruby          | **Ruby 3.0+**      | [Ruby](https://rubyinstaller.org/downloads/)               | 
| Gem           | **gem 3.4+**       | Dentro de instalador de Ruby                               |
| Rails         | **Rails 7.1+**     | `gem install rails `                                       |

**NOTA:**

Además de las anteriores tecnologías también debe poseer las credenciales de administrador para la base de datos asi como la base de datos creada con el nombre **earth_quake_api_development** para el entorno de desarrollo

## Variables de entorno
Para el correcto funcionamiento de la aplicación debe agregar las variables de entorno en el archivo **.env**

| Variable      | Descripción                                | Valor sugerido |
|:--------------|:-------------------------------------------|:---------------|
| `PG_USERNAME` | NUsuario de la base de datos               | postgres       |
| `PG_PASSWORD` | Contraseña del usuario de la base de datos |                |

**NOTA:**

Estas variables también las puede encontrar en el archivo **.example-env**
## Instalación y puesta en marcha

Para el correcto funcionamiento del proyecto debe seguir lo siguientes pasos

Instalar dependencias

```bash
bundle install
```

Correr migraciones

```bash
rails db:migrate 
```

Correr Task para poblar tabla de features

```bash
rails api:fetch_data
```

Iniciar servidor

```bash
rails server -b 127.0.0.1 -p 3030 -e development
```
## Autores

- [@edwint0823](https://github.com/edwint0823)