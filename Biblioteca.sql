USE master;
DROP DATABASE Biblioteca;
CREATE DATABASE Biblioteca;
go
USE Biblioteca;
go
--Creacion de tablas y relaciones
CREATE TABLE Sala(
    IDSala varchar(10)  not null CONSTRAINT PK_Sala PRIMARY KEY,
    Sala varchar(30) not null,
    );
go
CREATE TABLE Categoria(
    IDCategoria varchar(10)  not null CONSTRAINT PK_Categoria PRIMARY KEY,
    Categoria nvarchar(50) not null,
    );
go
CREATE TABLE Editorial(
    IDEditorial varchar(10)  not null CONSTRAINT PK_Editorial PRIMARY KEY,
    Editorial nvarchar(60) not null,
    );
go
CREATE TABLE Libro(
    IDLibro varchar(25)  not null CONSTRAINT PK_Libro PRIMARY KEY,
    Titulo nvarchar(130) not null,
    Ubicacion varchar(10) not null,
    NumEdicion varchar(60) not null,
    AñoEdicion varchar(5) not null,
    Volumen tinyint not null,
    NumPaginas int not null,
    Observaciones varchar(500) not null,
    --Llaves foraneas
    ID_Sala varchar(10) not null CONSTRAINT FK_Sala FOREIGN KEY(ID_Sala) 
    REFERENCES Sala(IDSala),
    ID_Categoria varchar(10) not null CONSTRAINT FK_Categoria FOREIGN KEY(ID_Categoria) 
    REFERENCES Categoria(IDCategoria),
    ID_Editorial varchar(10) not null CONSTRAINT FK_Editorial FOREIGN KEY(ID_Editorial) 
    REFERENCES Editorial(IDEditorial)
    );
go
CREATE TABLE Autor(
    IDAutor varchar(10)  not null CONSTRAINT PK_Autor PRIMARY KEY,
    Nombre nvarchar(40) not null,
    Apellidos nvarchar(40) not null
    );
go
CREATE TABLE LibroAutor(
    IDLibroAutor varchar(10)  not null CONSTRAINT PK_LibroAutor PRIMARY KEY,
    --Llaves foraneas
    ID_Libro varchar(25) not null CONSTRAINT FK_Libro FOREIGN KEY(ID_Libro) 
    REFERENCES Libro(IDLibro) ON DELETE CASCADE ON UPDATE CASCADE,
    ID_Autor varchar(10) not null CONSTRAINT FK_Autor FOREIGN KEY(ID_Autor) 
    REFERENCES Autor(IDAutor)
    );
go
CREATE TABLE Usuario(
    IDUsuario int identity  not null CONSTRAINT PK_Usuario PRIMARY KEY,
    Nombre nvarchar(40) not null,
    A_Paterno varchar(20) not null,
    A_Materno varchar(20) not null,
    Edad tinyint not null,
    EscuelaProcedencia nvarchar(100) null,
    --Grado varchar (10),
    Ciudad nvarchar(60) not null, --Default como --"Zacatlán"
    Calle nvarchar(100) not null,
    Telefono varchar(20) not null, 
    Email nvarchar(100) null,
    Observaciones varchar(500) not null --Estará definida como default, como "Ninguna"
    );
go
CREATE TABLE Ejemplar(
    IDEjemplar varchar(10)  not null CONSTRAINT PK_Ejemplar PRIMARY KEY,
    NumEjemplar int not null,
    --Llave foranea
    ID_Libro varchar(25) not null CONSTRAINT FK_Ejemplar_Libro FOREIGN KEY(ID_Libro) 
    REFERENCES Libro(IDLibro) ON DELETE CASCADE ON UPDATE CASCADE
    );
go
CREATE TABLE Prestamo(
    
    IDPrestamo int identity  not null CONSTRAINT PK_Prestamo PRIMARY KEY, --CAMBIARLO A INT IDENTITY
    --Llaves foraneas
    ID_Usuario int not null CONSTRAINT FK_Usuario FOREIGN KEY(ID_Usuario) 
    REFERENCES Usuario(IDUsuario),
    ID_Ejemplar varchar(10) not null CONSTRAINT FK_Ejemplar FOREIGN KEY(ID_Ejemplar) 
    REFERENCES Ejemplar(IDEjemplar),
    -------------------------------------------------
    --Cantidad tinyint not null,
    FechaPrestamo date not null,--Estará asignada automáticamente con el CONSTRAINT DEFAULT -- DF_Prestamo_FechaPrestamo
    FechaMaxDev date not null,
    Devuelto bit not null,--1 es igual a si, y 0 es igual a no . Asigando por default como 0, 
    FechaDevolucion date null,--No especificaremos nada para que por default sea null
    Observaciones varchar(500) not null
    );
