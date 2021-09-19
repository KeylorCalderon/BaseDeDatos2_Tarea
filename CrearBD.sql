CREATE TABLE Clientes
(ID INT PRIMARY KEY,
 nombre VARCHAR(50),
 apellidos VARCHAR(50),
 fechaNacimiento DATE,
 activo BIT
);

CREATE TABLE Vehiculos
(ID SERIAL NOT NULL PRIMARY KEY,
 marca VARCHAR(50),
 modelo VARCHAR(50),
 color VARCHAR(50),
 capacidad INT,
 precio DECIMAL(10,2),
 cantidad INT,
 activo BIT
);

CREATE TABLE Telefonos
(ID SERIAL NOT NULL PRIMARY KEY,
 telefono INT,
 ClienteID INT,
 FOREIGN KEY(ClienteID) REFERENCES Clientes(ID)
);

CREATE TABLE Correos
(ID SERIAL NOT NULL PRIMARY KEY,
 correo VARCHAR(50),
 ClienteID INT,
 FOREIGN KEY(ClienteID) REFERENCES Clientes(ID)
);

CREATE TABLE TipoMotocicletas
(ID SERIAL NOT NULL PRIMARY KEY,
 tipo VARCHAR(50)
);

CREATE TABLE Motocicletas
(TipoMotocicletaID INT,
 kilometraje DECIMAL(10,2),
 capacidadTanque DECIMAL(10,2),
 cantidadMaletas INT,
 FOREIGN KEY(TipoMotocicletaID) REFERENCES TipoMotocicletas(ID)
)INHERITS (Vehiculos);

CREATE TABLE TipoBicicletas
(ID SERIAL NOT NULL PRIMARY KEY,
 tipo VARCHAR(50)
);

CREATE TABLE Bicicletas
(TipoBicicletaID INT,
 FOREIGN KEY(TipoBicicletaID) REFERENCES TipoBicicletas(ID)
)INHERITS (Vehiculos);

CREATE TABLE TipoAutomoviles
(ID SERIAL NOT NULL PRIMARY KEY,
 tipo VARCHAR(50)
);

CREATE TABLE TipoCombustible
(ID SERIAL NOT NULL PRIMARY KEY,
 tipo VARCHAR(50)
);

CREATE TABLE Automoviles
(TipoAutomovilID INT,
 TipoCombustibleID INT,
 capacidadTanque DECIMAL(10,2),
 FOREIGN KEY(TipoAutomovilID) REFERENCES TipoAutomoviles(ID),
 FOREIGN KEY(TipoCombustibleID) REFERENCES TipoCombustible(ID)
)INHERITS (Vehiculos);

CREATE TABLE TipoHelicopteros
(ID SERIAL NOT NULL PRIMARY KEY,
 tipo VARCHAR(50)
);

CREATE TABLE Helicopteros
(TipoHelicopteroID INT,
 DuracionCombustibleMinutos INT,
 AltitudMaxima INT,
 capacidadTanque DECIMAL(10,2),
 FOREIGN KEY(TipoHelicopteroID) REFERENCES TipoHelicopteros(ID)
)INHERITS (Vehiculos);

CREATE TABLE Facturas
(ID SERIAL NOT NULL PRIMARY KEY,
 clienteID INT,
 fecha DATE,
 total DECIMAL(10,2),
 FOREIGN KEY(clienteID) REFERENCES clientes(ID)
);

CREATE TABLE Detalles
(ID SERIAL NOT NULL PRIMARY KEY,
 facturaID INT,
 vehiculoID INT,
 cantidad INT,
 subtotal DECIMAL(10,2),
 FOREIGN KEY(vehiculoID) REFERENCES Vehiculos(ID),
 FOREIGN KEY(facturaID) REFERENCES Facturas(ID)
);

CREATE TABLE Gustos
(ID SERIAL NOT NULL PRIMARY KEY,
 gusto VARCHAR(50)
);

CREATE TABLE Regalos
(ID SERIAL NOT NULL PRIMARY KEY,
 regalo VARCHAR(50)
);

CREATE TABLE ClientesXGustos
(ID SERIAL NOT NULL PRIMARY KEY,
 ClienteID INT,
 GustoID INT,
 FOREIGN KEY(ClienteID) REFERENCES Clientes(ID),
 FOREIGN KEY(GustoID) REFERENCES Gustos(ID)
);

CREATE TABLE RegalosEntregados
(ID SERIAL NOT NULL PRIMARY KEY,
 ClienteID INT,
 RegaloID INT,
 FOREIGN KEY(ClienteID) REFERENCES Clientes(ID),
 FOREIGN KEY(RegaloID) REFERENCES Regalos(ID)
);