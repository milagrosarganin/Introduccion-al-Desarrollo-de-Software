# 🐳 Docker

## ¿Qué es?
   Es un contenedor que engloba todo lo que necesitamos para correr una app en cualqueir compu, instala/guarda todos las dependencias en un contenedor y cion correr eso solucionames el problema "solo anda en mi computadora"
## ❓ ¿Qué es?
> Es un contenedor que engloba todo lo que necesitamos para correr una app en cualquier compu. Instala/guarda todas las dependencias en un contenedor y, al correr eso, solucionamos el problema de *"solo anda en mi computadora"*.

--------------------------------------------------------------------------------------------------------------------------------------------------------
---

## Host: es tu comu o el servidor donde estas trabajando
## 🖥️ Host: 
**Es tu compu o el servidor donde estás trabajando.**
- El host es donde está el SO y ahí se instala Docker.

- El host es donde esta el SO y ahí se intala docker
---

--------------------------------------------------------------------------------------------------------------------------------------------------------
## 🔌 Puertos: 
**Es un punto lógico de comunicación.**
- No se puede tener dos procesos en un mismo puerto.
- Docker aísla la red.
- Son los departamentos de un edificio, donde el edificio es el host.

## Puertos: es un punto lógivco de comunicación
---

- no se puede tener dos processo en un mismo puerto
- Docker aisla la red
- Son los departartamentos de un edificio, donde el edificio es el host
## ⚙️ Servicio: 
**Programa/app que está corriendo.**

--------------------------------------------------------------------------------------------------------------------------------------------------------
---

## Servicio: programa/app que etsá corriendo
## 📦 Contenedores vs Virtualización:
- Antes se usaban VMs para aislar apps, eso pesaba varios GB y hacía más lenta la PC.
- Con Docker **no** se instala un SO completo, porque comparte núcleo con el SO del host. Están diseñados para crearse y destruirse fácilmente.

--------------------------------------------------------------------------------------------------------------------------------------------------------
---

## Contenedorees vs Virtualización:
## 🖼️ Imágenes: 
- Un archivo de **solo lectura**.
- Contiene el SO, el código y las librerías.
- <span class="important">NO</span> se puede modificar.
- Si se quiere cambiar algo, se crea una nueva.

- Antes se usaban VMs para aislar apps, eso pesaba varias GB y hacia más lenta la PC
- Con docker no se instala un SO completo, porque comparte núcleo con el SO del host, están diseñados para crearse y destruirse facilmente«
### 🧩 Partes de una imagen:
- `FROM`: es el SO.
- `WORKDIR`: directorio de trabajo.
- `USER`: usuario que lo ejecuta.
- `COPY`: copia un directorio de mi local en el contenedor.
- `ADD`: va el archivo que quiero copiar.
- `RUN`: ejecuta el comando.

--------------------------------------------------------------------------------------------------------------------------------------------------------
---

## Imagenes: 
## 💾 Volúmenes:
> En Docker los contenedores son **efímeros**, entonces hay que guardar los datos (volúmenes) directamente en el host porque si borramos el contenedor, se pierde toda la info del mismo.

- Un archivo de solo lectura
- Contiene el SO, el código y las librerías
- NO se puede modificar
- Si se queire cambiar algo, se crea una nueva
---

### Partes de una imagen:
*FROM*: es el SO
#### 💡 Notas Clave:
- *Docker recibe indicaciones por medio de la terminal.*
- *Docker une contenedores por sus nombres a través de redes virtuales en vez de hacerlo con IPs complicadas.*

*WORKDIR*:
---

*USER*:
## 📄 Dockerfile:
> Es la **"receta"** para crear la imagen.

*COPY*: copia un directorio de mi local en el contenedor
**Ejemplo:**
```dockerfile
FROM ubuntu:latest         # Empezá con un sistema Ubuntu básico
RUN apt-get install python # Instalale Python
COPY . /app                # Copiá el código de mi compu a la carpeta /app del contenedor
CMD ["python", "app.py"]   # Cuando el contenedor arranque, ejecutá este comando
```

*ADD*: va el archivo que quiero copiar
---

*RUN*: ejecuta el comando
## 💻 Comandos:

### 🛠️ Manejo de Imágenes *(Las Plantillas)*
- `docker images`: Lista todas las imágenes que tienes descargadas en tu máquina.
- `docker pull <nombre_imagen>`: Descarga una imagen de internet sin ejecutarla *(ej. `docker pull ubuntu`)*.
- `docker rmi <id_imagen>`: Borra una imagen de tu computadora para liberar espacio.
- `docker build -t <nombre> .`: Construye una imagen propia a partir de un archivo `Dockerfile` en la carpeta actual.

--------------------------------------------------------------------------------------------------------------------------------------------------------
### 📦 Manejo de Contenedores *(Las Cajas en ejecución)*
- `docker ps`: Lista los contenedores que están corriendo en este momento.
- `docker ps -a`: Lista todos los contenedores (los que están corriendo y los que están apagados/detenidos).
- `docker run -p 8080:80 <nombre_imagen>`: Crea un contenedor, mapea el puerto 8080 de tu compu al 80 del contenedor, y lo arranca.
- `docker run -d -p 8080:80 <nombre_imagen>`: Igual que el anterior, pero la `-d` *(detached)* hace que corra en segundo plano para que puedas seguir usando tu terminal.
- `docker stop <id_contenedor>`: Detiene un contenedor que está corriendo (lo apaga de forma segura).
- `docker start <id_contenedor>`: Vuelve a prender un contenedor que estaba detenido.
- `docker rm <id_contenedor>`: Borra un contenedor (tiene que estar detenido primero). **Ojo:** Esto no borra la imagen original, solo el contenedor.

