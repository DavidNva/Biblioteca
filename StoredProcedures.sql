USE Biblioteca
go
----------------------------------------------------SALA------------------------------------------------------------------------
--************************* Autogenerar Codigo Sala***********************************
CREATE PROCEDURE sp_RegistrarSala ( @NombreSala varchar(30)) --Generar codigo autoomaticamente e hacer demas inserciones --Hay un indice unico para sala
AS
BEGIN
  DECLARE @CodSala VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDSala),4 ) + 1 FROM Sala;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodSala = CONCAT('S',RIGHT(CONCAT('0000',@Cod),4));
        INSERT INTO Sala VALUES (@CodSala,@NombreSala)
END
go
--*************************** Actualizar Sala *********************************** 
CREATE PROCEDURE sp_ActualizarSala
@IDSalaSP varchar(10),
@SalaSP varchar(30)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Sala WHERE Sala =@SalaSP and IdSala != @IdSalaSP)
	UPDATE Sala SET Sala = @SalaSP WHERE IDSala = @IDSalaSP;
END;
go
---------------------------------------------------CATEGORIA-------------------------------------------------------------------
--************************* Autogenerar Codigo Categoria*******************************
CREATE PROCEDURE sp_RegistrarCategoria ( @NombreCategoria varchar(50)) --Generar codigo autoomaticamente e hacer demas inserciones -Hay un indice unico para categoria
AS
BEGIN
  DECLARE @CodCategoria VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDCategoria),4 ) + 1 FROM Categoria;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodCategoria = CONCAT('C',RIGHT(CONCAT('0000',@Cod),4));
        INSERT INTO Categoria VALUES (@CodCategoria,@NombreCategoria)
END
go
--*************************** Actualizar Categoria*********************************** 
CREATE PROCEDURE sp_ActualizarCategoria
@IDCategoriaSP varchar(10),
@CategoriaSP varchar(50)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Categoria WHERE Categoria =@CategoriaSP and IdCategoria != @IdCategoriaSP)
	UPDATE Categoria SET Categoria = @CategoriaSP WHERE IDCategoria = @IDCategoriaSP;
END;
go
---------------------------------------------------Editorial-------------------------------------------------------------------
--************************* Autogenerar Codigo Editorial*******************************
CREATE PROCEDURE sp_RegistrarEditorial ( @NombreEditorial varchar(60)) --Generar codigo autoomaticamente e hacer demas inserciones -Hay un indice unico para editorial
AS
BEGIN
  DECLARE @CodEditorial VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDEditorial),4 ) + 1 FROM Editorial;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodEditorial = CONCAT('ED',RIGHT(CONCAT('0000',@Cod),4));--Al tener dos letras, cambia el numero a recorrer a 3
        INSERT INTO Editorial VALUES (@CodEditorial,@NombreEditorial)
END
go
--*************************** Actualizar Editorial*********************************** 
CREATE PROCEDURE sp_ActualizarEditorial
@IDEditorialSP varchar(10),
@EditorialSP varchar(60)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Editorial WHERE Editorial =@EditorialSP and IdEditorial != @IdEditorialSP)
	UPDATE Editorial SET Editorial = @EditorialSP WHERE IDEditorial = @IDEditorialSP;
END;
go
---------------------------------------------------Autor------------------------------------------------------------------------
--************************* Autogenerar Codigo Autor *******************************
CREATE PROCEDURE sp_RegistrarAutor ( @NombreAutor varchar(40), @ApellidosAutor varchar(40)) --Hay un indice unico para el nombre completo de autor
AS
BEGIN
  DECLARE @CodAutor VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDAutor),4 ) + 1 FROM Autor;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodAutor = CONCAT('A',RIGHT(CONCAT('0000',@Cod),4));
        INSERT INTO Autor VALUES (@CodAutor,@NombreAutor,@ApellidosAutor)
END
go
--*************************** Actualizar Autor*********************************** 
CREATE PROCEDURE sp_ActualizarAutor
@IDAutorSP varchar(10),
@NombreAutorSP varchar(40),
@ApellidosSP varchar(40)
AS
BEGIN--EJemplo anterior
--IF NOT EXISTS (SELECT * FROM Editorial WHERE Editorial =@EditorialSP and IdEditorial != @IdEditorialSP)
IF EXISTS (SELECT *  FROM Autor WHERE IDAutor = @IdAutorSP )
  BEGIN
	UPDATE Autor SET 
  Nombre = @NombreAutorSP,
  Apellidos = @ApellidosSP
   WHERE IDAutor = @IDAutorSP;
  END
