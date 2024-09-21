DROP TABLE IF EXISTS alumno ;
DROP TABLE IF EXISTS bootcamp ;
DROP TABLE IF EXISTS coordinador; 
DROP TABLE IF EXISTS evaluaciones ;
DROP TABLE IF EXISTS matricula ;
DROP TABLE IF EXISTS modulo ;
DROP TABLE IF EXISTS modulo_bootcamp ;
DROP TABLE IF EXISTS profesor ;
DROP TABLE IF EXISTS profesor_modulo ;
;

-- Crear tabla coordinador

CREATE TABLE coordinador (
	coordinador_id SERIAL PRIMARY KEY,
	nombre VARCHAR(255)  NOT NULL,
	apellido VARCHAR(255)  NOT NULL,
	telefono VARCHAR(20) NOT NULL, 
	email VARCHAR(225)  NOT NULL UNIQUE,
	fecha_nac DATE
	)
;

-- Crear tabla profesor

CREATE TABLE profesor (
	profesor_id SERIAL PRIMARY KEY,
	nombre VARCHAR(255)  NOT NULL,
	apellido VARCHAR(255)  NOT NULL,
	telefono VARCHAR(20) NOT NULL, 
	email VARCHAR(225)  NOT NULL UNIQUE,
	fecha_nac DATE
	)
;

-- Crear tabla bootcamp

CREATE TABLE bootcamp (
	bootcamp_id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	coordinador_id INT NOT NULL,
	
	FOREIGN KEY (coordinador_id) REFERENCES coordinador(coordinador_id)
	)
;

-- Crear tabla modulo

CREATE TABLE modulo (
	modulo_id SERIAL PRIMARY KEY,
	nombre 	VARCHAR(255) NOT NULL
)
;
-- Crear tabla intermedia profesor_modulo

CREATE TABLE profesor_modulo (
	profesor_modulo_id SERIAL PRIMARY KEY,
	profesor_id INT NOT NULL,
	modulo_id INT NOT NULL,
	
	FOREIGN KEY (profesor_id) REFERENCES profesor(profesor_id),
	FOREIGN KEY (modulo_id) REFERENCES modulo(modulo_id),
	
	UNIQUE (profesor_id, modulo_id)
	)
;


-- Crer tabla intermedia modulo_bootcamp

CREATE TABLE modulo_bootcamp (
	modulo_bootcamp_id SERIAL PRIMARY KEY,
	modulo_id INT NOT NULL,
	bootcamp_id INT NOT NULL,
	
	FOREIGN KEY (modulo_id) REFERENCES modulo(modulo_id),
	FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id),
	
	UNIQUE(modulo_id, bootcamp_id)
    )
;

-- Crear tabla alumno

CREATE TABLE alumno (
	alumno_id SERIAL PRIMARY KEY,
	nombre VARCHAR(255)  NOT NULL,
	apellido VARCHAR(255)  NOT NULL,
	telefono VARCHAR(20) NOT NULL, 
	email VARCHAR(225)  NOT NULL UNIQUE,
	fecha_nac DATE
	)
;


-- Crear tabla matricula

CREATE TABLE matricula (
	matricula_id SERIAL PRIMARY KEY,
	alumno_id INT NOT NULL,
	bootcamp_id INT NOT NULL,
	fecha_mat DATE NOT NULL, 
	
	FOREIGN KEY (alumno_id) REFERENCES alumno(alumno_id),
	FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id)
    )
;
    
-- Crear tabla evaluaciones

CREATE TABLE evaluaciones (
	evaluaciones_id SERIAL NOT NULL,
	modulo_bootcamp_id INT NOT NULL,
	alumno_id INT NOT NULL, 
	nota CHAR(20), 
	
	FOREIGN KEY (modulo_bootcamp_id) REFERENCES modulo_bootcamp(modulo_bootcamp_id),
	FOREIGN KEY (alumno_id) REFERENCES alumno(alumno_id)
	)
;    



-- Introducimos muestra de datos desde chatgpt

