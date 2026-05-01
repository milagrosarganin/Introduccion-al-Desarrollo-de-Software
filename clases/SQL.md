¡Me parece una idea genial! Tu apunte original ya tenía una estructura espectacular y muy fácil de leer. Lo que hice fue tomar tu base exacta, respetar tu estilo de emojis, negritas y bloques de citas, y le **inyecté toda la teoría faltante**: ejemplos en código SQL para cada relación, los JOINS, las funciones de agregación y el orden de los comandos.
Aquí tienes tu **Súper Guía de Estudio Definitiva**, lista para copiar y pegar en tu documento final:
```markdown
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

## 💻 Comandos Básicos (Orden Sagrado)
⚠️ *Si alteras el orden de estas cláusulas en una consulta, Postgres te dará error.*

1. **`SELECT`**: Extrae el dato o columnas que quiero ver.
2. **`FROM`**: Indica de qué tabla provienen los datos.
3. **`JOIN`**: Une tablas relacionadas.
4. **`WHERE`**: Filtra los resultados según la ocasión o condición especificada (registro por registro).
5. **`GROUP BY`**: Agrupa filas para usar funciones matemáticas.
6. **`HAVING`**: Filtra resultados *después* de agrupar.
7. **`ORDER BY`**: Permite ordenar los datos de salida (`ASC` ascendente o `DESC` descendente).
8. **`LIMIT`**: Te da el n° de filas que quieres ver (ej. `LIMIT 1`). Es el "freno de mano".

### 📝 Comandos de Modificación
- **`CREATE TABLE`**: Crea una nueva tabla.
  - *Nota sobre tipos de datos:* Enteros -> `INT`, Decimales -> `FLOAT`, Texto -> `VARCHAR(n)` o `TEXT`.
- **`INSERT INTO`**: Inserta nuevos registros en una tabla. 
  - *Ejemplo:* `INSERT INTO clientes (id, nombre, apellido) VALUES (1, 'Mili', 'Pérez');`
- **`UPDATE`**: Actualiza registros ya existentes en la tabla.
- **`DELETE FROM`**: Elimina los registros de una tabla. 
  - *Ejemplo:* `DELETE FROM clientes WHERE id = 1;`
  - ⚠️ **¡CUIDADO!** Si en el `DELETE` nos olvidamos el `WHERE`, se borra **TODO** el contenido de la tabla. 
  - *(Nota: No se usa `DROP` para borrar datos de una tabla, `DROP TABLE` borra la estructura de la tabla completa y para siempre).*

### 🔍 Ejemplo Práctico
Para ver el ID del siguiente registro:
```sql
SELECT id + 1
FROM clientes
ORDER BY id DESC
LIMIT 1;

```
# 🐘 Docker y PostgreSQL
### 1️⃣ El comando mágico para iniciar
Para tener Postgres corriendo sin archivo compose, ejecutas esto en tu terminal:
```bash
docker run --name mi_postgres \
  -e POSTGRES_PASSWORD=mi_secreto \
  -p 5432:5432 \
  -d postgres

```
**¿Qué significa cada "pieza"?**
 * docker run: Crea y corre un contenedor.
 * --name mi_postgres: El nombre que tú quieras darle.
 * -e POSTGRES_PASSWORD=...: Configura una variable de entorno (Postgres obliga a tener contraseña).
 * -p 5432:5432: Mapea los puertos (Tu PC : Contenedor).
 * -d: (Detached) Corre en segundo plano para que sigas usando la terminal.
 * postgres: La imagen oficial de internet.
### 2️⃣ ¿Cómo entro a la base de datos?
**A. Desde la terminal** (dentro del contenedor):
```bash
docker exec -it mi_postgres psql -U postgres

```
**B. Desde DBeaver:**
 * **Host**: localhost | **Port**: 5432 | **User**: postgres | **Password**: mi_secreto
> **💡 Tip:** Con el icono del "enchufe" te conectas. Allí pruebas la conexión y operas visualmente. Además de DBeaver, se puede usar **draw.io** o **dbdiagram.io** para diseñar y ver los flujos de las tablas mejor.
> 
### 3️⃣ ¡Cuidado con los datos! (Volúmenes)
Por defecto, si borras el contenedor, tus tablas desaparecen. Usamos un Volumen para persistencia:
```bash
docker run --name mi_postgres \
  -v mi_data_postgres:/var/lib/postgresql/data \
  ...

