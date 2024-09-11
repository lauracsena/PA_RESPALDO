CREATE DATABASE Pantry_Amigo;

USE Pantry_Amigo;

CREATE TABLE Tbl_Rol (
    Rol_Id INT(10) NOT NULL,
    Rol_Tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (Rol_Id)
);

CREATE TABLE Tbl_Administrador (
    Admin_Id INT AUTO_INCREMENT,
    Admin_Username VARCHAR(40) NOT NULL,
    Admin_Password VARCHAR(20) NOT NULL,
    Admin_Correo VARCHAR(20) NOT NULL,
    Admin_Rol_Id INT(10) NOT NULL,
    PRIMARY KEY (Admin_Id),
    FOREIGN KEY (Admin_Rol_Id) REFERENCES Tbl_Rol(Rol_Id)
);

CREATE TABLE Tbl_Fundaciones (
    Fund_NIT INT(10) NOT NULL,
    Fund_Username VARCHAR(40) NOT NULL,
    Fund_Password VARCHAR(20) NOT NULL,
    Fund_Correo VARCHAR(50) NOT NULL,
    Fund_Direccion VARCHAR(20) NOT NULL,
    Fund_Casos_Activos INT(10) NOT NULL,
    Fund_Telefono INT(10) NOT NULL,
    Fund_Rol_Id INT(10) NOT NULL,
    PRIMARY KEY (Fund_NIT),
    FOREIGN KEY (Fund_Rol_Id) REFERENCES Tbl_Rol(Rol_Id)
);

CREATE TABLE Tbl_Caso_Donacion (
    Caso_Id VARCHAR(15) NOT NULL,
    Caso_Nombre_Caso VARCHAR(40) NOT NULL,
    Caso_Descripcion VARCHAR(255) NOT NULL,
    Caso_Fecha_Inicio DATE NOT NULL,
    Caso_Fecha_Fin DATE NOT NULL,
    Caso_Estado VARCHAR(20) NOT NULL,
    Caso_Fund_NIT INT(10) NOT NULL,
    PRIMARY KEY (Caso_Id),
    FOREIGN KEY (Caso_Fund_NIT) REFERENCES Tbl_Fundaciones(Fund_NIT)
);

CREATE TABLE Tbl_Donante (
    Dona_Cedula INT(10) NOT NULL,
    Dona_Nombre VARCHAR(20) NOT NULL,
    Dona_Nombre_Recurso VARCHAR(15) NOT NULL,
    Dona_Apellido VARCHAR(40) NOT NULL,
    Dona_Correo VARCHAR(40) NOT NULL,
    Dona_Tipo_Donacion VARCHAR(40) NOT NULL,
    PRIMARY KEY (Dona_Cedula)
);

CREATE TABLE Tbl_Donacion_Recursos (
    Rec_Id INT(10) NOT NULL,
    Rec_Nombre VARCHAR(15) NOT NULL,
    Rec_Cantidad INT NOT NULL,
    Rec_Disponibilidad VARCHAR(15) NOT NULL,
    Rec_Tipo VARCHAR(10) NOT NULL,
    Rec_Descripcion VARCHAR(30) NOT NULL,
    Rec_Caso_Id VARCHAR(15) NOT NULL,
    Rec_Dona_Cedula INT(10) NOT NULL,
    PRIMARY KEY (Rec_Id),
    FOREIGN KEY (Rec_Caso_Id) REFERENCES Tbl_Caso_Donacion(Caso_Id),
    FOREIGN KEY (Rec_Dona_Cedula) REFERENCES Tbl_Donante(Dona_Cedula)
);

CREATE TABLE Tbl_Voluntarios (
    Vol_Cedula INT(10) NOT NULL,
    Vol_Nombre VARCHAR(40) NOT NULL,
    Vol_Apellido VARCHAR(40) NOT NULL,
    Vol_Correo VARCHAR(40) NOT NULL,
    Vol_Celular INT(10) NOT NULL,
    Vol_Caso_Id VARCHAR(15) NOT NULL,
    PRIMARY KEY (Vol_Cedula),
    FOREIGN KEY (Vol_Caso_Id) REFERENCES Tbl_Caso_Donacion(Caso_Id)
);

CREATE TABLE Tbl_Horarios_Voluntarios (
    Hora_Id INT(10) NOT NULL,
    Hora_Citacion DATETIME NOT NULL,
    Hora_Localizacion VARCHAR(40) NOT NULL,
    Hora_Vol_Cedula INT(10) NOT NULL,
    PRIMARY KEY (Hora_Id),
    FOREIGN KEY (Hora_Vol_Cedula) REFERENCES Tbl_Voluntarios(Vol_Cedula)
);

