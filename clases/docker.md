# 🐳 Docker

## ❓ ¿Qué es?
> Es un contenedor que engloba todo lo que necesitamos para correr una app en cualquier compu. Instala/guarda todas las dependencias en un contenedor y, al correr eso, solucionamos el problema de *"solo anda en mi computadora"*.

---

##  Conceptos Fundamentales

### 🖥️ Host
**Es tu compu o el servidor donde estás trabajando.**
- El host es donde está el SO y ahí se instala Docker.

### ⚙️ Servicio
**Programa/app que está corriendo.**

### 📦 Contenedores vs Virtualización
- Antes se usaban VMs para aislar apps, eso pesaba varios GB y hacía más lenta la PC.
- Con Docker **no** se instala un SO completo, porque comparte núcleo con el SO del host. Están diseñados para crearse y destruirse fácilmente.

### 💡 Notas Clave
- *Docker recibe indicaciones por medio de la terminal.*
- *Docker une contenedores por sus nombres a través de redes virtuales en vez de hacerlo con IPs complicadas.*

---

## 🖼️ Imágenes y Dockerfile (La Receta)

### 🖼️ Imágenes
- Un archivo de **solo lectura**.
- Contiene el SO, el código y las librerías.
- <span class="important">NO</span> se puede modificar.
- Si se quiere cambiar algo, se crea una nueva.

### 📄 Dockerfile
> Es la **"receta"** para crear la imagen. Un Dockerfile es simplemente un archivo de texto con instrucciones secuenciales.

#### 📜 Instrucciones Vitales del Dockerfile
- **`FROM`**: Es la imagen base sobre la que se construye, usualmente un SO (ej. `ubuntu:latest`).
- **`WORKDIR` (El Escritorio)**: Establece el directorio de trabajo interno del contenedor. Es como hacer `cd`. Todo lo que hagas después (copiar, ejecutar) sucederá en esa carpeta.
  - *Ejemplo: `WORKDIR /app`*
- **`COPY` (La Transferencia)**: Toma archivos de tu computadora (Host) y los pega dentro del contenedor.
  - *Ejemplo: `COPY . .` (Copia todo desde tu carpeta actual a la carpeta de trabajo del contenedor).*
- **`ADD`**: Similar a `COPY`, pero con más funcionalidades como descomprimir archivos `.tar` automáticamente. Generalmente se prefiere `COPY` por ser más explícito.
- **`RUN` (El Constructor)**: Ejecuta comandos de consola **mientras la imagen se está construyendo**. Se usa para instalar dependencias.
  - *Ejemplo: `RUN apt-get update && apt-get install -y python`*
- **`ENV` (Las Variables)**: Define variables de entorno que estarán disponibles cuando el contenedor esté vivo. Útil para pasar configuraciones sin escribirlas en el código.
  - *Ejemplo: `ENV PORT=8080`*
- **`CMD` (El Botón de Encendido)**: Es el comando por defecto que se va a ejecutar **cuando el contenedor arranque** (no cuando se construya).
  - *Ejemplo: `CMD ["python", "app.py"]`*

### 📝 Ejemplo Práctico de Creación

Los Dockerfile siempre empiezan con `FROM` y casi siempre terminan con `CMD`.

1.  **Crear el `Dockerfile`**:
    ```dockerfile
    # Empezá con un sistema Ubuntu básico
    FROM ubuntu:24.04
    
    # Cuando el contenedor arranque, ejecutá la terminal de linux
    CMD ["bash"]
    ```

2.  **🏗️ Construir la Imagen (Empaquetar los ingredientes)**
    Primero, le dices a Docker que lea tu archivo y cree la Imagen. Para eso usas el comando: `docker build -t mi-ubuntu-personalizado .`
    - `build`: Le dice a Docker que construya algo.
    - `-t mi-ubuntu-personalizado`: Le pone una "etiqueta" (nombre) a tu imagen para que la encuentres fácil.
    - `.` (el punto al final): Es súper importante. Le dice a Docker "busca el Dockerfile en esta carpeta actual".