END;
go
---------------------------------------------------Usuario--------------------------------------------------------------
--************************* Registrar Usuario *******************************
CREATE PROCEDURE sp_RegistrarUsuario( 
    --@IDUsuario int,
    @Nombre nvarchar(40),
    @A_Paterno varchar(20),
    @A_Materno varchar(20),
    @Edad tinyint,
    @EscuelaProcedencia nvarchar(100),
    --Grado varchar (10),
    --/* @Ciudad*/ --Definida Default como --"Zacatlán"
    @Calle nvarchar(100),
    @Telefono varchar(20), 
    @Email nvarchar(100)
    --posiblemente agregar el fk de tipo de persona
   -- @Observaciones varchar(500) --Estará definida como default, como "Ninguna"
  )--TERMINAN LOS PARAMETROS
AS
BEGIN
IF @EscuelaProcedencia IS NULL
   BEGIN
      SET @EscuelaProcedencia = 'NINGUNA';
   END
   INSERT INTO Usuario (Nombre, A_Paterno, A_Materno, Edad, EscuelaProcedencia, Calle, Telefono, Email)
                VALUES (@Nombre, @A_Paterno, @A_Materno, @Edad, @EscuelaProcedencia,@Calle, @Telefono, @Email)--/* @Ciudad*/ --Posible Default como --"Zacatlán"
END
go
--*************************** Actualizar Usuario*********************************** 
CREATE PROCEDURE sp_ActualizarUsuario(--Hay un indice unico para el nombre completo del usuario 
    @IDUsuarioSP int,
    @NombreUsuarioSP nvarchar(40),
    @A_PaternoSP varchar(20),
    @A_MaternoSP varchar(20),
    @EdadSP tinyint,
    @EscuelaProcedenciaSP nvarchar(100),
    --Grado varchar (10),
    @CiudadSP varchar(60), 
    @CalleSP nvarchar(100),
    @TelefonoSP varchar(20), 
    @EmailSP nvarchar(100),
    @ObservacionesSP nvarchar(100)
)
AS
BEGIN--EJemplo anterior
--IF NOT EXISTS (SELECT * FROM Usuario WHERE Email =@EmailSP and IdUsuario != @IdUsuarioSP)
IF EXISTS (SELECT *  FROM Usuario WHERE IDUsuario = @IdUsuarioSP )
  BEGIN
	UPDATE Usuario SET 
  Nombre = @NombreUsuarioSP,
  A_Paterno = @A_PaternoSP,
  A_Materno = @A_MaternoSP,
  Edad = @EdadSP,
  EscuelaProcedencia = @EscuelaProcedenciaSP,
    --Grado varchar (10),
  Ciudad = @CiudadSP, 
  Calle = @CalleSP,
  Telefono = @TelefonoSP, 
  Email = @EmailSP,
  OBservaciones = @ObservacionesSP
  WHERE IDUsuario = @IDUsuarioSP;
  END
END;
go
---------------------------------------------------Ejemplar------------------------------------------------------------
--************************* Autogenerar Codigo Ejemplar y registrar*******************************
CREATE PROCEDURE sp_RegistrarEjemplar (--Hay un indice unico para validar el idlibro
  @NumEjemplar int,
  @ID_Libro_EJ varchar(25)
  ) --Generar codigo autoomaticamente e hacer demas inserciones
AS
BEGIN
  DECLARE @CodEjemplar VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDEjemplar),4 ) + 1 FROM Ejemplar;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodEjemplar = CONCAT('EJ',RIGHT(CONCAT('0000',@Cod),4));--Al tener dos letras, cambia el numero a recorrer a 3
        INSERT INTO Ejemplar VALUES (@CodEjemplar,@NumEjemplar,@ID_Libro_EJ)
END
go
--*************************** Actualizar Ejemplar*********************************** 
CREATE PROCEDURE sp_ActualizarEjemplar(
@IDEjemplarSP varchar(10),
@NumEjemplarSP int,
@ID_Libro_EJSP varchar(25)
)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM Ejemplar WHERE ID_Libro =@ID_Libro_EJSP and IdEJemplar != @IDEjemplarSP)
	UPDATE Ejemplar SET
  NumEjemplar = @NumEjemplarSP,
  ID_Libro = @ID_Libro_EJSP
  WHERE IDEjemplar = @IDEjemplarSP;
END;
--------------------------------------------------Prestamo------------------------------------------------------------
go
--************************* Registrar prestamo ********************************
CREATE PROCEDURE sp_RegistrarPrestamo (
   --@IDPrestamo int,
   @ID_Usuario int,
   @ID_Ejemplar varchar(10),
   --@FechaPrestamo date,--Estará asignada automáticamente con el CONSTRAINT DEFAULT -- DF_Prestamo_FechaPrestamo
   @FechaMaxDev date,
   --@Devuelto bit,--1 es igual a si, y 0 es igual a no . Asigando por default como 0, 
   --@FechaDevolucion date,--No especificaremos nada para que por default sea null
   @Observaciones varchar(500) 
   ) 