go
CREATE TABLE HLibrosActualizados(
    IDLibrosActualizados int identity CONSTRAINT PK_LibrosActualizados PRIMARY KEY,
    TipoAccion varchar(20) not null,
    Usuario VARCHAR(30) not null,
    FechaModif date not null,
    IDLibro varchar(25)  not null ,
    IDLibroAnterior varchar(25)  not null ,
    Titulo nvarchar(130) not null,
    TituloAnterior nvarchar(130) not null,
    Ubicacion varchar(10) not null,
    UbicacionAnterior varchar(10) not null,
    NumEdicion varchar(60) not null,
    NumEdicionAnterior varchar(60) not null,
    AñoEdicion varchar(5) not null,
    AñoEdicionAnterior varchar(5) not null,
    Volumen tinyint not null,
    VolumenAnterior tinyint not null,
    NumPaginas int not null,
    NumPaginasAnterior int not null,
    Observaciones varchar(500) not null,
    ObservacionesAnterior varchar(500) not null,
    --Llaves foraneas
    ID_Sala varchar(10) not null,
    ID_SalaAnterior varchar(10) not null,
    ID_Categoria varchar(10) not null,
    ID_CategoriaAnterior varchar(10) not null,
    ID_Editorial varchar(10) not null,
    ID_EditorialAnterior varchar(10) not null
    );
    go
--Creacion de índices
CREATE UNIQUE INDEX Idx_Editorial ON Editorial(Editorial);
go
CREATE UNIQUE INDEX Idx_Categoria ON Categoria(Categoria);
go
CREATE UNIQUE INDEX Idx_Sala ON Sala(Sala);
go
CREATE UNIQUE INDEX Idx_Usuario_NombreCompleto ON Usuario(Nombre, A_Paterno, A_Materno);
go
CREATE UNIQUE INDEX Idx_Autor_NombreCompleto ON Autor(Nombre, Apellidos);
go
CREATE UNIQUE INDEX Idx_Ejemplar_ID_Libro ON Ejemplar(ID_Libro); 
go
CREATE UNIQUE INDEX Idx_LibroAUtor ON LibroAutor(ID_Libro,ID_Autor); 
--Creacion de CONSTRAINT
--Checks
ALTER TABLE Usuario
ADD CONSTRAINT CH_Usuario_Edad CHECK(Edad>0 and Edad <=125);
go
ALTER TABLE Ejemplar
ADD CONSTRAINT CH_Ejemplar_NumEjemplar CHECK(NumEjemplar>=0 and NumEjemplar <=500);
go
--Defaults
ALTER TABLE Libro
ADD CONSTRAINT DF_Libro_Observaciones DEFAULT 'EN PERFECTO ESTADO' FOR Observaciones
go
ALTER TABLE Usuario
ADD CONSTRAINT DF_Usuario_Ciudad DEFAULT 'ZACATLÁN' FOR Ciudad
ALTER TABLE Usuario
ADD CONSTRAINT DF_Usuario_Observaciones DEFAULT 'NINGUNA' FOR Observaciones;
go
ALTER TABLE Prestamo
ADD CONSTRAINT DF_Prestamo_FechaPrestamo DEFAULT (SYSDATETIME()) FOR FechaPrestamo;
go
ALTER TABLE Prestamo 
ADD CONSTRAINT DF_Prestamo_Devuelto DEFAULT 0 FOR Devuelto;
go
ALTER TABLE Prestamo 
ADD CONSTRAINT DF_Prestamo_FechaDevolucion DEFAULT  NULL FOR FechaDevolucion;
go
--ALTER TABLE Prestamo 
--ADD CONSTRAINT DF_Prestamo_Cantidad DEFAULT  1 FOR Cantidad;
--go
---------------------------------------------------------
--Creacion de Triggers
--agregar a la base original, script
--ELIMINAR UN EJEMPLAR
--Triger 1
CREATE TRIGGER TR_Ejemplar_AI
ON Prestamo FOR INSERT
AS
SET NOCOUNT ON
UPDATE Ejemplar set Ejemplar.NumEjemplar = Ejemplar.NumEjemplar - 1 from inserted
INNER JOIN Ejemplar ON Ejemplar.IDEjemplar = inserted.ID_Ejemplar;
go
--Triger 2
---Actualizar numero de ejemplares cuando el libro se devuelva, es decir, sumar 1 (Agregar al script original)
CREATE TRIGGER TR_Actualizar_Ejemplar_AUPDATE
ON  Prestamo FOR UPDATE
AS
SET NOCOUNT ON
BEGIN
DECLARE @LibroDevuelto bit 
SELECT @LibroDevuelto = Devuelto from inserted;
IF @LibroDevuelto = 1 
    UPDATE Ejemplar set Ejemplar.NumEjemplar = Ejemplar.NumEjemplar + 1 from inserted
    INNER JOIN Ejemplar ON Ejemplar.IDEjemplar = inserted.ID_Ejemplar