```
El parámetro -v crea una carpeta persistente en tu PC.
### 🐳 Docker Compose
Si usas un archivo docker-compose.yml:
 * docker compose up -d: Levanta la infraestructura en segundo plano.
 * docker compose down: Apaga y elimina el contenedor.
# 🔑 Estructura de Tablas y Relaciones
> **Valor Default:** El DEFAULT es el valor que se pone por defecto si no le especificamos uno (ej. fecha DATE DEFAULT CURRENT_DATE).
> 
## 🗝️ Tipos de Claves (Keys)
 * **Clave Primaria (Primary Key - PK):** Identifica de manera **única e irrepetible** cada registro. Suele ser autoincremental (SERIAL PRIMARY KEY).
 * **Clave Foránea (Foreign Key - FK):** Campo que hace referencia a la PK de **otra tabla**. Vincula y protege la relación (Integridad Referencial).
## 🔗 Tipos de Relaciones (Con Ejemplos SQL)
### 1️⃣ Relación 1:1 (Uno a Uno)
 * No importa en qué tabla se guarde la FK. Para garantizar que nadie más la use, a la FK se le pone la restricción UNIQUE.
```sql
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE tarjetas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20),
    empleado_id INT UNIQUE, -- Garantiza el 1:1
    CONSTRAINT fk_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

```
### 2️⃣ Relación 1:N (Uno a Muchos)
 * **Regla de oro:** El ID del que tiene "uno" va como Clave Foránea dentro de la tabla del que tiene "muchos".
 * **Ejemplo:** Un hincha puede tener un equipo, pero un equipo tiene muchos hinchas.
```sql
CREATE TABLE equipos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE hinchas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    equipo_id INT, -- Apunta a la tabla "Uno"
    CONSTRAINT fk_equipo FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

```
### 3️⃣ Relación N:M (Muchos a Muchos)
 * **Regla de oro:** Hay que hacer una **tabla intermedia** con *Foreign Keys* que referencien a ambas tablas maestras.
 * **Ejemplo:** personas y mascotas.
```sql
CREATE TABLE personas (id SERIAL PRIMARY KEY, nombre VARCHAR(50));
CREATE TABLE mascotas (id SERIAL PRIMARY KEY, nombre VARCHAR(50));

-- Tabla Intermedia (Junction Table)
CREATE TABLE personas_mascotas (
    persona_id INT,
    mascota_id INT,
    CONSTRAINT fk_persona FOREIGN KEY (persona_id) REFERENCES personas(id),
    CONSTRAINT fk_mascota FOREIGN KEY (mascota_id) REFERENCES mascotas(id),
    PRIMARY KEY (persona_id, mascota_id) -- Evita duplicados exactos
);

```
*(Si Mili (id 2) tiene el perro (id 3) y el gato (id 4), insertamos: (2, 3) y (2, 4)).*
# 🤝 JOINS: Uniendo Tablas
> El comando JOIN sirve para ver datos de ambas tablas relacionadas en una sola consulta.
> 
 * **INNER JOIN:** Es el más usado. Devuelve *únicamente* las filas que tienen coincidencias exactas en ambas tablas.
```sql
-- Queremos ver el nombre del hincha y el nombre de su equipo:
SELECT hinchas.nombre, equipos.nombre
FROM hinchas
INNER JOIN equipos ON hinchas.equipo_id = equipos.id;

```
# 🧮 Funciones de Agregación
> Sirven para hacer cálculos matemáticos sobre un grupo de filas y devolver **un solo valor**.
> 
 * 🔢 **COUNT()**: Cuenta la cantidad de filas (Ej. ¿Cuántos clientes hay?).
 * ➕ **SUM()**: Suma los valores numéricos (Ej. ¿Cuánto dinero entró hoy?).
 * 📊 **AVG()**: Calcula el promedio (Ej. Promedio de edad de los pilotos).
 * 🏆 **MAX() / MIN()**: Busca el valor más alto o más bajo.
### ⚠️ La regla de oro: GROUP BY
Si usas una función de agregación Y ADEMÁS quieres mostrar una columna de texto (como el nombre del cliente), **estás obligado** a usar GROUP BY sobre esa columna.
### 🛑 HAVING vs WHERE
 * **WHERE**: Filtra filas individuales *antes* de agrupar.
 * **HAVING**: Filtra los resultados matemáticos *después* del GROUP BY.
# 🚀 Ejemplo Avanzado Definitivo (Combina todo)
Imagina una tabla de **Clientes** y **Pedidos** (1:N).
*Consigna: "Quiero saber el nombre de los clientes que gastaron más de $6000 en total, ordenados de mayor a menor gasto."*
```sql
SELECT clientes.nombre, SUM(pedidos.monto) AS total_gastado
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nombre
HAVING SUM(pedidos.monto) > 6000
ORDER BY total_gastado DESC;

```
```

```