3.  **🚀 Ejecutar el Contenedor (Servir el plato)**
    Ahora que tienes la Imagen, vas a crear un contenedor vivo a partir de ella con el comando: `docker run -it mi-ubuntu-personalizado`
    - `run`: Ejecuta un contenedor.
    - `-it`: Mantiene la terminal abierta e interactiva (necesario porque en tu Dockerfile pusimos que ejecute `bash`).

¡Y listo! Tu terminal cambiará y estarás "dentro" de un mini-sistema operativo Ubuntu.

---

## 💻 Comandos de la Terminal

### 🛠️ Manejo de Imágenes *(Las Plantillas)*
- `docker images`: Lista todas las imágenes que tienes descargadas en tu máquina.
- `docker pull <nombre_imagen>`: Descarga una imagen de internet sin ejecutarla *(ej. `docker pull ubuntu`)*.
- `docker rmi <id_imagen>`: Borra una imagen de tu computadora para liberar espacio.
- `docker build -t <nombre> .`: Construye una imagen propia a partir de un archivo `Dockerfile` en la carpeta actual.

### 📦 Manejo de Contenedores *(Las Cajas en ejecución)*
- `docker ps`: Lista los contenedores que están corriendo en este momento.
- `docker ps -a`: Lista todos los contenedores (los que están corriendo y los que están apagados/detenidos).
- `docker run <nombre_imagen>`: Crea y arranca un contenedor a partir de una imagen.
- `docker run -d <nombre_imagen>`: La `-d` *(detached)* hace que corra en segundo plano para que puedas seguir usando tu terminal.
- `docker stop <id_contenedor>`: Detiene un contenedor que está corriendo (lo apaga de forma segura).
- `docker start <id_contenedor>`: Vuelve a prender un contenedor que estaba detenido.
- `docker rm <id_contenedor>`: Borra un contenedor (tiene que estar detenido primero). **Ojo:** Esto no borra la imagen original.

### 🔍 Diagnóstico y Control
- `docker logs <id_contenedor>`: Te muestra qué está pasando dentro del contenedor *(útil si tu app tira un error y quieres leerlo)*.
- `docker exec -it <id_contenedor> /bin/bash`: "Te mete" dentro del contenedor. Es como abrir una terminal directamente adentro de esa caja para revisar archivos.

---

## 🔌 Puertos y Redes

- Un **puerto** es un punto lógico de comunicación. No se puede tener dos procesos en un mismo puerto del mismo host/contenedor.
- Docker aísla la red de los contenedores. Son como departamentos en un edificio (el host).

### 🔗 Mapeo de Puertos
Para que podamos ver una app web desde nuestra computadora, tenemos que hacer un **Mapeo de Puertos**: conectar un puerto de tu computadora (Host) a un puerto del contenedor.

- Para hacer esto, le agregamos el flag `-p` al comando `run`: `docker run -d -p 8080:80 mi-app-web`

#### ¿Qué significa `8080:80`?
- **El de la izquierda (8080)**: Es el puerto de tu computadora. Puedes elegir casi cualquier número libre.
- **El de la derecha (80)**: Es el puerto interno del contenedor donde la aplicación está escuchando (Nginx, por defecto, usa el 80).

Al ejecutar ese comando, puedes abrir el navegador en `localhost:8080` y verás tu página.

---

## 💾 Volúmenes y Persistencia de Datos

> En Docker los contenedores son **efímeros** (se pueden crear y destruir fácilmente). Si borramos un contenedor, se pierde toda la info que contenía. Para guardar datos importantes de forma permanente, usamos **Volúmenes** o **Bind Mounts**.

### 🗄️ Volúmenes Gestionados por Docker
- Son espacios de almacenamiento que Docker crea y administra de forma 100% aislada dentro de una parte protegida de tu sistema.
- **¿Cuándo usarlos?** Casi exclusivamente para Bases de Datos (como MySQL) o archivos críticos que genera la aplicación.
- **¿Por qué?** Porque no necesitas ver los archivos internos de la base de datos. Solo te interesa que estén seguros, que no se borren por accidente y que Docker los maneje de la forma más rápida y segura posible.