ELSE
    UPDATE Ejemplar set Ejemplar.NumEjemplar = Ejemplar.NumEjemplar - 1 from inserted
    INNER JOIN Ejemplar ON Ejemplar.IDEjemplar = inserted.ID_Ejemplar
END;
--------------------------------------------------------------------------------
--TRIGGER 3
--Respalda la información de los libros al actualizar algun dato de un libro colocandola en otra tabla
--llamada librosactualizados
--Aun falta especificar que lo haga en cada registro
go
CREATE TRIGGER TR_ACTUALIZA_LIBRO_BUPDATE
ON Libro AFTER UPDATE 
AS
SET NOCOUNT ON
DECLARE @IDLibroT varchar(25) 
DECLARE @TituloT nvarchar(130) 
DECLARE @UbicacionT varchar(10) 
DECLARE @NumEdicionT varchar(60) 
DECLARE @AñoEdicionT varchar(5) 
DECLARE @VolumenT tinyint
DECLARE @NumPaginasT int 
DECLARE @ObservacionesT varchar(500)
DECLARE @ID_SalaT varchar(10) 
DECLARE @ID_CategoriaT varchar(10) 
DECLARE @ID_EditorialT varchar(10) 
---
DECLARE @IDLibroAnterior varchar(25) 
DECLARE @TituloTAnterior nvarchar(130) 
DECLARE @UbicacionTAnterior varchar(10) 
DECLARE @NumEdicionTAnterior varchar(60) 
DECLARE @AñoEdicionTAnterior varchar(5) 
DECLARE @VolumenTAnterior tinyint
DECLARE @NumPaginasTAnterior int  
DECLARE @ObservacionesTAnterior varchar(500) 
DECLARE @ID_SalaTAnterior varchar(10) 
DECLARE @ID_CategoriaTAnterior varchar(10)
DECLARE @ID_EditorialTAnterior varchar(10) 

SELECT @IDLibroT = IDLibro from inserted
SELECT @IDLibroAnterior = IDLibro from deleted
SELECT @TituloT = Titulo from inserted
SELECT @TituloTAnterior =  Titulo from deleted
SELECT @UbicacionT = Ubicacion from inserted
SELECT @UbicacionTAnterior = Ubicacion from deleted
SELECT @NumEdicionT = NumEdicion from inserted
SELECT @NumEdicionTAnterior = NumEdicion from deleted
SELECT @AñoEdicionT= AñoEdicion from inserted
SELECT @AñoEdicionTAnterior =  AñoEdicion from deleted
SELECT @VolumenT = Volumen from inserted
SELECT @VolumenTAnterior = Volumen from deleted
SELECT @NumPaginasT = NumPaginas from inserted
SELECT @NumPaginasTAnterior = NumPaginas from deleted
SELECT @ObservacionesT = Observaciones from inserted
SELECT @ObservacionesTAnterior =  Observaciones from deleted
SELECT @ID_SalaT = ID_Sala from inserted
SELECT @ID_SalaTAnterior = ID_Sala from deleted
SELECT @ID_CategoriaT = ID_Categoria from inserted
SELECT @ID_CategoriaTAnterior = ID_Categoria from deleted
SELECT @ID_EditorialT = ID_Editorial from inserted
SELECT @ID_EditorialTAnterior = ID_Editorial from deleted

