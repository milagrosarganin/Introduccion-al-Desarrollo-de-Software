# 🗄️ Bases de Datos

## ❓ ¿Qué son y cuándo usarlas?
> Una **base de datos** es un sistema diseñado para guardar, organizar y proteger datos de forma estructurada para que luego puedan ser consultados y gestionados fácilmente.
> 
> **¿Cuándo usarlas?** Debes usarlas cuando necesitas guardar información de forma permanente, cuando el volumen de datos es grande, cuando necesitas relacionar información distinta, o cuando varios usuarios y sistemas necesitan acceder/modificar esos datos al mismo tiempo de forma segura.

## 🔄 Bases de Datos Relacionales
- Son aquellas que organizan la información en tablas (filas y columnas) y **relacionan** los datos de esas tablas entre sí mediante identificadores.

---

# 🗣️ SQL: Structured Query Language

> Es el lenguaje de consultas estructurado estándar que nos permite comunicarnos con las bases de datos relacionales.
> **Permite:** Definir estructuras, manipular datos y consultar información.

## 💻 Comandos Básicos

- **`SELECT`**: Extrae el dato o columnas que quiero ver.
- **`FROM`**: Indica de qué tabla provienen los datos.
- **`WHERE`**: Filtra los resultados según la ocasión o condición especificada.
- **`ORDER BY`**: Permite ordenar los datos de salida (`ASC` ascendente o `DESC` descendente).
- **`LIMIT`**: Te da el n° de filas que quieres ver (ej. `LIMIT 1`).

### 📝 Comandos de Modificación
- **`CREATE TABLE`**: Crea una nueva tabla.
  - *Nota sobre tipos de datos:* Si la columna almacena un número entero va `INT`, y si es texto va `VARCHAR`. Entre paréntesis de `VARCHAR(n)` se pone el n° máximo de caracteres.
- **`INSERT INTO`**: Inserta nuevos registros en una tabla. 
  - *Ejemplo:* `INSERT INTO clientes (id, nombre, apellido, ciudad) VALUES (...)`
- **`UPDATE`**: Actualiza registros ya existentes en la tabla.
- **`DELETE FROM`**: Elimina los registros de una tabla. 
  - *Ejemplo:* `DELETE FROM clientes WHERE id = 1`
  - ⚠️ **¡CUIDADO!** Si en el `DELETE` nos olvidamos el `WHERE`, se borra **TODO** el contenido de la tabla. 
  - *(Nota: No se usa el comando `DROP` para borrar datos de una tabla, `DROP` borra la estructura de la tabla completa).*

### 🔍 Ejemplo Práctico
Para ver el ID del siguiente registro:
```sql
SELECT id + 1
FROM clientes
ORDER BY id DESC
LIMIT 1;
```

---

# 🐘 Docker y PostgreSQL

### 1️⃣ El comando mágico para iniciar
Para tener Postgres corriendo, solo necesitas ejecutar esto en tu terminal:

```bash
docker run --name mi_postgres \
  -e POSTGRES_PASSWORD=mi_secreto \
  -p 5432:5432 \
  -d postgres
```

**¿Qué significa cada "pieza"?**
- `docker run`: Le dice a Docker que cree y corra un contenedor.
- `--name mi_postgres`: El nombre que tú quieras darle al contenedor para identificarlo.
- `-e POSTGRES_PASSWORD=...`: Configura una variable de entorno. Postgres obliga a que definas una contraseña para el usuario por defecto (`postgres`).
- `-p 5432:5432`: Mapea los puertos. El puerto de Postgres es el 5432. Esto conecta el puerto de tu computadora con el del contenedor.
- `-d`: (Detached) Hace que el contenedor corra en segundo plano para que puedas seguir usando la terminal.
- `postgres`: Es el nombre de la imagen oficial que Docker descargará de internet.

### 2️⃣ ¿Cómo entro a la base de datos?
Una vez que el contenedor está corriendo, tienes dos formas de entrar:

