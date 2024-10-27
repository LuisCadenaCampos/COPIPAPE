
CREATE DATABASE COPIPAPE
USE COPIPAPE

CREATE TABLE CategoriaP(
	IDCategoria INT,
	NombreCategoria VARCHAR(40),
	Descripcion VARCHAR(70)
	--Llave primaria de CategoriaProductos
	CONSTRAINT PK_IDCategoria PRIMARY KEY (IDCategoria)
)


CREATE TABLE SUBCategoriaP(
	IDSubcategoria INT,
	IDCategoria INT NOT NULL,
	SubCatNombre VARCHAR(50), 
	DescripcionSubCat VARCHAR(100),
	---Llave primaria de SUBCategoriaP
	CONSTRAINT PK_IDSubcategoria PRIMARY KEY(IDSubcategoria),
	--Llave foranea de  SUBCateogoriaP
	CONSTRAINT FK_IDCategoria FOREIGN KEY (IDCategoria) REFERENCES CategoriaP(IDCategoria)
)



CREATE TABLE Proveedor(
	IDProveedor INT,
	NombreProveedor Varchar(30) NOT NULL,
	NombreContacto VARCHAR(30) NOT NULL,
	TituloContacto  VARCHAR(80) NOT NULL,
	Pais VARCHAR(3) NOT NULL, 
	EntidadFederativa VARCHAR (60) NOT NULL,
	Ciudad VARCHAR(50) NOT NULL,
	Dirección VARCHAR(200) NOT NULL,
	CP VARCHAR (5) NOT NULL ,
	Telefono VARCHAR(10),
	CorreoE VARCHAR (25),
	------LLAVE PRIMARIA
	CONSTRAINT PK_IDFabricante PRIMARY KEY (IDProveedor)
)

CREATE TABLE Productos(
	IDProducto INT,
	NombreP VARCHAR (90) NOT NULL,
	Descripcion VARCHAR(300) NOT NULL,
	DiasGarantia INT,
	IDCategoria INT NOT  NULL,
	IDSubCategoria INT NOT NULL,
	IDProveedor INT NOT NULL,
	PrecioUnitario DECIMAL(10,2) NOT NULL,
	UnidadesEnAlmacen INT NOT NULL,
	UnidadesApartadas INT NOT NULL,
	EnExistencias BIT,  --1 PARA DECIR QUE HAY EXISTENCIA DEL ARTICULO -- 0 PARA DECIR QUE NO HAY ARTICULOS
	Descontinuado BIT NOT NULL,  --0 PARA DECIR QUE NO ESTA DESCONTINUADO - 1 PARA DECIR QUE ESTA DESCONTINUADO
	--Llave primaria de IDProducto
	CONSTRAINT PK_IDProducto PRIMARY KEY (IDProducto),
	--Llaves foraneas 
	CONSTRAINT FK_IDCategoria_Productos FOREIGN KEY (IDCategoria) REFERENCES CategoriaP(IDCategoria),
	CONSTRAINT FK_IDSubCategoria_Productos FOREIGN KEY (IDSubCategoria) REFERENCES SUBCategoriaP(IDSubcategoria),
	CONSTRAINT FK_IDProveedor_Productos FOREIGN KEY (IDProveedor)  REFERENCES Proveedor(IDProveedor)
)

CREATE TABLE CategoriaE( 
	IDCatEmp INT,
	NombCat VARCHAR(35) NOT NULL,
	NombCatDescp VARCHAR(70) NOT NULL,
	--CREAMOS PRIMARY KEY
	CONSTRAINT PK_IDCatEmp PRIMARY KEY(IDCatEmp)
)


CREATE TABLE Empleado(
	IDEmpleado INT,
	IDCatEmp INT NOT NULL,
	Estatus BIT NOT NULL, --1 Para Activo , 0 para inactivo
	NombreEmp VARCHAR(30) NOT NULL,
	ApPat VARCHAR(30) NOT NULL,
	ApMat VARCHAR(30) NOT NULL,
	RFC VARCHAR(13) UNIQUE NOT NULL,
	FechaNac DATE,
	EdadContratacion INT NULL,
	FechaContratacion DATE NOT NULL,
	FechaRenunciaDespido DATE NULL,
	CP VARCHAR(5) NOT NULL,
	Pais VARCHAR(3) NOT NULL, 
	EntidadFederativa VARCHAR (60) NOT NULL,
	Ciudad VARCHAR(60) NOT NULL,
	Dirección VARCHAR(200) NOT NULL,
	Telefono VARCHAR(10) UNIQUE NULL,
	CorreoE VARCHAR (25) UNIQUE NULL,
	Salario DECIMAL(10,2) NOT NULL CHECK (Salario >= 5393.50),
	Genero VARCHAR(1) NOT NULL CHECK (Genero = 'M' OR Genero = 'F')
	--CREAR LLAVE PRIMARIA 
	CONSTRAINT PK_IDEmpleado PRIMARY KEY (IDEmpleado),
	--CREAMOS LLAVE FORANEA
	CONSTRAINT FK_IDCatEmp FOREIGN KEY (IDCatEmp) REFERENCES CategoriaE(IDCatEmp)
)