--------------------------------------------------------------------------------------------------------------------------------------------------------
### 🔍 Diagnóstico y Control
- `docker logs <id_contenedor>`: Te muestra qué está pasando dentro del contenedor *(útil si tu app tira un error y quieres leerlo)*.
- `docker exec -it <id_contenedor> /bin/bash`: "Te mete" dentro del contenedor. Es como abrir una terminal directamente adentro de esa caja para revisar archivos o configuraciones internas.

## Volumenes:

En docker los contenedores son efímeros, entonces hay que guardar los contenedores directamente en el host porque si borramos el contenedor, se pierde toda la info del mismo

--------------------------------------------------------------------------------------------------------------------------------------------------------

#### Docker recibe indicaciones por medio de la terminal
#### Docker uné contenedores por sus nombres a traves de redes virtuakes en vez de hacerlo con IPs complicadas

--------------------------------------------------------------------------------------------------------------------------------------------------------

### Ejemplo de docker file

Los docker file siempre empiezan con FROM y casi siemore terminan con CMD
Creo un archivo en vsc llamado Dockerfile
   FROM: ubuntu: 24.04

   CMD ["bash"]

En la termiinal van los comandos:

1. Construir la Imagen (Empaquetar los ingredientes)
   
   Primero, le dices a Docker que lea tu archivo y cree la Imagen. 
   Para eso usas el comando *docker build -t mi-ubuntu-personalizado .*
   
   - build: Le dice a Docker que construya algo.
   - -t mi-ubuntu-personalizado: Le pone una "etiqueta" (nombre) a tu imagen para que la encuentres fácil.. 
   - (el punto al final): Es súper importante. Le dice a Docker "busca el Dockerfile en esta carpeta actual".
   
   Al hacer esto, Docker descargará Ubuntu y lo guardará estáticamente en tu computadora.
   
2. Ejecutar el Contenedor (Servir el plato)
      
   Ahora que tienes la Imagen, vas a crear un contenedor vivo a partir de ella, con el comando *docker run -it mi-ubuntu-personalizado*

   - run: Ejecuta un contenedor.
   - -it: Mantiene la terminal abierta e interactiva (necesario porque en tu Dockerfile pusimos que ejecute bash, que es la línea de comandos de Linux).
   
   ¡Y listo! 
   De repente, tu terminal cambiará y estarás "dentro" de un mini-sistema operativo Ubuntu corriendo de forma aislada dentro de tu computadora.
   
   #### ¿Cuándo y para qué uso Docker realmente?
   
      Docker brilla en situaciones donde necesitas aislamiento, portabilidad y reproducibilidad. Aquí tienes los casos de uso más comunes en el día a día de un desarrollador:
      - Para matar el "en mi máquina sí funciona": Imagina que haces una app en Windows, pero tu cliente usa servidores con Linux. Con Docker, empaquetas tu app con su propio entorno. Si el contenedor funciona en tu PC, te garantiza que funcionará exactamente igual en el servidor del cliente.
      - Para no ensuciar tu computadora: Supongamos que quieres probar una nueva base de datos (como PostgreSQL o MongoDB) o una versión antigua de Python. En lugar de instalar todo eso en tu PC, descargar librerías y arriesgarte a que algo se rompa, simplemente levantas un contenedor. Cuando terminas de jugar, borras el contenedor y tu computadora queda impecable.
      - Para trabajar en equipo: Si entra un desarrollador nuevo a tu equipo, no tiene que pasar 3 días instalando Node.js, configurando variables o instalando bases de datos. Solo le pasas el repositorio, él ejecuta docker-compose up (un comando que levanta múltiples contenedores a la vez) y en 5 minutos tiene todo el entorno de trabajo listo.


### Comandos vitales en docker

- Un Dockerfile es simplemente un archivo de texto con instrucciones secuenciales. Aquí tienes los comandos más vitales que vas a usar:

   - WORKDIR (El Escritorio): Establece el directorio de trabajo interno del contenedor. Es el equivalente a hacer un cd dentro de la terminal de Linux. Todo lo que hagas después (copiar, ejecutar) sucederá en esa carpeta.
      Ejemplo: WORKDIR /usr/share/nginx/html
   - COPY (La Transferencia): Toma archivos de tu computadora (Host) y los pega dentro del contenedor.
      Ejemplo: COPY . . (Copia todo desde tu carpeta actual a la carpeta de trabajo del contenedor).
   - RUN (El Constructor): Ejecuta comandos de consola mientras la imagen se está construyendo. Se usa para instalar dependencias.
      Ejemplo: RUN apt-get update && apt-get install curl
   - ENV (Las Variables): Define variables de entorno que estarán disponibles cuando el contenedor esté vivo. Útil para pasar contraseñas o configuraciones sin escribirlas en el código.
      Ejemplo: ENV PORT=8080
   - CMD (El Botón de Encendido): Es el comando por defecto que se va a ejecutar cuando el contenedor arranque (no cuando se construya)