### 🔗 Bind Mounts (El Portal Mágico)
Un "Bind Mount" es un puente directo que conecta una carpeta específica de tu computadora con una ruta dentro del contenedor.

#### 🔄 ¿Cómo funciona la bidireccionalidad?
- No es una copia, es un **espejo en tiempo real**.
- Si modificas un archivo `index.html` en tu editor de código, el contenedor ve ese cambio al instante.
- Si un proceso dentro del contenedor crea un archivo nuevo en esa carpeta, el archivo aparecerá mágicamente en tu computadora.
- Tu computadora (el Host) **SIEMPRE** manda y tiene la prioridad. Si tu carpeta local y la imagen del contenedor tienen un archivo con el mismo nombre en la misma ruta, el tuyo "tapa" o "eclipsa" al del contenedor.

### 🏗️ ¿Cómo aplicar esto en la arquitectura de un proyecto?
- **Para el Frontend (HTML/CSS/JS): ¡Usa Bind Mounts!** Te permite desarrollar en vivo. Escribes código, guardas, recargas el navegador y ves los cambios al instante sin tener que reconstruir la imagen (`docker build`) cada vez.
- **Para la Base de Datos (SQL): ¡Usa Volúmenes Gestionados!** Garantizas que los registros de tu base de datos sobrevivan de forma segura sin importar cuántas veces apagues o destruyas el contenedor.

---

## 🐙 Docker Compose

- Es una herramienta que te permite definir, configurar y ejecutar múltiples contenedores (servicios) como si fueran una sola aplicación unificada.
- Es ideal para arquitecturas que requieren varios servicios interconectados (ej. una web y su base de datos).
- Todo esto se orquesta desde un único archivo llamado `docker-compose.yml`.

### 📄 ¿Qué es YAML (`.yml`)?
- Es un formato de archivo muy sencillo para configuraciones. Depende de la indentación (los espacios) para organizar la información, similar a Python.

### ⚙️ Ejemplo de `docker-compose.yml`
En la carpeta de tu proyecto, crearías un archivo `docker-compose.yml`:

```yaml
version: '3.8' # La versión del formato de Compose

services: # Aquí listamos todos nuestros contenedores
  # SERVICIO 1: Tu página web
  mi-pagina-web:
    build: . # Le dice a Compose: "Construye el Dockerfile que está en esta carpeta"
    ports:
      - "8080:80" # Mapeamos el puerto como te expliqué arriba
    volumes:
      # Esto es un BIND MOUNT para desarrollo en vivo
      - ./mi-codigo-web:/usr/share/nginx/html

  # SERVICIO 2: Tu base de datos SQL
  mi-base-de-datos:
    image: mysql:8.0 # En lugar de construir, le decimos que descargue la imagen oficial
    environment: # Las variables secretas para que arranque la base
      - MYSQL_ROOT_PASSWORD=mi_clave_secreta
      - MYSQL_DATABASE=proyecto_final
    volumes:
      # Esto es un VOLUMEN GESTIONADO para persistir los datos
      - datos-sql:/var/lib/mysql

volumes:
  # Aquí se declara formalmente el volumen gestionado por Docker
  datos-sql:
```

Con este archivo, te olvidas de comandos largos. Simplemente ejecutas:
- `docker-compose up`: Lee el archivo, construye, descarga y levanta todo.
- `docker-compose down`: Apaga y elimina los contenedores.

---

### 🤔 ¿Cuándo y para qué uso Docker realmente?

Docker brilla en situaciones donde necesitas **aislamiento, portabilidad y reproducibilidad**.

- **Para matar el "en mi máquina sí funciona"**: Empaquetas tu app con su propio entorno. Si el contenedor funciona en tu PC, funcionará exactamente igual en cualquier otro lado.
- **Para no ensuciar tu computadora**: ¿Quieres probar una nueva base de datos o una versión antigua de Python? Levantas un contenedor. Cuando terminas, lo borras y tu PC queda impecable.
- **Para trabajar en equipo**: Un desarrollador nuevo solo necesita ejecutar `docker-compose up` y en minutos tiene todo el entorno de trabajo listo, sin pasar días instalando y configurando.