CREATE TABLE Tbl_Donacion_Dinero (
    Don_Id INT(10) NOT NULL,
    Don_Monto VARCHAR(20) NOT NULL,
    Don_Fecha DATE NOT NULL,
    Don_Correo VARCHAR(40) NOT NULL,
    Don_Metodo_Pago VARCHAR(40) NOT NULL,
    Don_Dona_Cedula INT(10) NOT NULL,
    Don_Caso_Id VARCHAR(15) NOT NULL,
    PRIMARY KEY (Don_Id),
    FOREIGN KEY (Don_Caso_Id) REFERENCES Tbl_Caso_Donacion(Caso_Id),
    FOREIGN KEY (Don_Dona_Cedula) REFERENCES Tbl_Donante(Dona_Cedula)
);

/* Ejemplo de inserción de datos*/
INSERT INTO Tbl_Rol (Rol_Id, Rol_Tipo) VALUES
(1, 'Administrador'),
(2, 'Fundacion');

INSERT INTO Tbl_Administrador (Admin_Id, Admin_Username, Admin_Password, Admin_Correo, Admin_Rol_Id) 
VALUES 
(001, 'admin01', 'password123', 'admin01@example.com',1),
(002, 'admin02', 'password321', 'admin02@example.com',1),
(003, 'admin03', 'password987', 'admin03@example.com',1),
(004, 'admin04', 'password888', 'admin04@example.com',1),
(005, 'admin05', 'password999','admin05@example.com',1),
(006, 'admin06', 'password000', 'admin06@example.com',1),
(007, 'admin07', 'password111', 'admin07@example.com',1);

INSERT INTO Tbl_Fundaciones (Fund_NIT, Fund_Username, Fund_Password,Fund_Correo, Fund_Direccion, Fund_Casos_Activos, Fund_Telefono, Fund_Rol_Id) 
VALUES 
(008, 'fundacion01','password555','fund01@example.com','Calle 123', 1, 1234567890, 2),
(009, 'fundacion02', 'password666','fund02@example.com','Avenida 456', 2, 2345678901, 2),
(010, 'fundacion03', 'password777','fund03@example.com','Calle 789', 2, 3456789012, 2),
(011, 'fundacion04', 'password888','fund04@example.com','Avenida 101', 1, 4567890123, 2),
(012, 'fundacion05', 'password999','fund05@example.com','Calle 205', 0, 1234567890, 2),
(013, 'fundacion06', 'password1010','fund06@example.com','Avenida 88', 0, 2345678901, 2),
(014, 'fundacion07', 'password1111','fund07@example.com','Carrera 114', 1, 3456789012, 2);


INSERT INTO Tbl_Caso_Donacion (Caso_Id, Caso_Nombre_Caso, Caso_Descripcion, Caso_Fecha_Inicio, Caso_Fecha_Fin, Caso_Estado, Caso_Fund_Id) 
VALUES 
('C001', 'Educación Infantil', 'Proveer recursos educativos a niños en zonas rurales.', '2024-01-10', '2024-12-31','Activo', 008), 
('C002', 'Dia del niño', 'Campaña de regalos para niños.', '2024-02-15', '2024-11-30','Inactivo', 009),
 ('C003', 'Alimentación Escolar', 'Proveer alimentos a escuelas en zonas marginadas.', '2024-03-20', '2024-09-30','Activo', 011),
('C004', 'Reforestación Urbana', 'Proyecto de plantación de árboles en áreas urbanas.', '2024-04-01', '2024-10-31','Activo',010),
('C005', 'Vivienda Digna', 'Construcción de viviendas para familias en situación de pobreza.', '2024-05-05', '2024-12-31','Activo', 014),
('C006', 'Atención Médica', 'Proveer atención médica gratuita en zonas rurales.', '2024-06-10', '2024-12-31','Inactivo', 009),
('C007', 'Empoderamiento Juvenil', 'Programa de capacitación laboral para jóvenes.', '2024-07-15', '2024-12-31','Inactivo', 010);

INSERT INTO Tbl_Donante (Dona_Cedula, Dona_Nombre, Dona_Nombre_Recurso, Dona_Apellido, Dona_Correo, Dona_Tipo_Donacion) 
VALUES
(2001, 'Pedro', 'Libros', 'Sánchez', 'pedro.sanchez@example.com', 'Educativa'),
(2002, 'Elena', 'Vacunas', 'Fernández', 'elena.fernandez@example.com', 'Salud'),
(2003, 'Roberto', 'Comida', 'Ramírez', 'roberto.ramirez@example.com', 'Alimentación'), 
(2004, 'Patricia', 'Árboles', 'González', 'patricia.gonzalez@example.com', 'Medio Ambiente'),
(2005, 'Miguel', 'Material de construcción', 'Torres', 'miguel.torres@example.com', 'Vivienda'),
(2006, 'Claudia', 'Medicinas', 'Vega', 'claudia.vega@example.com', 'Salud'),
(2007, 'Sergio', 'Equipos de cómputo', 'Morales', 'sergio.morales@example.com', 'Capacitación');



