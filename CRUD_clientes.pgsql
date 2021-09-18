CREATE PROCEDURE CRUD_clientes (
	operacion int,
    clienteID int,
	nombre varchar(50),
    apellidos varchar(50),
    fechaNacimiento date,
    telefono int,
    correo varchar(50)
)
LANGUAGE SQL
AS $$
    IF operacion = 1 THEN --CREATE
        INSERT INTO Clientes(ID,nombre,apellidos,fechaNacimiento,activo)
        VALUES(clienteID,nombre,apellidos,fechaNacimiento,1)

        INSERT INTO Telefonos(telefono,clienteID)
        VALUES(telefono,clienteID)

        INSERT INTO Correos(correo,clienteID)
        VALUES(correo,clienteID)

        EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

    ELSIF operacion = 2 THEN --READ
        SELECT clienteID,nombre,apellidos,fechaNacimiento FROM Clientes WHERE Clientes.ID = clienteID

    ELSIF operacion = 3 THEN --UPDATE
        UPDATE Clientes 
        SET Clientes.nombre = ISNULL(nombre,Clientes.nombre),
            Clientes.apellidos = ISNULL(apellidos,Clientes.apellidos),
            Clientes.fechaNacimiento = ISNULL(fechaNacimiento,Clientes.fechaNacimiento)
        WHERE Clientes.ID = clienteID

    ELSIF operacion = 4 THEN --DELETE
        UPDATE Clientes
        SET activo = 0
        WHERE Clientes.ID = clienteID

    ELSIF operacion = 5 THEN --CREATE TELEFONO
        INSERT INTO Telefonos(telefono,clienteID)
        VALUES(telefono,clienteID)

        EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

    ELSIF operacion = 6 THEN --CREATE CORREO
        INSERT INTO Correos(correo,clienteID)
        VALUES(correo,clienteID)

        EXCEPTION when null_value_not_allowed THEN 
                raise EXCEPTION 'Valor nulo'

    ELSIF operacion = 7 THEN --DELETE TELEFONO
        DELETE FROM Telefonos WHERE Telefonos.telefono = telefono

    ELSIF operacion = 8 THEN --DELETE CORREO
        DELETE FROM Correos WHERE Correos.correo = correo

    ELSE
        raise EXCEPTION 'Operacion invalida'

    END IF
$$