INSERT INTO HLibrosActualizados VALUES('Actualización',SYSTEM_USER,GETDATE(),@IDLibroT,@IDLibroAnterior,@TituloT,@TituloTAnterior,@UbicacionT,@UbicacionTAnterior,
                                      @NumEdicionT,@NumEdicionTAnterior,@AñoEdicionT,@AñoEdicionTAnterior,@VolumenT,@VolumenTAnterior,
                                      @NumPaginasT,@NumPaginasTAnterior,@ObservacionesT,@ObservacionesTAnterior,
                                      @ID_SalaT,@ID_SalaTAnterior,@ID_CategoriaT,@ID_CategoriaTAnterior,@ID_EditorialT,@ID_EditorialTAnterior)
----------------------------------------------------------------------------------
go
--Insertarción de  2 registros a cada tabla
INSERT INTO Sala(IDSala,Sala)
VALUES('S0001','GENERAL'),
      ('S0002','INFANTIL')
go 
INSERT INTO Categoria(IDCategoria,Categoria)
VALUES('C0001','CONSULTA'),
      ('C0002','GENERALIDADES'),
      ('C0003','FILOSOFÍA Y PSICOLOGÍA'),
      ('C0004','LITERATURA')
go
INSERT INTO Editorial(IDEditorial,Editorial)
VALUES('ED0001','PORRÚA'),
      ('ED0002','ANAGRAMA'),
      ('ED0003','OCEANO'),
      ('ED0004','PUNTO DE ENCUENTRO')
go
INSERT INTO Libro(IDLibro,Titulo,Ubicacion,NumEdicion,AñoEdicion,Volumen,NumPaginas,Observaciones,ID_Sala,ID_Categoria,ID_Editorial)
VALUES('027.009S42', 'COMO UNA NOVELA','0-100','SEGUNDA EDICIÓN','2008',1,169,'ENE PERFECTO ESTADO','S0001','C0003','ED0003'),
      ('028.9P47', 'EL LIBRO DE LAS BIBLIOTECAS','0-100','PRIMERA EDICIÓN','2000',1,169,'MALTRATADO EN LA PORTADA','S0001','C0003','ED0001'),
      ('63B349U47', 'EL ÚLTIMO VUELO','800-899','SEGUNDA EDICIÓN','2001',1,119,'EN PERFECTO ESTADO','S0001','C0004','ED0004');
go 
INSERT INTO Autor(IDAutor,Nombre,Apellidos)
VALUES('A0001', 'MAUREN','SAWA'),
      ('A0002', 'DANIEL','PENNAC'),
      ('A0003', 'ALBERTO','BASSO'),
      ('A0004', 'JESÚS','BALLAZ');
go 
INSERT INTO LibroAutor(IDLibroAutor,ID_Libro,ID_Autor)
VALUES('LA0001', '027.009S42','A0002'),
      ('LA0002', '028.9P47','A0001'),
      ('LA0003', '63B349U47','A0004');
go 
INSERT INTO Usuario(Nombre, A_Paterno, A_Materno, Edad, EscuelaProcedencia, Ciudad, Calle, Telefono, Email)
VALUES('DAVID', 'NAVA','GARCÍA',19,'CENTRO ESCOLAR','ZACATLÁN','JOSÉ MARIA MORELOS','7841261514','davidnava@gmail.com'),--'LA ÚLTIMA VEZ QUE PIDIÓ UN EJEMPLAR, LO ENTREGÓ CON UN MES DE RETRASO'),
      ('OSCAR', 'MARCOS','MÁRQUEZ',17,null,'CHIGNAHUAPAN','2 DE ABRIL','7978792516','oscarmarcos@gmail.com');
go 
INSERT INTO Ejemplar(IDEjemplar,NumEjemplar,ID_Libro)
VALUES('EJ0001',3,'027.009S42' ),
      ('EJ0002',1,'028.9P47'),
      ('EJ0003',5,'63B349U47');
go
INSERT INTO Prestamo(ID_Usuario,ID_Ejemplar,FechaMaxDev, Observaciones)
VALUES(1,'EJ0001','22/02/2022','EL LIBRO SE ENTREGÓ EN PERFECTO ESTADO'),
      (2,'EJ0003','23/05/2022','LA PORTADA DEL LIBRO SE ENTREGÓ UN POCO MALTRATADA');  
go
SELECT * FROM Ejemplar;
SELECT * FROM Prestamo; 
SELECT * FROM LibrosActualizados;
go