AS
BEGIN
  INSERT INTO Prestamo (ID_Usuario,ID_Ejemplar,FechaMaxDev, Observaciones) 
                VALUES (@ID_Usuario,@ID_Ejemplar,@FechaMaxDev,@Observaciones)
END
go
--*************************** Actualizar Prestamo Completo*********************************** 
CREATE PROCEDURE sp_ActualizarPrestamo(
   @IDPrestamoSP int,
   @ID_UsuarioSP int,
   @ID_EjemplarSP varchar(10),
   @FechaPrestamoSP date,--Estará asignada automáticamente con el CONSTRAINT DEFAULT -- DF_Prestamo_FechaPrestamo
   @FechaMaxDevSP date,
   @DevueltoSP bit,--1 es igual a si, y 0 es igual a no . Asigando por default como 0, 
   @FechaDevolucionSP date,--No especificaremos nada para que por default sea null
   @ObservacionesSP varchar(500) 
  ) 
AS
BEGIN
  IF EXISTS (SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoSP )
    IF @DevueltoSP = 1
    BEGIN
	   UPDATE Prestamo SET 
       ID_Usuario = @ID_UsuarioSP,
       ID_Ejemplar = @ID_EjemplarSP,
       FechaPrestamo = @FechaPrestamoSP,--Estará asignada automáticamente con el CONSTRAINT DEFAULT -- DF_Prestamo_FechaPrestamo
       FechaMaxDev = @FechaMaxDevSP,
       Devuelto = @DevueltoSP,--1 es igual a si, y 0 es igual a no . Asigando por default como 0, 
       FechaDevolucion = @FechaDevolucionSP,--No especificaremos nada para que por default sea null
       Observaciones = @ObservacionesSP 
     WHERE IDPrestamo = @IDPrestamoSP;
    END
 ELSE --(SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoDSP)--(SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoDSP AND Devuelto = 1)
    BEGIN
	   UPDATE Prestamo SET 
       ID_Usuario = @ID_UsuarioSP,
       ID_Ejemplar = @ID_EjemplarSP,
       FechaPrestamo = @FechaPrestamoSP,--Estará asignada automáticamente con el CONSTRAINT DEFAULT -- DF_Prestamo_FechaPrestamo
       FechaMaxDev = @FechaMaxDevSP,
       Devuelto = @DevueltoSP,--1 es igual a si, y 0 es igual a no . Asigando por default como 0, 
       FechaDevolucion = NULL,--No especificaremos nada para que por default sea null
       Observaciones = @ObservacionesSP  
     WHERE IDPrestamo = @IDPrestamoSP;
    END
END;
go
--*************************** Actualizar Prestamo Devuelto con la fecha*********************************** 
CREATE PROCEDURE sp_ActualizarPrestamoDevYFecha( --Servira cuando se devuelva un libro, donde obviamente debemos ingresar la fechaDev
@IDPrestamoDSP varchar(10),
@DevueltoSiNoSP bit,
@FechaDevolucionDSP date
)
AS
BEGIN
  IF EXISTS (SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoDSP)
    IF @DevueltoSiNoSP = 1
    BEGIN
	   UPDATE Prestamo SET 
     Devuelto = @DevueltoSiNoSP,
     FechaDevolucion = @FechaDevolucionDSP 
     WHERE IDPrestamo = @IDPrestamoDSP;
    END
 ELSE --(SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoDSP)--(SELECT *  FROM Prestamo WHERE IDPrestamo = @IdPrestamoDSP AND Devuelto = 1)
    BEGIN
	   UPDATE Prestamo SET 
     Devuelto = @DevueltoSiNoSP,
     FechaDevolucion = NULL 
     WHERE IDPrestamo = @IDPrestamoDSP;
    END
END;
go
---------------------------------------------------Libro Autor------------------------------------------------------------
--************************* Autogenerar Codigo LibroAutor*******************************
CREATE PROCEDURE sp_RegistrarLibroAutor ( --Hay un indice unico compuesto de los dos valores
  @ID_Libro_LA varchar(25),
  @ID_Autor varchar(10)
  ) --Generar codigo autoomaticamente e hacer demas inserciones
AS
BEGIN
  DECLARE @CodLibroAutor VARCHAR(10), @Cod int
  SELECT @Cod = RIGHT(MAX(IDLibroAutor),4 ) + 1 FROM LibroAutor;--Estamos seleccionando los numeros
    IF @Cod IS NULL --Pero si en inicio no hay ningun dato
      BEGIN  
        SElECT @Cod = 1; --Entonces asignamos como primer numero = 1
      END
        SELECT @CodLibroAutor = CONCAT('LA',RIGHT(CONCAT('0000',@Cod),4));--Al tener dos letras, cambia el numero a recorrer a 3
        INSERT INTO LibroAutor VALUES (@CodLibroAutor, @ID_Libro_LA, @ID_Autor)
