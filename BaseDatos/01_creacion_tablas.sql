-- Creación de la base de datos de la clínica veterinaria
-- Las validaciones (DNI, pesos, dosis...) las hacemos en la app, no en la BD

-- Si ya existe la borramos para poder ejecutar el script otra vez
DROP DATABASE IF EXISTS clinica_veterinaria;
CREATE DATABASE clinica_veterinaria;

USE clinica_veterinaria;


-- Dueños
CREATE TABLE duenos (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    dni         CHAR(9)      NOT NULL UNIQUE,
    nombre      VARCHAR(100) NOT NULL,
    telefono    CHAR(9)      NOT NULL,
    email       VARCHAR(100) UNIQUE
);


-- Especies, con el peso mínimo y máximo de cada una
CREATE TABLE especies (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(50)  NOT NULL UNIQUE,
    peso_min    DECIMAL(5,2) NOT NULL,
    peso_max    DECIMAL(5,2) NOT NULL
);


-- Mascotas. Cada mascota es de un dueño y de una especie (1:N)
-- Si borramos un dueño se borran sus mascotas, pero no se puede
-- borrar una especie si hay mascotas de esa especie
CREATE TABLE mascotas (
    id                  INT          AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(50)  NOT NULL,
    raza                VARCHAR(50),
    fecha_nacimiento    DATE         NOT NULL,
    peso                DECIMAL(5,2) NOT NULL,
    esterilizada        BOOLEAN      NOT NULL DEFAULT FALSE,
    id_dueno            INT          NOT NULL,
    id_especie          INT          NOT NULL,
    FOREIGN KEY (id_dueno)   REFERENCES duenos(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_especie) REFERENCES especies(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Medicamentos. La concentración son los mg que tiene cada comprimido
-- y la dosis mínima y máxima van en mg/kg
CREATE TABLE medicamentos (
    id                  INT          AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL UNIQUE,
    concentracion_mg    DECIMAL(8,2) NOT NULL,
    dosis_min           DECIMAL(6,2) NOT NULL,
    dosis_max           DECIMAL(6,2) NOT NULL
);


-- Informes, es la tabla intermedia entre mascotas y medicamentos (N:M)
-- Cada fila es un medicamento que se le receta a una mascota y es lo
-- que mandamos a la App 2. Los datos de la respuesta se quedan vacíos
-- hasta que la App 2 contesta
CREATE TABLE informes (
    id                      INT           AUTO_INCREMENT PRIMARY KEY,
    id_mascota              INT           NOT NULL,
    id_medicamento          INT           NOT NULL,
    -- datos de la receta
    fecha_receta            DATE          NOT NULL,
    motivo                  VARCHAR(255)  NOT NULL,
    dosis_mg_kg             DECIMAL(6,2)  NOT NULL,
    tomas_dia               INT           NOT NULL,
    dias_tratamiento        INT           NOT NULL,
    -- lo que devuelve la App 2
    id_solicitud            VARCHAR(20)   UNIQUE,
    estado                  VARCHAR(50)   NOT NULL DEFAULT 'Pendiente',
    fecha_procesamiento     DATETIME,
    dosis_total_mg          DECIMAL(10,2),
    unidades_por_toma       DECIMAL(6,2),
    clasificacion           VARCHAR(20),
    FOREIGN KEY (id_mascota)     REFERENCES mascotas(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