**A. Desde la terminal** (usando psql dentro del contenedor):
```bash
docker exec -it mi_postgres psql -U postgres
```

**B. Desde una herramienta visual (como DBeaver o pgAdmin):**
Solo necesitas estos datos:
- **Host**: localhost
- **Port**: 5432
- **User**: postgres
- **Password**: mi_secreto

> **💡 Tip:** Si quieres, se puede crear la tabla directamente desde DBeaver. Con el icono del "enchufe" te conectas a la base de datos (pones los datos del contenedor). Allí pruebas la conexión y puedes ejecutar los comandos para crear u operar tablas. ¡Es mucho más amigable!

### 3️⃣ ¡Cuidado con los datos! (Volúmenes)
Por defecto, si borras el contenedor de Docker, tus tablas y datos desaparecen. Para que los datos sean permanentes, usamos un Volumen:

```bash
docker run --name mi_postgres \
  -v mi_data_postgres:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=mi_secreto \
  -p 5432:5432 \
  -d postgres
```
El parámetro `-v` crea una carpeta persistente en tu PC que sobrevive aunque apagues o borres el contenedor.

### 🛠️ Comandos de Docker útiles para Postgres:
- `docker ps`: Mira si tu base de datos está encendida.
- `docker stop mi_postgres`: Apaga la base de datos.
- `docker start mi_postgres`: La vuelve a encender sin perder lo que tenías.
- `docker logs mi_postgres`: Por si algo falla, aquí ves los errores.

### 🐳 Docker Compose
- `docker-compose up -d`: Comando para que corra el contenedor por detrás. El `-d` es la clave: levanta el contenedor y te devuelve el control de la terminal inmediatamente.

---

# 🔑 Estructura de Tablas y Relaciones

> **Valor Default:** El `DEFAULT` es el valor o número que se pone por defecto en una columna si al insertar un registro no le especificamos uno.

## 🗝️ Tipos de Claves (Keys)
- **Clave Primaria (Primary Key - PK):** Identifica de manera **única e irrepetible** cada registro (fila) de una tabla. Suele ser un ID autoincremental (ej. 1, 2, 3), un DNI, etc.
- **Clave Foránea (Foreign Key - FK):** Es un campo en una tabla que hace referencia a la Clave Primaria de **otra tabla**. Permiten vincular y relacionar ambas tablas de forma segura.

## 🔗 Tipos de Relaciones entre tablas

### 1️⃣ Relación 1:1 (Uno a Uno)
- No importa en qué tabla se guarde el ID foráneo, siempre y cuando esté en alguna de las dos.

### 2️⃣ Relación 1:N (Uno a Muchos)
- **Regla de oro:** Tiene que estar el ID de la tabla que tiene "uno" como Clave Foránea dentro de la tabla del que tiene "muchos".
- **Ejemplo:** Tabla de `hinchas` y `equipos`. Un hincha puede tener un equipo, pero un equipo puede tener muchos hinchas. Entonces, el `id_equipo` habría que ponerlo en la tabla de `hinchas`.

### 3️⃣ Relación N:M (Muchos a Muchos)
- **Regla de oro:** Hay que hacer una **tabla intermedia** con *Foreign Keys* que referencien a ambas tablas.
- **Ejemplo:** `personas` y `animales`.
  - Una persona puede tener muchas mascotas.
  - Pero también una mascota puede tener muchos dueños (es una mascota familiar).
  - **Solución:** Se crea una tabla intermedia (ej. `personas_mascotas`).
  - Si la persona con `id=2` tiene a las mascotas con `id=3` y `id=4`, entonces en la tabla intermedia se guarda:
    - Una fila donde el `id` 2 de persona va con el 3 de mascota.
    - Y en otra fila el `id` 2 de persona va con el 4 de mascota.


#### Además de DBeaaver se puede usar draw.io o dbdiagram(para ver los flujos mejor)