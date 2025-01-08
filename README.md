
# Base de Datos - Tienda y Universidad

Este repositorio contiene el diseño y las consultas de dos bases de datos relacionales: **Tienda** y **Universidad**. Ambas bases de datos están diseñadas para cumplir con los requisitos especificados en sus respectivos enunciados. A través de diversas consultas SQL, se extrae, organiza y analiza la información almacenada en estas bases.

---

## **Base de Datos Tienda**

La base de datos **Tienda** modela un sistema para la gestión de productos y fabricantes. 

### **Estructura de Tablas**
1. **fabricante:**
   - Almacena los nombres de los fabricantes.
   - **Clave primaria:** `codigo`.

2. **producto:**
   - Contiene información de los productos, incluyendo precio y fabricante.
   - **Clave primaria:** `codigo`.
   - **Clave foránea:** `codigo_fabricante → fabricante.codigo`.

---

## **Base de Datos Universidad**

La base de datos **Universidad** gestiona la información sobre alumnos, profesores, grados, asignaturas, departamentos, y cursos escolares. 

### **Estructura de Tablas**
1. **persona:**
   - Almacena datos personales de alumnos y profesores.
   - **Claves principales:** `id`.
   - Campo `tipo`: diferencia entre `'alumno'` y `'profesor'`.

2. **profesor:**
   - Relaciona profesores con departamentos.
   - **Clave primaria:** `id_profesor`.
   - **Clave foránea:** `id_departamento → departamento.id`.

3. **departamento:**
   - Define los departamentos académicos.
   - **Clave primaria:** `id`.

4. **grado:**
   - Contiene información de los grados ofrecidos.
   - **Clave primaria:** `id`.

5. **asignatura:**
   - Registra asignaturas, sus créditos y el profesor que las imparte.
   - **Clave primaria:** `id`.
   - **Claves foráneas:** 
     - `id_profesor → profesor.id_profesor`.
     - `id_grado → grado.id`.

6. **curso_escolar:**
   - Registra los periodos académicos.
   - **Clave primaria:** `id`.

7. **alumno_se_matricula_asignatura:**
   - Relaciona alumnos con asignaturas y cursos escolares.
   - **Clave primaria compuesta:** `id_alumno, id_asignatura, id_curso_escolar`.

---

## **Sobre el proyecto**
Este repositorio incluye:

1. **Definiciones de las estructuras de las tablas.**
2. **Consultas SQL específicas para analizar y organizar datos.**
3. **Ejemplos y casos de uso práctico para facilitar la comprensión.**

### **Colaboraciones**
Si deseas contribuir con nuevas consultas o mejorar el diseño, ¡envía un pull request!