INSERT INTO Tbl_Voluntarios (Vol_Cedula, Vol_Nombre, Vol_Apellido, Vol_Correo, Vol_Celular, Vol_Caso_Id) 
VALUES 
(1001, 'Juan', 'Pérez', 'juan.perez@example.com', 1234567890, 'C001'), 
(1002, 'María', 'García', 'maria.garcia@example.com', 2345678901, 'C002'),
(1003, 'Luis', 'Martínez', 'luis.martinez@example.com', 3456789012, 'C003'),
(1004, 'Ana', 'Rodríguez', 'ana.rodriguez@example.com', 4567890123, 'C004'), 
(1005, 'Carlos', 'Hernández', 'carlos.hernandez@example.com', 5678901234, 'C005'), 
(1006, 'Laura', 'López', 'laura.lopez@example.com', 6789012345, 'C006'), 
(1007, 'Jorge', 'Gómez', 'jorge.gomez@example.com', 7890123456, 'C007');


INSERT INTO Tbl_Horarios_Voluntarios (Hora_Id, Hora_Citacion, Hora_Localizacion, Hora_Vol_Cedula) 
VALUES
(01, '2024-09-01 09:00:00', 'Escuela Rural', 1001),
(02, '2024-09-02 10:00:00', 'Centro Comunitario', 1002),
(03, '2024-09-03 08:00:00', 'Comedor Escolar', 1003),
(04, '2024-09-04 07:00:00', 'Parque Central', 1004),
(05, '2024-09-05 09:30:00', 'Construcción de Viviendas', 1005),
(06, '2024-09-06 08:30:00', 'Clínica Rural', 1006),
(07, '2024-09-07 11:00:00', 'Centro Juvenil', 1007);


INSERT INTO tbl_Donacion_Dinero (Don_Id,Don_Monto,Don_Fecha,Don_Correo,Don_Metodo_Pago,Don_Dona_Cedula,Don_Caso_Id) 
VALUES 
(3001, '500 USD', '2024-09-01', 'pedro.sanchez@example.com', 'Transferencia Bancaria',2001, 'C002'),
(3002, '1200 USD', '2024-09-02', 'elena.fernandez@example.com', 'PayPal', 2002 ,'C005'), 
(3003, '800 USD', '2024-09-03', 'roberto.ramirez@example.com', 'Tarjeta de Crédito', 2003 ,'C007'),
(3004, '1000 USD', '2024-09-04', 'patricia.gonzalez@example.com', 'Transferencia Bancaria', 2004 ,'C004'),
(3005, '1500 USD', '2024-09-05', 'miguel.torres@example.com', 'PayPal', 2005 ,'C004'), 
(3006, '700 USD', '2024-09-06', 'claudia.vega@example.com', 'Tarjeta de Crédito', 2006 ,'C002'), 
(3007, '950 USD', '2024-09-07', 'sergio.morales@example.com', 'Transferencia Bancaria', 2007 ,'C003');

INSERT INTO Tbl_Donacion_Recursos (Rec_Id, Rec_Nombre,Rec_Cantidad, Rec_Disponibilidad, Rec_Tipo, Rec_Descripcion,Rec_Dona_Cedula, Rec_Caso_Id) 
VALUES 
(705, 'Libros', 12,  'Disponible', 'Educación', 'Libros de texto y material educativo.',2001, 'C002'),
(818, 'Juguetes',23, 'Disponible', 'Juguetería', 'Regalos para niños.',2003 ,'C002'),
(699, 'Comida',7, 'Disponible', 'Alimentación', 'Alimentos para niños en escuelas.',2005, 'C003'),
(423, 'Árboles',3, 'Disponible', 'Medio Ambiente', 'Plantas para reforestación.',2004, 'C004'),
(672, 'Material de construcción',8, 'Disponible', 'Vivienda', 'Materiales para construir viviendas', 2007, 'C005' ),
(698, 'Medicinas',12, 'Disponible', 'Salud', 'Medicamentos para atención médica.', 2001,'C006'),
(201, 'Equipos de cómputo',2, 'Disponible', 'Capacitación', 'Computadoras para capacitación.' ,2006,'C001');


