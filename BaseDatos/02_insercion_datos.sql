-- =============================================================
-- Clínica veterinaria - Datos de inicio (MySQL)
-- Ejecutar después de 01_creacion_tablas.sql
-- =============================================================

USE clinica_veterinaria;


-- -------------------------------------------------------------
-- DUEÑOS
-- -------------------------------------------------------------
INSERT INTO duenos (id, dni, nombre, telefono, email) VALUES
(1, '45123987B', 'Lucía Martín Gómez',      '612345678', 'lucia.martin@gmail.com'),
(2, '50981234D', 'Carlos Ruiz Fernández',   '634567891', 'carlos.ruiz@hotmail.com'),
(3, '71234560H', 'Marta Sánchez López',     '655123987', 'marta.sanchez@gmail.com'),
(4, '03456789G', 'Alberto Díaz Moreno',     '678901234', NULL),
(5, '28765432E', 'Elena Navarro Gil',       '691234567', 'elena.navarro@outlook.es'),
(6, '49876501N', 'Pablo Herrera Castro',    '722345678', 'pablo.herrera@gmail.com'),
(7, '53214876Y', 'Sara Romero Ortega',      '915678234', 'sara.romero@yahoo.es'),
(8, '76543210S', 'Andrés Molina Vega',      '644987321', 'andres.molina@gmail.com');


-- -------------------------------------------------------------
-- ESPECIES (peso en kg)
-- -------------------------------------------------------------
INSERT INTO especies (id, nombre, peso_min, peso_max) VALUES
(1, 'Perro',  1.0, 90.0),
(2, 'Gato',   1.5, 12.0),
(3, 'Conejo', 0.8,  8.0),
(4, 'Hurón',  0.5,  2.5),
(5, 'Cobaya', 0.5,  1.5),
(6, 'Loro',   0.1,  1.5);


-- -------------------------------------------------------------
-- MASCOTAS
-- -------------------------------------------------------------
INSERT INTO mascotas (id, nombre, raza, fecha_nacimiento, peso, esterilizada, foto, id_dueno, id_especie) VALUES
(1,  'Toby',   'Golden Retriever',   '2019-04-12', 32.5, 1, 'fotos/toby.jpg',   1, 1),
(2,  'Luna',   'Europeo común',      '2021-08-03',  4.2, 1, 'fotos/luna.jpg',   1, 2),
(3,  'Rocky',  'Bulldog francés',    '2022-01-20', 12.8, 0, 'fotos/rocky.jpg',  2, 1),
(4,  'Nala',   'Siamés',             '2020-11-15',  3.6, 1, 'fotos/nala.jpg',   3, 2),
(5,  'Coco',   'Belier enano',       '2023-03-02',  1.9, 0, 'fotos/coco.jpg',   3, 3),
(6,  'Max',    'Pastor alemán',      '2018-06-30', 36.0, 0, 'fotos/max.jpg',    4, 1),
(7,  'Kira',   'Border Collie',      '2021-02-14', 18.4, 1, 'fotos/kira.jpg',   5, 1),
(8,  'Simba',  'Maine Coon',         '2019-09-09',  7.8, 1, 'fotos/simba.jpg',  5, 2),
(9,  'Bolt',   'Hurón común',        '2022-07-11',  1.2, 1, 'fotos/bolt.jpg',   6, 4),
(10, 'Pelusa', 'Peruana',            '2024-01-05',  0.9, 0, NULL,               7, 5),
(11, 'Kiwi',   'Yaco',               '2017-05-21',  0.45, 0, NULL,              7, 6),
(12, 'Thor',   'Labrador Retriever', '2016-10-02', 30.2, 1, 'fotos/thor.jpg',   8, 1),
(13, 'Mía',    'Persa',              '2022-12-24',  3.9, 0, 'fotos/mia.jpg',    2, 2);


-- -------------------------------------------------------------
-- VETERINARIOS
-- -------------------------------------------------------------
INSERT INTO veterinarios (id, num_colegiado, nombre, especialidad, activo) VALUES
(1, '28-4521', 'Ana Belén Torres Prieto', 'Medicina general',  1),
(2, '28-3870', 'Raúl Jiménez Soto',       'Cirugía',           1),
(3, '28-5102', 'Irene Castillo Ramos',    'Dermatología',      1),
(4, '28-4999', 'Diego Fuentes Marín',     'Animales exóticos', 1),
(5, '28-2214', 'Rosa Delgado Iglesias',   'Cardiología',       0);


