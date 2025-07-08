CREATE DATABASE KAVE_Sys;
USE KAVE_Sys;
/*DROP DATABASE KAVE_Sys;*/


/*Tabla de Usuario*/
CREATE TABLE Usuario (
ID_Usuario VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
ApellidoPaterno VARCHAR(50) NOT NULL,
ApellidoMaterno VARCHAR(50) NOT NULL,
CorreoElectronico VARCHAR(50) NOT NULL,
Tipo VARCHAR(50) NOT NULL,
CONSTRAINT PK_Usuario PRIMARY KEY(ID_Usuario) 
);

/*Tabla de Categoría*/
CREATE TABLE Categoria (
ID_Categoria VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
ID_CategoriaPadre VARCHAR(10) NULL,
CONSTRAINT PK_Categoria PRIMARY KEY(ID_Categoria),
CONSTRAINT FK_Categoria_Categoria FOREIGN KEY (ID_CategoriaPadre) REFERENCES Categoria(ID_Categoria)
);

/*Tabla Producto del Inventario*/
CREATE TABLE ProductoInventario (
ID_Inventario VARCHAR(10),
Descripcion VARCHAR(50) NOT NULL,
ID_Categoria VARCHAR(10) NOT NULL,
CONSTRAINT PK_ProductoInventario PRIMARY KEY(ID_Inventario),
CONSTRAINT FK_ProductoInventario_Categoria FOREIGN KEY(ID_Categoria) REFERENCES Categoria(ID_Categoria) 
);

/*Tabla de Configuración del Producto*/
CREATE TABLE ConfiguracionProducto (
ID_ConfiguracionProducto VARCHAR(10),
ID_Inventario VARCHAR(10),
ExistenciasMinimas INT NOT NULL,
ExistenciasMaximas INT NOT NULL,
CONSTRAINT PK_ConfiguracionProducto PRIMARY KEY(ID_ConfiguracionProducto),
CONSTRAINT FK_ConfiguracionProducto_ProductoInventario FOREIGN KEY(ID_Inventario) REFERENCES ProductoInventario(ID_Inventario) 
);

/*Tabla de Movimiento*/
CREATE TABLE Movimiento (
ID_Movimiento VARCHAR(10),
ID_Usuario VARCHAR(10),
ID_Inventario VARCHAR(10),
Fecha DATE NOT NULL,
TipoMovimiento VARCHAR(10) NOT NULL,
Cantidad INT NOT NULL,
CONSTRAINT CH_Movimiento_TipoMovimiento CHECK (TipoMovimiento IN ('Entrada','Salida') ),
CONSTRAINT PK_Movimiento PRIMARY KEY(ID_Movimiento, ID_Usuario, ID_Inventario),
CONSTRAINT FK_Movimiento_Usuario FOREIGN KEY(ID_Usuario) REFERENCES Usuario(ID_Usuario),
CONSTRAINT FK_Movimiento_Inventario FOREIGN KEY(ID_Inventario) REFERENCES ProductoInventario(ID_Inventario)
);


/*Tabla de País*/
CREATE TABLE Pais (
ID_Pais VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
CONSTRAINT PK_Pais PRIMARY KEY(ID_Pais)
);

/*Tabla de Estado*/
CREATE TABLE Estado (
ID_Estado VARCHAR(10),
ID_Pais VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
CONSTRAINT PK_Estado PRIMARY KEY(ID_Estado),
CONSTRAINT FK_Estado_Pais FOREIGN KEY(ID_Pais) REFERENCES Pais(ID_Pais)
);

/*Tabla de Municipio*/
CREATE TABLE Municipio (
ID_Municipio VARCHAR(10),
ID_Estado VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
CONSTRAINT PK_Municipio PRIMARY KEY(ID_Municipio),
CONSTRAINT FK_Municipio_Estado FOREIGN KEY(ID_Estado) REFERENCES Estado(ID_Estado)
);

/*Tabla de Localidad*/
CREATE TABLE Localidad (
ID_Localidad VARCHAR(10),
ID_Municipio VARCHAR(10),
Nombre VARCHAR(50) NOT NULL,
CONSTRAINT PK_Localidad PRIMARY KEY(ID_Localidad),
CONSTRAINT FK_Localidad_Municipio FOREIGN KEY(ID_Municipio) REFERENCES Municipio(ID_Municipio)
);

/*Tabla de Proveedor*/
CREATE TABLE Proveedor (
RFC VARCHAR(12),
RazonSocial VARCHAR(50) NOT NULL,
Telefono VARCHAR(20) NOT NULL,
CorreoElectronico VARCHAR(50) NOT NULL,
Calle VARCHAR(50) NOT NULL,
Numero INT NOT NULL,
Fraccionamiento VARCHAR(50) NOT NULL,
CodigoPostal INT NOT NULL,
ID_Localidad VARCHAR(10) NOT NULL,
CONSTRAINT PK_Proveedor PRIMARY KEY(RFC),
CONSTRAINT FK_Proveedor_Localidad FOREIGN KEY(ID_Localidad) REFERENCES Localidad(ID_Localidad)
);


/*Tabla del Producto Fabricado*/
CREATE TABLE ProductoFabricado (
Clave VARCHAR(15),
ID_Inventario VARCHAR(10),
Piezas INT NOT NULL,
Precio DECIMAL(10, 2) NOT NULL, 
Existencias INT NOT NULL, 
CONSTRAINT PK_ProductoInventario PRIMARY KEY(Clave, ID_Inventario),
CONSTRAINT FK_ProductoInventario_Inventario FOREIGN KEY(ID_Inventario) REFERENCES ProductoInventario(ID_Inventario)
);

/*Tabla de Materia Prima*/
CREATE TABLE MateriaPrima (
ID_MateriaPrima VARCHAR(10),
ID_Inventario VARCHAR(10),
CONSTRAINT PK_MateriaPrima PRIMARY KEY(ID_MateriaPrima, ID_Inventario),
CONSTRAINT FK_MateriaPrima_Inventario FOREIGN KEY(ID_Inventario) REFERENCES ProductoInventario(ID_Inventario)
);

/*Tabla de Proveedor_MateriaPrima*/
CREATE TABLE Proveedor_MateriaPrima (
ID_Inventario VARCHAR(10),
ID_MateriaPrima VARCHAR(10),
RFC_Proveedor VARCHAR(12),
Costo INT NOT NULL,
Existencias INT NOT NULL,
CONSTRAINT PK_MateriaPrima PRIMARY KEY(ID_Inventario, ID_MateriaPrima, RFC_Proveedor),
CONSTRAINT FK_ProveedorMateriaPrima_MateriaPrima FOREIGN KEY(ID_MateriaPrima, ID_Inventario) REFERENCES MateriaPrima(ID_MateriaPrima, ID_Inventario),
CONSTRAINT FK_ProveedorMateriaPrima_Proveedor FOREIGN KEY(RFC_Proveedor) REFERENCES Proveedor(RFC)
);