INSERT INTO alumno (nombre, apellido, telefono, email, fecha_nac) VALUES
('Carlos', 'González', '600123456', 'carlos.gonzalez@example.com', '1995-05-12'),
('María', 'López', '677987654', 'maria.lopez@example.com', '1998-10-23'),
('Pedro', 'Fernández', '611334455', 'pedro.fernandez@example.com', '1993-02-17'),
('Lucía', 'Pérez', '656112233', 'lucia.perez@example.com', '2000-07-08'),
('Ana', 'García', '644223344', 'ana.garcia@example.com', '1987-01-13'),
('Juan', 'Martínez', '655998877', 'juan.martinez@example.com', '1992-04-25'),
('Elena', 'Sánchez', '622334455', 'elena.sanchez@example.com', '1989-11-19'),
('David', 'Romero', '611889900', 'david.romero@example.com', '1996-03-30'),
('Laura', 'Jiménez', '677443322', 'laura.jimenez@example.com', '1997-12-05'),
('Marta', 'Navarro', '666667788', 'marta.navarro@example.com', '1994-06-15'),
('Javier', 'Torres', '655001122', 'javier.torres@example.com', '1991-08-20'),
('Sara', 'Ruiz', '644556677', 'sara.ruiz@example.com', '1990-09-11'),
('Antonio', 'Castillo', '611223344', 'antonio.castillo@example.com', '1988-03-01'),
('Cristina', 'Ortega', '600554433', 'cristina.ortega@example.com', '1999-02-09'),
('Adrián', 'Moreno', '677998877', 'adrian.moreno@example.com', '2001-05-20'),
('Pablo', 'Gil', '655998877', 'pablo.gil@example.com', '1993-07-14'),
('Silvia', 'Vargas', '611776655', 'silvia.vargas@example.com', '1992-12-27'),
('Raquel', 'Santos', '600998877', 'raquel.santos@example.com', '1995-06-18'),
('Miguel', 'Iglesias', '622998877', 'miguel.iglesias@example.com', '1998-09-09'),
('Carmen', 'Reyes', '666889900', 'carmen.reyes@example.com', '1994-04-02');

INSERT INTO coordinador (nombre, apellido, telefono, email, fecha_nac) VALUES
('Juan', 'Pérez', '555-1234', 'juan.perez@example.com', '1985-06-15'),
('María', 'Gómez', '555-5678', 'maria.gomez@example.com', '1990-02-20'),
('Luis', 'Martínez', '555-8765', 'luis.martinez@example.com', '1988-11-05'),
('Ana', 'Rodríguez', '555-4321', 'ana.rodriguez@example.com', '1995-08-30'),
('Carlos', 'Sánchez', '555-2468', 'carlos.sanchez@example.com', '1979-03-12'),
('Laura', 'Torres', '555-1357', 'laura.torres@example.com', '1992-12-25'),
('Fernando', 'Hernández', '555-9876', 'fernando.hernandez@example.com', '1983-04-10'),
('Elena', 'Morales', '555-6543', 'elena.morales@example.com', '1987-09-15');


INSERT INTO bootcamp (nombre, coordinador_id) VALUES
('Full Stack Web Bootcamp', 1),
('Data Science Bootcamp', 2),
('Big Data, IA & ML Bootcamp', 3),
('Ciberseguridad Bootcamp', 4),
('Mobile Bootcamp', 5),
('DevOps & Cloud Bootcamp', 6),
('Frontend & UX/UI Bootcamp', 7),
('Backend Bootcamp', 8);

INSERT INTO modulo (nombre) VALUES
('HTML y CSS Básico'),
('JavaScript Avanzado'),
('Análisis Exploratorio de Datos'),
('Fundamentos de Machine Learning'),
('Seguridad en Aplicaciones Web'),
('Desarrollo de Aplicaciones Móviles con Flutter'),
('Integración Continua y Despliegue'),
('UX Research y Prototipado'),
('Node.js para Principiantes'),
('Python para Ciencia de Datos'),
('Bases de Datos NoSQL'),
('Estrategias de Visualización de Datos'),
('Redes Neuronales y Deep Learning'),
('Metodologías Ágiles'),
('Desarrollo de APIs RESTful');

INSERT INTO modulo_bootcamp (modulo_id, bootcamp_id) VALUES
(1,1 ),  -- HTML y CSS Básico en Full Stack Web Bootcamp
(2, 1),  -- JavaScript Avanzado en Full Stack Web Bootcamp
(3, 2), -- Análisis Exploratorio de Datos en Data Science Bootcamp
(4, 3), -- Fundamentos de Machine Learning en Big Data, IA & ML Bootcamp
(5, 4), -- Seguridad en Aplicaciones Web en Ciberseguridad Bootcamp
(6, 5), -- Desarrollo de Aplicaciones Móviles con Flutter en Mobile Bootcamp
(7, 6), -- Integración Continua y Despliegue en DevOps & Cloud Bootcamp
(8, 7), -- UX Research y Prototipado en Frontend & UX/UI Bootcamp
(9, 8), -- Node.js para Principiantes en Backend Bootcamp
(10, 2), -- Python para Ciencia de Datos en Data Science Bootcamp
(11, 3), -- Bases de Datos NoSQL en Big Data, IA & ML Bootcamp
(12, 6), -- Estrategias de Visualización de Datos en DevOps & Cloud Bootcamp
(13, 4), -- Redes Neuronales y Deep Learning en Ciberseguridad Bootcamp
(14, 5), -- Metodologías Ágiles en Mobile Bootcamp
(15, 1); -- Desarrollo de APIs RESTful en Full Stack Web Bootcamp



