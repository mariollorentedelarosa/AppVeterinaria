-- Datos de prueba de la clínica, hay que ejecutarlo después de 01_creacion_tablas.sql

USE clinica_veterinaria;


-- Dueños
INSERT INTO duenos (id, dni, nombre, telefono, email) VALUES
(1, '45123987B', 'Lucía Martín Gómez',      '612345678', 'lucia.martin@gmail.com'),
(2, '50981234D', 'Carlos Ruiz Fernández',   '634567891', 'carlos.ruiz@hotmail.com'),
(3, '71234560H', 'Marta Sánchez López',     '655123987', 'marta.sanchez@gmail.com'),
(4, '03456789G', 'Alberto Díaz Moreno',     '678901234', NULL),
(5, '28765432E', 'Elena Navarro Gil',       '691234567', 'elena.navarro@outlook.es'),
(6, '49876501N', 'Pablo Herrera Castro',    '722345678', 'pablo.herrera@gmail.com'),
(7, '53214876Y', 'Sara Romero Ortega',      '915678234', 'sara.romero@yahoo.es'),
(8, '76543210S', 'Andrés Molina Vega',      '644987321', 'andres.molina@gmail.com');


-- Especies (el peso va en kg)
INSERT INTO especies (id, nombre, peso_min, peso_max) VALUES
(1, 'Perro',  1.0, 90.0),
(2, 'Gato',   1.5, 12.0),
(3, 'Conejo', 0.8,  8.0),
(4, 'Hurón',  0.5,  2.5),
(5, 'Cobaya', 0.5,  1.5),
(6, 'Loro',   0.1,  1.5);


-- Mascotas
INSERT INTO mascotas (id, nombre, raza, fecha_nacimiento, peso, esterilizada, id_dueno, id_especie) VALUES
(1,  'Toby',   'Golden Retriever',   '2019-04-12', 32.5,  1, 1, 1),
(2,  'Luna',   'Europeo común',      '2021-08-03',  4.2,  1, 1, 2),
(3,  'Rocky',  'Bulldog francés',    '2022-01-20', 12.8,  0, 2, 1),
(4,  'Nala',   'Siamés',             '2020-11-15',  3.6,  1, 3, 2),
(5,  'Coco',   'Belier enano',       '2023-03-02',  1.9,  0, 3, 3),
(6,  'Max',    'Pastor alemán',      '2018-06-30', 36.0,  0, 4, 1),
(7,  'Kira',   'Border Collie',      '2021-02-14', 18.4,  1, 5, 1),
(8,  'Simba',  'Maine Coon',         '2019-09-09',  7.8,  1, 5, 2),
(9,  'Bolt',   'Hurón común',        '2022-07-11',  1.2,  1, 6, 4),
(10, 'Pelusa', 'Peruana',            '2024-01-05',  0.9,  0, 7, 5),
(11, 'Kiwi',   'Yaco',               '2017-05-21',  0.45, 0, 7, 6),
(12, 'Thor',   'Labrador Retriever', '2016-10-02', 30.2,  1, 8, 1),
(13, 'Mía',    'Persa',              '2022-12-24',  3.9,  0, 2, 2);


-- Medicamentos
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


-- Informes que ya ha procesado la App 2
-- Los resultados están calculados así:
-- dosis por toma = dosis_mg_kg * peso de la mascota
-- dosis total = dosis por toma * tomas_dia * dias_tratamiento
-- unidades por toma = dosis por toma / concentracion_mg
INSERT INTO informes (id, id_mascota, id_medicamento, fecha_receta, motivo, dosis_mg_kg, tomas_dia, dias_tratamiento,
                      id_solicitud, estado, fecha_procesamiento, dosis_total_mg, unidades_por_toma, clasificacion) VALUES
(1,  1, 1,  '2025-11-03', 'Otitis en el oído derecho',           20.0, 2, 10, 'SOL-2025-001', 'Procesada correctamente', '2025-11-03 10:32:14', 13000.0, 2.60, 'Correcta'),
(2,  1, 4,  '2025-11-03', 'Otitis en el oído derecho',            1.0, 1,  5, 'SOL-2025-002', 'Procesada correctamente', '2025-11-03 10:32:16',   162.5, 6.50, 'Correcta'),
(3,  6, 2,  '2026-01-12', 'Cojera en la pata trasera izquierda',  0.1, 1,  7, 'SOL-2026-001', 'Procesada correctamente', '2026-01-12 10:02:47',    25.2, 1.44, 'Correcta'),
(4,  6, 8,  '2026-01-12', 'Cojera en la pata trasera izquierda', 10.0, 2, 14, 'SOL-2026-002', 'Procesada correctamente', '2026-01-12 10:02:49', 10080.0, 3.60, 'Correcta'),
(5,  2, 4,  '2026-04-22', 'Dermatitis por pulgas',                1.0, 1,  7, 'SOL-2026-003', 'Procesada correctamente', '2026-04-22 16:20:05',    29.4, 0.84, 'Correcta'),
(6,  2, 6,  '2026-04-22', 'Dermatitis por pulgas',               12.0, 2,  7, 'SOL-2026-004', 'Procesada correctamente', '2026-04-22 16:20:07',   705.6, 0.10, 'Por debajo'),
(7,  3, 7,  '2026-05-20', 'Vómitos y diarrea',                    2.0, 1,  4, 'SOL-2026-005', 'Procesada correctamente', '2026-05-20 10:51:39',   102.4, 1.60, 'Correcta'),
(8,  3, 3,  '2026-05-20', 'Vómitos y diarrea',                   15.0, 2,  7, 'SOL-2026-006', 'Procesada correctamente', '2026-05-20 10:51:41',  2688.0, 0.77, 'Correcta'),
(9,  3, 10, '2026-05-20', 'Vómitos y diarrea',                    1.0, 1,  7, 'SOL-2026-007', 'Procesada correctamente', '2026-05-20 10:51:43',    89.6, 1.28, 'Correcta'),
(10, 8, 1,  '2026-06-22', 'Infección urinaria',                  30.0, 2, 10, 'SOL-2026-008', 'Procesada correctamente', '2026-06-22 18:14:22',  4680.0, 0.94, 'Por encima');


-- Informes que todavía no se han mandado a la App 2
-- Algunas dosis están mal a propósito para probar la App 2
INSERT INTO informes (id, id_mascota, id_medicamento, fecha_receta, motivo, dosis_mg_kg, tomas_dia, dias_tratamiento) VALUES
(11, 9,  3,  '2026-07-15', 'Diarrea',                        20.0,  2,  5),
(12, 7,  6,  '2026-08-28', 'Herida en una almohadilla',      22.0,  2, 10),
(13, 7,  2,  '2026-08-28', 'Herida en una almohadilla',       0.1,  1,  5),
(14, 12, 2,  '2026-09-14', 'Dolor articular por artrosis',    0.3,  1, 30),   -- se pasa del máximo
(15, 12, 8,  '2026-09-14', 'Dolor articular por artrosis',    5.0,  2, 30),
(16, 1,  4,  '2026-10-05', 'Alergia cutánea con picor',       0.25, 1, 10),   -- no llega al mínimo
(17, 1,  6,  '2026-10-05', 'Alergia cutánea con picor',      15.0,  2, 14),
(18, 13, 5,  '2026-10-16', 'Estornudos y secreción ocular',  10.0,  1, 10),
(19, 6,  7,  '2026-10-20', 'Vómitos después de comer',        2.5,  1,  3),   -- se pasa del máximo
(20, 6,  10, '2026-10-20', 'Vómitos después de comer',        1.0,  2,  7);