-- -------------------------------------------------------------
-- VACUNAS
-- -------------------------------------------------------------
INSERT INTO vacunas (id, nombre, periodicidad_dias) VALUES
(1, 'Rabia',                               365),
(2, 'Polivalente canina',                  365),
(3, 'Leptospirosis',                       365),
(4, 'Tos de las perreras',                 365),
(5, 'Trivalente felina',                   365),
(6, 'Leucemia felina',                     365),
(7, 'Mixomatosis',                         180),
(8, 'Enfermedad hemorrágica vírica',       365);


-- -------------------------------------------------------------
-- MASCOTA_VACUNA
-- -------------------------------------------------------------
INSERT INTO mascota_vacuna (id_mascota, id_vacuna, fecha_aplicacion, lote, id_veterinario) VALUES
(1,  1, '2025-04-15', 'RAB-2504A',  1),
(1,  2, '2025-04-15', 'PCN-2503K',  1),
(1,  1, '2026-04-14', 'RAB-2603C',  1),
(1,  3, '2026-04-14', 'LEP-2602B',  1),
(2,  5, '2025-09-10', 'TRF-2508D',  3),
(2,  6, '2025-09-10', 'FELV-2507A', 3),
(3,  2, '2026-02-03', 'PCN-2601F',  2),
(3,  1, '2026-02-03', 'RAB-2601B',  2),
(3,  4, '2026-05-20', 'TOS-2604A',  1),
(4,  5, '2025-12-01', 'TRF-2511C',  5),
(5,  7, '2026-03-10', 'MIX-2602A',  4),
(5,  8, '2026-03-10', 'EHV-2601C',  4),
(5,  7, '2026-09-08', 'MIX-2608B',  4),
(6,  1, '2025-07-01', 'RAB-2506D',  5),
(7,  2, '2026-01-18', 'PCN-2512H',  1),
(7,  3, '2026-01-18', 'LEP-2512A',  1),
(8,  5, '2026-06-22', 'TRF-2605E',  3),
(9,  1, '2026-08-05', 'RAB-2607A',  4),
(12, 1, '2025-10-30', 'RAB-2509F',  2),
(12, 4, '2025-10-30', 'TOS-2509C',  NULL),
(13, 5, '2026-03-25', 'TRF-2602B',  3);


-- -------------------------------------------------------------
-- CONSULTAS
-- -------------------------------------------------------------
INSERT INTO consultas (id, fecha, motivo, peso_actual, id_mascota, id_veterinario) VALUES
(1,  '2025-11-03 10:15:00', 'Otitis en el oído derecho',             32.8,  1, 1),
(2,  '2025-12-01 17:30:00', 'Revisión anual y vacunación',            3.6,  4, 5),
(3,  '2026-01-12 09:45:00', 'Cojera en la pata trasera izquierda',   36.4,  6, 2),
(4,  '2026-02-03 11:00:00', 'Vacunación y revisión',                 12.5,  3, 2),
(5,  '2026-03-10 12:30:00', 'Vacunación y control de peso',           1.9,  5, 4),
(6,  '2026-04-22 16:00:00', 'Dermatitis por pulgas',                  4.3,  2, 3),
(7,  '2026-05-20 10:30:00', 'Vómitos y diarrea',                     12.2,  3, 1),
(8,  '2026-06-22 18:00:00', 'Infección urinaria',                     7.9,  8, 3),
(9,  '2026-07-15 09:15:00', 'Diarrea',                                1.1,  9, 4),
(10, '2026-08-28 13:00:00', 'Herida en una almohadilla',             18.6,  7, 1),
(11, '2026-09-14 17:45:00', 'Dolor articular por artrosis',          31.0, 12, 2),
(12, '2026-10-05 11:30:00', 'Alergia cutánea con picor',             32.4,  1, 3),
(13, '2026-10-16 10:00:00', 'Estornudos y secreción ocular',          3.8, 13, 1),
(14, '2026-10-20 16:30:00', 'Vómitos después de comer',              35.9,  6, 2);


