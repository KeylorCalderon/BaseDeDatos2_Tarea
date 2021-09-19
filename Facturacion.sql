CREATE PROCEDURE Facturacion (
	tipoDeVehiculo INT,
	inVehiculoID INT[],
	inClienteID INT,
	inCantidad INT[]
)

LANGUAGE 'plpgsql'
AS $$
DECLARE
	varFacturaID INT;
	varPrecio INT;
	varStock INT;
	varTotal INT;
	i INT;
BEGIN
	
	INSERT INTO Facturas(clienteID, fecha, total)
    VALUES(inClienteID,current_date,inTotal)
	RETURNING ID AS varFacturaID;
	
	FOR i IN 1..array_upper(inVehiculoID,1)
	LOOP
		varStock:=(SELECT cantidad FROM Vehiculos WHERE Vehiculos.ID = inVehiculoID[i]);
		IF varStock > 0 THEN
			varPrecio:=(SELECT precio FROM Vehiculos WHERE Vehiculos.ID = inVehiculoID[i]);
			INSERT INTO Detalles(facturaID, vehiculoID, cantidad, subtotal)
			VALUES(varFacturaID,inVehiculoID[i],inCantidad[i],(varPrecio*inCantidad[i]));
		ELSE
        	RAISE EXCEPTION 'No hay stock';
    	END IF;
	END LOOP;
	
	varTotal:=(SELECT SUM(subtotal) FROM Detalles WHERE Detalles.facturaID = varFacturaID);
	UPDATE Facturas 
    SET Facturas.total = varTotal
    WHERE Facturas.ID = varFacturaID;
	
	EXCEPTION WHEN null_value_not_allowed THEN 
    RAISE EXCEPTION 'Valor nulo';
END;
$$