/*Procedimiento para obtener donaciones monetarias*/
DELIMITER $$
CREATE PROCEDURE ObtenerDonacionesMonetarias()
BEGIN
    SELECT 
        d.Dona_Cedula AS Cedula_Donador,
        d.Dona_Nombre AS Nombre_Donador,
        d.Dona_Apellido AS Apellido_Donador,
        dd.Don_Fecha AS Fecha_Donador,
        dd.Don_Monto AS Monto_Donado,
        dd.Don_Id AS Id_Donacion
    FROM 
        Tbl_Donante d
    INNER JOIN 
        Tbl_Donacion_Dinero dd ON d.Dona_Cedula = dd.Don_Dona_Cedula;
END$$
DELIMITER ;

/*Llamada al procedimiento*/
CALL ObtenerDonacionesMonetarias();








/*Procedimiento para obtener casos por fundación*/
DELIMITER $$
CREATE PROCEDURE ObtenerCasosPorFundacion()
BEGIN
    SELECT 
        f.Fund_Username AS NombreFundacion,
        c.Caso_Nombre_Caso AS NombreCaso,
        c.Caso_Descripcion AS DescripcionCaso,
        c.Caso_Fecha_Inicio AS FechaInicio,
        c.Caso_Fecha_Fin AS FechaFin
    FROM 
        Tbl_Caso_Donacion c
    INNER JOIN 
        Tbl_Fundaciones f ON c.Caso_Fund_Id = f.Fund_Id;
END$$
DELIMITER ;

/*Llamada al procedimiento*/
CALL ObtenerCasosPorFundacion();

/*Procedimiento para actualizar un usuario*/

DROP PROCEDURE IF EXISTS UpdateFundaciones;
DELIMITER $$
CREATE PROCEDURE UpdateFundaciones(
    IN p_Fund_NIT INT(10),
    IN p_Fund_Username VARCHAR(40),
    IN p_Fund_Password VARCHAR(20)
)
BEGIN
    UPDATE Tbl_Fundaciones
    SET Fund_Username = p_Fund_Username, 
        Fund_Password = p_Fund_Password
    WHERE Fund_NIT = p_Fund_NIT;
END$$
DELIMITER ;

/*Llamada al procedimiento*/
CALL UpdateFundaciones(141414, 'fundacion0007', 'passworddd426');

/*Procedimiento para insertar un donante*/
DELIMITER $$
CREATE PROCEDURE InsertarDonante(
    IN p_Dona_Cedula INT,
    IN p_Dona_Nombre VARCHAR(20),
    IN p_Dona_Nombre_Recurso VARCHAR(15),
    IN p_Dona_Apellido VARCHAR(40),
    IN p_Dona_Correo VARCHAR(40),
    IN p_Dona_Tipo_Donacion VARCHAR(40)
)
BEGIN
    INSERT INTO Tbl_Donante (
        Dona_Cedula,
        Dona_Nombre,
        Dona_Nombre_Recurso, 
        Dona_Apellido,
        Dona_Correo,
        Dona_Tipo_Donacion
    ) 
    VALUES (
        p_Dona_Cedula,
        p_Dona_Nombre,
        p_Dona_Nombre_Recurso,
        p_Dona_Apellido,
        p_Dona_Correo,
        p_Dona_Tipo_Donacion
    );
END$$
DELIMITER ;

/*Llamada al procedimiento*/
CALL InsertarDonante(1234567890, 'Nicolas','Arroz' , 'Salazar', 'nicolassalazar@correoejemplo.com', 'Alimentos');

/*Procedimiento para eliminar un donante*/
DELIMITER $$
CREATE PROCEDURE EliminarDonante(
    IN donante_cedula INT
)
BEGIN
    DELETE FROM Tbl_Donante 
    WHERE Dona_Cedula = donante_cedula;
END$$
DELIMITER ;

/*Vista de casos por fundación*/
CREATE VIEW View_Casos AS
SELECT 
    c.Caso_Id, 
    c.Caso_Nombre_Caso AS Caso_Nombre, 
    c.Caso_Estado, 
    f.Fund_Id, 
    f.Fund_Username
FROM 
    Tbl_Caso_Donacion c
JOIN 
    Tbl_Fundaciones f ON c.Caso_Fund_Id = f.Fund_Id;

/*Mostrar vistas en la base de datos*/
SHOW FULL TABLES WHERE table_type = 'VIEW';


/*Vista de voluntarios*/

CREATE OR REPLACE VIEW Voluntarios_cedula_nombre_apellido AS
SELECT
 Vol_Cedula,
 Vol_Nombre,
 Vol_Apellido
FROM Tbl_Voluntarios