-- -------------------------------------------------------------
-- MEDICAMENTOS (concentración en mg por comprimido, dosis en mg/kg)
-- -------------------------------------------------------------
INSERT INTO medicamentos (id, nombre, concentracion_mg, dosis_min, dosis_max) VALUES
(1,  'Amoxicilina/ácido clavulánico', 250.0, 12.5, 25.0),
(2,  'Meloxicam',                       2.5,  0.1,  0.2),
(3,  'Metronidazol',                  250.0, 10.0, 25.0),
(4,  'Prednisolona',                    5.0,  0.5,  2.0),
(5,  'Doxiciclina',                   100.0,  5.0, 10.0),
(6,  'Cefalexina',                    500.0, 15.0, 30.0),
(7,  'Maropitant',                     16.0,  1.0,  2.0),
(8,  'Gabapentina',                   100.0,  5.0, 20.0),
(9,  'Enrofloxacino',                  50.0,  5.0, 10.0),
(10, 'Omeprazol',                      10.0,  0.5,  1.0);


-- -------------------------------------------------------------
-- CONSULTA_MEDICAMENTO (recetas)
-- Las consultas 2, 4 y 5 no tienen receta.
-- Hay dosis fuera de rango a propósito para probar la App 2.
-- -------------------------------------------------------------
INSERT INTO consulta_medicamento (id_consulta, id_medicamento, dosis_mg_kg, tomas_dia, dias_tratamiento) VALUES
(1,  1, 20.0,  2, 10),
(1,  4,  1.0,  1,  5),
(3,  2,  0.1,  1,  7),
(3,  8, 10.0,  2, 14),
(6,  4,  1.0,  1,  7),
(6,  6, 12.0,  2,  7),   -- por debajo del rango
(7,  7,  2.0,  1,  4),
(7,  3, 15.0,  2,  7),
(7, 10,  1.0,  1,  7),
(8,  1, 30.0,  2, 10),   -- por encima del rango
(9,  3, 20.0,  2,  5),
(10, 6, 22.0,  2, 10),
(10, 2,  0.1,  1,  5),
(11, 2,  0.3,  1, 30),   -- por encima del rango
(11, 8,  5.0,  2, 30),
(12, 4,  0.25, 1, 10),   -- por debajo del rango
(12, 6, 15.0,  2, 14),
(13, 5, 10.0,  1, 10),
(14, 7,  2.5,  1,  3),   -- por encima del rango
(14, 10, 1.0,  2,  7);


-- -------------------------------------------------------------
-- INFORMES ya procesados por la App 2
-- Las consultas 9 a 14 tienen receta pero aún no se han enviado.
-- -------------------------------------------------------------
INSERT INTO informes (id, id_solicitud, fecha_procesamiento, estado, id_consulta) VALUES
(1, 'SOL-2025-001', '2025-11-03 10:32:14', 'Procesada correctamente', 1),
(2, 'SOL-2026-001', '2026-01-12 10:02:47', 'Procesada correctamente', 3),
(3, 'SOL-2026-002', '2026-04-22 16:20:05', 'Procesada correctamente', 6),
(4, 'SOL-2026-003', '2026-05-20 10:51:39', 'Procesada correctamente', 7),
(5, 'SOL-2026-004', '2026-06-22 18:14:22', 'Procesada correctamente', 8);


-- -------------------------------------------------------------
-- RESULTADOS
-- dosis por toma    = dosis_mg_kg * peso_actual
-- dosis_total_mg    = dosis por toma * tomas_dia * dias_tratamiento
-- unidades_por_toma = dosis por toma / concentracion_mg
-- -------------------------------------------------------------
INSERT INTO resultados (id_informe, id_medicamento, dosis_total_mg, unidades_por_toma, clasificacion) VALUES
(1, 1, 13120.0,  2.62, 'Correcta'),
(1, 4,   164.0,  6.56, 'Correcta'),
(2, 2,    25.48, 1.46, 'Correcta'),
(2, 8, 10192.0,  3.64, 'Correcta'),
(3, 4,    30.1,  0.86, 'Correcta'),
(3, 6,   722.4,  0.10, 'Por debajo'),
(4, 7,    97.6,  1.53, 'Correcta'),
(4, 3,  2562.0,  0.73, 'Correcta'),
(4, 10,   85.4,  1.22, 'Correcta'),
(5, 1,  4740.0,  0.95, 'Por encima');