CREATE TABLE CatClientes(
	IDCatCliente INT, 
	NombCatCliente VARCHAR(40) NOT NULL,
	DescripcionCatCliente VARCHAR(80) NOT NULL,
	---CREAMOS LA LLAVE PRIMARIA
	CONSTRAINT PK_IDCatCliente PRIMARY KEY (IDCatCliente)
)



CREATE TABLE Clientes(
	IDCliente INT,
	IDCatCliente INT,
	NombCliente VARCHAR(30),
	ApPatCliente VARCHAR(30),
	ApMatCliente VARCHAR(30),
	NomCompania VARCHAR(60) NULL,
	RFC VARCHAR(13) UNIQUE NOT NULL,
	CP VARCHAR(5) NOT NULL,
	Pais VARCHAR(3), 
	EntidadFederativa VARCHAR (60),
	Ciudad VARCHAR(60),
	Dirección VARCHAR(200),
	Telefono VARCHAR(10),
	CorreoE VARCHAR(30)
	--CREAMOS PRIMARY KEY
	CONSTRAINT PK_IDClietne PRIMARY KEY(IDCliente)
	--CREAMOS LA LLAVE FORANEA
	CONSTRAINT FK_IDCatCliente FOREIGN KEY (IDCatCliente) REFERENCES  CatClientes(IDCatCliente)
)


CREATE TABLE FormasPago(
	IDFormaPago INT,
	NombreFormaPago VARCHAR(60) NOT NULL,
	DescripcionFPago VARCHAR(60) NOT NULL,
	--CREAMOS PRIMARY KEY 
	CONSTRAINT PK_IDFormaPago PRIMARY KEY(IDFormaPago)
)

CREATE TABLE Ventas(
	IDVenta INT,
	IDEmpleado INT NOT NULL,
	IDCliente INT NOT NULL,
	FechaVta DATETIME NOT NULL,
	IDFormaPago INT NOT NULL,
	--CREAMOS PRIMARY KEY
	CONSTRAINT PK_IDVenta PRIMARY KEY (IDVenta),
	--CREAMOS FOREIGN KEY 
	CONSTRAINT FK_IDEmpleado FOREIGN KEY(IDEmpleado) REFERENCES Empleado(IDEmpleado),
	CONSTRAINT FK_IDFormaPago FOREIGN KEY(IDFormaPago) REFERENCES FormasPago(IDFormaPago),
	CONSTRAINT FK_IDCliente FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente)
	
)

CREATE TABLE VentasD(
	IDVenta INT NOT NULL,
	IDProducto INT NOT NULL,
	PrecioUnit DECIMAL(10,2) NOT NULL,
	Cantidad INT NOT NULL,
	Descuento DECIMAL(10,2),
	---CREAMOS LAS LLAVES FORANEAS 
	CONSTRAINT FK_IDVenta FOREIGN KEY(IDVenta) REFERENCES Ventas(IDVenta),
	CONSTRAINT FK_IDProducto FOREIGN KEY(IDProducto) REFERENCES Productos(IDProducto)
)


CREATE TABLE Empresa(
	RSocial VARCHAR(40) NOT NULL,
	NComercial VARCHAR(50) NOT NULL, 
	TipoEmpresa VARCHAR(40) NOT NULL, 
	Pais VARCHAR(30) NOT NULL,
	EntidadFederativa VARCHAR(40) NOT NULL, 
	Direccion VARCHAR(80) NOT NULL, 
	CP VARCHAR(5) NOT NULL,
	PaginaE VARCHAR(100) NOT NULL,
	Telefono VARCHAR(10) NOT NULL,
	IDEmpleado INT NOT NULL,
	NomRepresentanteLegal VARCHAR(100) NOT NULL,
	NumEmpleados INT NOT NULL
	---CREAMOS LA LLAVE FORANTE QUE VA A SER REFERENCIA A LA TABLA DE EMPLEADOS 
	CONSTRAINT FK_Empresa_IDEmpleado FOREIGN KEY (IDEmpleado)  REFERENCES Empleado(IDEmpleado)
)