END
go
--*************************** Actualizar LibroAutor*********************************** 
CREATE PROCEDURE sp_ActualizarLibroAutor 
@IDLibroAutorSP varchar(10),
@ID_Libro_LASP varchar(60),
@ID_Autor_LASP varchar(60)
AS
BEGIN--EJemplo anterior
--IF NOT EXISTS (SELECT * FROM Editorial WHERE Editorial =@EditorialSP and IdEditorial != @IdEditorialSP)
IF EXISTS (SELECT *  FROM LibroAutor WHERE IDLibroAutor = @IdLibroAutorSP )
  BEGIN
	UPDATE LibroAutor SET 
  ID_Libro = @ID_LIBRO_LASP,
  ID_Autor = @ID_Autor_LASP
   WHERE IDLibroAutor = @IDLibroAutorSP;
  END
END;
go
------------------------------------------------------Libro----------------------------------------------------------
--************************* Registrar Libro ********************************
CREATE PROCEDURE sp_RegistrarLibro (
    @IDLibro varchar(25),
    @Titulo nvarchar(130),
    @Ubicacion varchar(10),
    @NumEdicion varchar(60),
    @AñoEdicion varchar(5),
    @Volumen tinyint,
    @NumPaginas int,
   -- @Observaciones varchar(500), --Definido como default: EN PERFECTO ESTADO
    --Llaves foraneas
    @ID_Sala varchar(10),
    @ID_Categoria varchar(10),
    @ID_Editorial varchar(10)
   ) 
AS
BEGIN
  INSERT INTO Libro(IDLibro, Titulo, Ubicacion, NumEdicion, AñoEdicion, Volumen, NumPaginas,
                        ID_Sala, ID_Categoria, ID_Editorial)
                VALUES (@IDLibro, @Titulo, @Ubicacion, @NumEdicion, @AñoEdicion, @Volumen, @NumPaginas,
                        @ID_Sala, @ID_Categoria, @ID_Editorial)
END
go
--*************************** Actualizar Libro Completo*********************************** 
CREATE PROCEDURE sp_ActualizarLibro(--Actualiza todos los campos, menos el ID
    @IDLibroSP varchar(25),
    @TituloSP nvarchar(130),
    @UbicacionSP varchar(10),
    @NumEdicionSP varchar(60),
    @AñoEdicionSP varchar(5),
    @VolumenSP tinyint,
    @NumPaginasSP int,
    @Observaciones varchar(500), --Definido como default: EN PERFECTO ESTADO
    --Llaves foraneas
    @ID_SalaSP varchar(10),
    @ID_Categoria varchar(10),
    @ID_Editorial varchar(10) 
  ) 
AS
BEGIN --EJemplo anterior
 --IF NOT EXISTS (SELECT * FROM Editorial WHERE Editorial =@EditorialSP and IdEditorial != @IdEditorialSP)
  IF EXISTS (SELECT *  FROM Libro WHERE IDLibro = @IdLibroSP )
    BEGIN
	    UPDATE Libro SET 
       Titulo = @TituloSP,
       Ubicacion = @UbicacionSP,
       NumEdicion = @NumEdicionSP,
       AñoEdicion = @AñoEdicionSP,
       Volumen = @VolumenSP,
       NumPaginas = @NumPaginasSP,
       Observaciones = @Observaciones, --Definido como default: EN PERFECTO ESTADO
    --Llaves foraneas
       ID_Sala = @ID_SalaSP,
       ID_Categoria = @ID_Categoria,
       ID_Editorial = @ID_Editorial 
      WHERE IDLibro = @IDLibroSP;
    END
END;
go
--*************************** Actualizar CodigoLibro *********************************** 
CREATE PROCEDURE sp_ActualizarCodigoLibro(--Actualiza todos los campos, menos el ID
    @IDLibro_CodigoSP varchar(25),--En este se indica el codigo actual del libro para identificar la actualizacion
    @IDLibroActualizarSP varchar(25) --En este se indica el nuevo codigo o ID para el libro
  ) 
AS
BEGIN 
  IF EXISTS (SELECT *  FROM Libro WHERE IDLibro = @IdLibro_CodigoSP )
    BEGIN
	    UPDATE Libro SET IDLibro = @IDLibroActualizarSP WHERE IDLibro = @IDLibro_CodigoSP;
    END
END;
go
----------------------------------------------------------------------------------