INSERT INTO evaluaciones (modulo_bootcamp_id, alumno_id, nota) VALUES
(1, 1, 'A'),
(2, 2, 'B+'),
(3, 3, 'A-'),
(4, 4, 'B'),
(5, 5, 'C+'),
(6, 6, 'A'),
(7, 7, 'B-'),
(8, 8, 'A+'),
(9, 9, 'C'),
(10, 10, 'B+'),
(11, 11, 'A-'),
(12, 12, 'C+'),
(13, 13, 'B'),
(14, 14, 'A'),
(15, 15, 'B-');

INSERT INTO matricula (alumno_id, bootcamp_id, fecha_mat) VALUES
(1, 1, '2024-01-15'),  -- Alumno 1 inscrito en Full Stack Web Bootcamp
(2, 2, '2024-01-20'), -- Alumno 2 inscrito en Data Science Bootcamp
(3, 3, '2024-02-01'), -- Alumno 3 inscrito en Big Data, IA & ML Bootcamp
(4, 4, '2024-02-10'), -- Alumno 4 inscrito en Ciberseguridad Bootcamp
(5, 5, '2024-03-05'), -- Alumno 5 inscrito en Mobile Bootcamp
(6, 6, '2024-03-12'), -- Alumno 6 inscrito en DevOps & Cloud Bootcamp
(7, 7, '2024-03-25'), -- Alumno 7 inscrito en Frontend & UX/UI Bootcamp
(8, 1, '2024-04-01'),  -- Alumno 8 inscrito en Full Stack Web Bootcamp
(9, 2, '2024-04-15'), -- Alumno 9 inscrito en Data Science Bootcamp
(10, 3, '2024-05-01'); -- Alumno 10 inscrito en Big Data, IA & ML Bootcamp

INSERT INTO profesor (nombre, apellido, telefono, email, fecha_nac) VALUES
('Ricardo', 'López', '555-9876', 'ricardo.lopez@example.com', '1980-03-12'),
('Sofía', 'Martínez', '555-6543', 'sofia.martinez@example.com', '1985-07-19'),
('Miguel', 'Fernández', '555-3210', 'miguel.fernandez@example.com', '1978-11-05'),
('Lucía', 'Gómez', '555-7654', 'lucia.gomez@example.com', '1990-02-25'),
('Pedro', 'Sánchez', '555-2468', 'pedro.sanchez@example.com', '1982-06-17'),
('María', 'Ramírez', '555-1357', 'maria.ramirez@example.com', '1987-09-23'),
('Andrés', 'Torres', '555-7890', 'andres.torres@example.com', '1983-05-30'),
('Elena', 'Cruz', '555-4567', 'elena.cruz@example.com', '1979-08-15');

INSERT INTO profesor_modulo (profesor_id, modulo_id) VALUES
(1, 1),  -- Profesor 1 enseña el módulo 1 (HTML y CSS Básico)
(2, 2),  -- Profesor 2 enseña el módulo 2 (JavaScript Avanzado)
(3, 3),  -- Profesor 3 enseña el módulo 3 (Análisis Exploratorio de Datos)
(4, 4),  -- Profesor 4 enseña el módulo 4 (Fundamentos de Machine Learning)
(5, 5),  -- Profesor 5 enseña el módulo 5 (Seguridad en Aplicaciones Web)
(6, 6),  -- Profesor 6 enseña el módulo 6 (Desarrollo de Aplicaciones Móviles con Flutter)
(7, 7),  -- Profesor 7 enseña el módulo 7 (Integración Continua y Despliegue)
(8, 8),  -- Profesor 8 enseña el módulo 8 (UX Research y Prototipado)
(1, 9),  -- Profesor 1 enseña el módulo 9 (Node.js para Principiantes)
(2, 10); -- Profesor 2 enseña el módulo 10 (Python para Ciencia de Datos)


-- consulta: quienes son los coordinadores de cada módulo? 

SELECT coordinador.nombre, coordinador.apellido, bootcamp.nombre AS bootcamp
FROM coordinador
LEFT JOIN bootcamp ON coordinador.coordinador_id = bootcamp.coordinador_id
;
-- Consulta: Qué profesores imparten más de un módulo? 

SELECT profesor.profesor_id, profesor.nombre, profesor.apellido, COUNT(profesor_modulo) AS módulos
FROM profesor_modulo
LEFT JOIN profesor ON profesor_modulo.profesor_id = profesor.profesor_id
GROUP by profesor.profesor_id
HAVING COUNT(profesor_modulo) > 1
;
