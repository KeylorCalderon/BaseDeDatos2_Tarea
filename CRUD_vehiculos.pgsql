CREATE PROCEDURE CRUD_vehiculos (
	operacion int,
	vehiculoID int,
	marca varchar(50),
    modelo varchar(50),
    color varchar(50),
    capacidad int,
    precio decimal,
    cantidad int,
    tipoDeVehiculo int,
    tipoBicicletaID int,
    tipoMotocicletaID int,
    capacidadTanque decimal,
    cantidadMaletas int,
    tipoAutomovilID int,
    tipoCombustible int,
    duracionCombustibleMinutos int,
    altitudMaxima int,
    tipoHelicopteroID int,
    capacidadTanque decimal
)
LANGUAGE SQL
AS $$
    IF operacion = 1 THEN --CREATE
        IF tipoDeVehiculo = 1 THEN --BICICLETA
            INSERT INTO Bicicletas(marca,modelo,color,capacidad,precio,cantidad,activo,tipoBicicletaID)
            VALUES(marca,modelo,color,capacidad,precio,cantidad,1,tipoBicicletaID)

            EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

        ELSIF tipoDeVehiculo = 2 THEN --MOTOCICLETA
            INSERT INTO Motocicletas(marca,modelo,color,capacidad,precio,cantidad,activo,tipoMotocicletaID,capacidadTanque,cantidadMaletas)
            VALUES(marca,modelo,color,capacidad,precio,cantidad,1,tipoMotocicletaID,capacidadTanque,cantidadMaletas)

            EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

        ELSIF tipoDeVehiculo = 3 THEN --AUTOMOVIL
            INSERT INTO Automoviles(marca,modelo,color,capacidad,precio,cantidad,activo,tipoAutomovilID,tipoCombustible,capacidadTanque)
            VALUES(marca,modelo,color,capacidad,precio,cantidad,1,tipoAutomovilID,tipoCombustible,capacidadTanque)

            EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

        ELSIF tipoDeVehiculo = 4 THEN --HELICOPTERO
            INSERT INTO Helicpteros(marca,modelo,color,capacidad,precio,cantidad,activo,duracionCombustibleMinutos,altitudMaxima,tipoHelicopteroID,capacidadTanque)
            VALUES(marca,modelo,color,capacidad,precio,cantidad,1,duracionCombustibleMinutos,altitudMaxima,tipoHelicopteroID,capacidadTanque)

            EXCEPTION when null_value_not_allowed THEN 
            raise EXCEPTION 'Valor nulo'

        ELSE
            raise EXCEPTION 'Tipo de vehiculo invalido'
        END IF

    ELSIF operacion = 2 THEN --READ
        SELECT marca,modelo,color,capacidad,precio,cantidad,activo FROM Vehiculos WHERE Vehiculos.ID = vehiculoID

    ELSIF operacion = 3 THEN --UPDATE
        UPDATE Vehiculos
        SET marca = ISNULL(marca,Vehiculos.marca),
            modelo = ISNULL(modelo,Vehiculos.modelo),
            color = ISNULL(color,Vehiculos.color),
            capacidad = ISNULL(capacidad,Vehiculos.capacidad),
            precio = ISNULL(precio,Vehiculos.precio),
            cantidad = ISNULL(cantidad,Vehiculos.cantidad),
        WHERE Vehiculos.ID = vehiculoID

        UPDATE Bicicletas 
        SET tipoBicicletaID = ISNULL(tipoBicicletaID,Bicicletas.tipoBicicletaID)
        WHERE Bicicletas.ID = vehiculoID

        UPDATE Motocicletas 
        SET tipoMotocicletaID = ISNULL(tipoMotocicletaID,Motocicletas.tipoMotocicletaID),
            capacidadTanque = ISNULL(capacidad,Motocicletas.capacidadTanque),
            cantidadMaletas = ISNULL(cantidadMaletas,Motocicletas.cantidadMaletas)
        WHERE Motocicletas.ID = vehiculoID

        UPDATE Automoviles 
        SET tipoAutomovilID = ISNULL(tipoAutomovilID,Automoviles.tipoAutomovilID),
            tipoCombustible = ISNULL(tipoCombustible,Automoviles.tipoCombustible),
            capacidadTanque = ISNULL(capacidadTanque,Automoviles.capacidadTanque)
        WHERE Automoviles.ID = vehiculoID

        UPDATE Helicpteros 
        SET tipoHelicopteroID = ISNULL(tipoHelicopteroID,Helicpteros.tipoHelicopteroID),
            altitudMaxima = ISNULL(altitudMaxima,Helicpteros.altitudMaxima),
            duracionCombustibleMinutos = ISNULL(duracionCombustibleMinutos,Helicpteros.duracionCombustibleMinutos),
            capacidadTanque = ISNULL(capacidadTanque,Helicpteros.capacidadTanque)
        WHERE Helicpteros.ID = vehiculoID

    ELSIF operacion = 4 THEN --DELETE
    UPDATE Vehiculos
    SET activo = 0
    WHERE Vehiculos.ID = vehiculoID

    ELSE
        raise EXCEPTION 'Operacion invalida'
    END IF
$$