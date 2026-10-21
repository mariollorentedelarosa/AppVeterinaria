-- =============================================================
-- Clínica veterinaria - Creación de la base de datos (MySQL)
-- Las validaciones de los datos (pesos, dosis, DNI...) se hacen
-- en la aplicación, no en la base de datos.
-- =============================================================

-- Se borra y se vuelve a crear entera para poder ejecutar
-- el script varias veces desde cero
DROP DATABASE IF EXISTS clinica_veterinaria;
CREATE DATABASE clinica_veterinaria
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE clinica_veterinaria;


-- -------------------------------------------------------------
-- DUEÑOS
-- -------------------------------------------------------------
CREATE TABLE duenos (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    dni         CHAR(9)      NOT NULL UNIQUE,
    nombre      VARCHAR(100) NOT NULL,
    telefono    CHAR(9)      NOT NULL,
    email       VARCHAR(100)
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- ESPECIES (se usa en el ComboBox al dar de alta una mascota)
-- -------------------------------------------------------------
CREATE TABLE especies (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(50)  NOT NULL UNIQUE,
    peso_min    DECIMAL(5,2) NOT NULL,
    peso_max    DECIMAL(5,2) NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- MASCOTAS
-- 1:N con duenos   -> si se borra el dueño se borran sus mascotas
-- 1:N con especies -> no se deja borrar una especie que esté en uso
-- -------------------------------------------------------------
CREATE TABLE mascotas (
    id                  INT          AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(50)  NOT NULL,
    raza                VARCHAR(50),
    fecha_nacimiento    DATE         NOT NULL,
    peso                DECIMAL(5,2) NOT NULL,
    esterilizada        BOOLEAN      NOT NULL DEFAULT FALSE,
    foto                VARCHAR(255),                    -- ruta de la imagen
    id_dueno            INT          NOT NULL,
    id_especie          INT          NOT NULL,
    FOREIGN KEY (id_dueno)   REFERENCES duenos(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_especie) REFERENCES especies(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- VETERINARIOS
-- -------------------------------------------------------------
CREATE TABLE veterinarios (
    id              INT          AUTO_INCREMENT PRIMARY KEY,
    num_colegiado   VARCHAR(10)  NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    especialidad    VARCHAR(50),
    activo          BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- VACUNAS
-- -------------------------------------------------------------
CREATE TABLE vacunas (
    id                  INT          AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(50)  NOT NULL UNIQUE,
    periodicidad_dias   INT          NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- MASCOTA_VACUNA (N:M entre mascotas y vacunas)
-- La fecha forma parte de la clave para poder registrar
-- la misma vacuna varias veces (revacunaciones).
-- Si se borra el veterinario, el registro se queda sin él (SET NULL).
-- -------------------------------------------------------------
CREATE TABLE mascota_vacuna (
    id_mascota          INT          NOT NULL,
    id_vacuna           INT          NOT NULL,
    fecha_aplicacion    DATE         NOT NULL,
    lote                VARCHAR(20)  NOT NULL,
    id_veterinario      INT,
    PRIMARY KEY (id_mascota, id_vacuna, fecha_aplicacion),
    FOREIGN KEY (id_mascota)     REFERENCES mascotas(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_vacuna)      REFERENCES vacunas(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- CONSULTAS
-- -------------------------------------------------------------
CREATE TABLE consultas (
    id              INT          AUTO_INCREMENT PRIMARY KEY,
    fecha           DATETIME     NOT NULL,
    motivo          VARCHAR(255) NOT NULL,
    peso_actual     DECIMAL(5,2) NOT NULL,
    id_mascota      INT          NOT NULL,
    id_veterinario  INT,
    FOREIGN KEY (id_mascota)     REFERENCES mascotas(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- MEDICAMENTOS
-- concentracion_mg: mg por unidad (comprimido)
-- dosis_min / dosis_max: en mg/kg
-- -------------------------------------------------------------
CREATE TABLE medicamentos (
    id                  INT          AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL UNIQUE,
    concentracion_mg    DECIMAL(8,2) NOT NULL,
    dosis_min           DECIMAL(6,2) NOT NULL,
    dosis_max           DECIMAL(6,2) NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- CONSULTA_MEDICAMENTO (N:M entre consultas y medicamentos)
-- Es la receta: lo que se envía a la App 2 para procesar.
-- -------------------------------------------------------------
CREATE TABLE consulta_medicamento (
    id_consulta         INT          NOT NULL,
    id_medicamento      INT          NOT NULL,
    dosis_mg_kg         DECIMAL(6,2) NOT NULL,
    tomas_dia           INT          NOT NULL,
    dias_tratamiento    INT          NOT NULL,
    PRIMARY KEY (id_consulta, id_medicamento),
    FOREIGN KEY (id_consulta)    REFERENCES consultas(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- INFORMES (respuesta de la App 2 para una consulta)
-- -------------------------------------------------------------
CREATE TABLE informes (
    id                      INT          AUTO_INCREMENT PRIMARY KEY,
    id_solicitud            VARCHAR(20)  NOT NULL UNIQUE,    -- 'SOL-2026-001'
    fecha_procesamiento     DATETIME     NOT NULL,
    estado                  VARCHAR(50)  NOT NULL,
    id_consulta             INT          NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES consultas(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------
-- RESULTADOS (una fila por medicamento del informe)
-- clasificacion: 'Correcta', 'Por debajo' o 'Por encima'
-- -------------------------------------------------------------
CREATE TABLE resultados (
    id                  INT           AUTO_INCREMENT PRIMARY KEY,
    id_informe          INT           NOT NULL,
    id_medicamento      INT           NOT NULL,
    dosis_total_mg      DECIMAL(10,2) NOT NULL,
    unidades_por_toma   DECIMAL(6,2)  NOT NULL,
    clasificacion       VARCHAR(20)   NOT NULL,
    UNIQUE (id_informe, id_medicamento),
    FOREIGN KEY (id_informe)     REFERENCES informes(id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;
