CREATE DATABASE Biblioteca;
go
USE Biblioteca;
go
--Creacion de tablas y relaciones
CREATE TABLE Sala(
    IDSala varchar(5)  not null PRIMARY KEY,
    Sala varchar(30) not null,
    );
go
CREATE TABLE Categoria(
    IDCategoria varchar(10)  not null PRIMARY KEY,
    Categoria nvarchar(50) not null,
    );
go
CREATE TABLE Editorial(
    IDEditorial varchar(10)  not null PRIMARY KEY,
    Editorial nvarchar(60) not null,
    );
go
CREATE TABLE Libro(
    IDLibro varchar(25)  not null PRIMARY KEY,
    Titulo nvarchar(130) not null,
    Ubicacion varchar(10) not null,
    AñoEdicion varchar(5) not null,
    Volumen tinyint not null,
    NumPaginas int not null,
    Observaciones varchar(500) not null,
    --Llaves foraneas
    ID_Sala varchar(5) not null FOREIGN KEY(ID_Sala) 
    REFERENCES Sala(IDSala),
    ID_Categoria varchar(10) not null FOREIGN KEY(ID_Categoria) 
    REFERENCES Categoria(IDCategoria),
    ID_Editorial varchar(10) not null FOREIGN KEY(ID_Editorial) 
    REFERENCES Editorial(IDEditorial)
    );
go
CREATE TABLE Autor(
    IDAutor varchar(10)  not null PRIMARY KEY,
    NombreAutor nvarchar(40) not null,
    ApellidosAutor nvarchar(40) not null
    );
go
CREATE TABLE LibroAutor(
    IDLibroAutor varchar(10)  not null PRIMARY KEY,
    --Llaves foraneas
    ID_Libro varchar(25) not null FOREIGN KEY(ID_Libro) 
    REFERENCES Libro(IDLibro),
    ID_Autor varchar(10) not null FOREIGN KEY(ID_Autor) 
    REFERENCES Autor(IDAutor)
    );
go
CREATE TABLE Usuario(
    IDUsuario int  not null PRIMARY KEY IDENTITY,
    NombreUsuario nvarchar(40) not null,
    ApellidoPaterno varchar(20) not null,
    ApellidoMaterno varchar(20) not null,
    Edad tinyint not null,
    EscuelaProcedencia nvarchar(100) null,
    Ciudad nvarchar(60) not null,
    Calle nvarchar(100) not null,
    Telefono varchar(20) not null, 
    Email nvarchar(100) null,
    Observaciones varchar(500) not null
    );
go
CREATE TABLE Ejemplar(
    IDEjemplar varchar(10)  not null PRIMARY KEY,
    NumEjemplar int not null,
    --Llave foranea
    ID_Libro varchar(25) not null FOREIGN KEY(ID_Libro) 
    REFERENCES Libro(IDLibro)
    );
go
CREATE TABLE Prestamo(
    
    IDPrestamo varchar(10)  not null PRIMARY KEY, --CAMBIARLO A INT IDENTITY
    --Llaves foraneas
    ID_Ejemplar varchar(10) not null FOREIGN KEY(ID_Ejemplar) 
    REFERENCES Ejemplar(IDEjemplar),
    ID_Usuario int not null FOREIGN KEY(ID_Usuario) 
    REFERENCES Usuario(IDUsuario),
    -------------------------------------------------
    FechaSalida date not null,
    FechaMaxDevolver date not null,
    FechaDevolucion date null,
    Observaciones varchar(500) not null
    );
---------------------------
--Insertarción de  2 registros a cada tabla
INSERT INTO Sala(IDSala,Sala)
VALUES('S1','General'),
      ('S2','Infantil')
go 
INSERT INTO Categoria(IDCategoria,Categoria)
VALUES('C1','Consulta'),
      ('C2','Generalidades'),
      ('C3','Filosofía y Psicología'),
      ('C4','LIteratura')
go
INSERT INTO Editorial(IDEditorial,Editorial)
VALUES('ED1','Porrúa'),
      ('ED2','Anagrama'),
      ('ED3','Océano'),
      ('ED4','Punto de Encuentro')
go
INSERT INTO Libro(IDLibro,Titulo,Ubicacion,AñoEdicion,Volumen,NumPaginas,Observaciones,ID_Sala,ID_Categoria,ID_Editorial)
VALUES('027.009S42', 'Como una novela','0-100','2008',1,169,'En perfecto estado','S1','C3','ED3'),
      ('028.9P47', 'El libro de las bibliotecas','0-100','2000',1,169,'Maltratado en la portada','S1','C3','ED1'),
      ('63B349U47', 'El ultimo vuelo','800-899','2001',1,119,'En perfecto estado','S1','C4','ED4');
go 
INSERT INTO Autor(IDAutor,NombreAutor,ApellidosAutor)
VALUES('A1', 'Mauren','Sawa'),
      ('A2', 'Daniel','Pennac'),
      ('A3', 'Alberto','Basso'),
      ('A4', 'Jesús','Ballaz');
go 
INSERT INTO LibroAutor(IDLibroAutor,ID_Libro,ID_Autor)
VALUES('AL1', '027.009S42','A2'),
      ('AL2', '028.9P47','A1'),
      ('AL3', '63B349U47','A4');
go 
INSERT INTO Usuario(NombreUsuario, ApellidoPaterno, ApellidoMaterno, Edad, EscuelaProcedencia, Ciudad, Calle, Telefono, Email, Observaciones)
VALUES('David', 'Nava','Garcia','19','Centro Escolar','Zacatlan','Jose Maria Morelos','7841261514','davidnava@gmail.com','La última vez que pidió un ejemplar, lo entregó con dos mesesde retraso.'),
      ('Oscar', 'Marcos','Marquez','17',null,'Zacatlan','2 de abril','7978792516','oscarmarcos@gmail.com','Ninguna')
go 
INSERT INTO Ejemplar(IDEjemplar,NumEjemplar,ID_Libro)
VALUES('EJ1',3,'027.009S42' ),
      ('EJ2',1,'028.9P47'),
      ('EJ3',5,'63B349U47')
go
INSERT INTO Prestamo(IDPrestamo,ID_Ejemplar,ID_Usuario,FechaSalida,FechaMaxDevolver,FechaDevolucion,Observaciones)
VALUES('P1','EJ1',1, '15/02/2022', '22/02/2022', '19/02/22','El libro se entregó en perfecto estado'),
    ('P2','EJ3',2, '16/05/2022', '23/05/2022', '20/05/22','La portada del libro se entregó un poco maltratada')  
go
SELECT * FROM Usuario; 