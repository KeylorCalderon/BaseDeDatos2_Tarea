CREATE PROCEDURE Facturacion (
	tipoDeVehiculo INT,
	inVehiculoID INT,
	inClienteID INT,
	inCantidad INT,
	inTotal INT
)

LANGUAGE 'plpgsql'
AS $$
DECLARE
	inFacturaID INT;
BEGIN
	
	INSERT INTO Facturas(clienteID, fecha, total)
    VALUES(inClienteID,current_date,inTotal)
	RETURNING ID AS inFacturaID;
	
	INSERT INTO Detalles(facturaID, vehiculoID, cantidad, subtotal)
    VALUES(inFacturaID,inVehiculoID,inCantidad,(inTotal/inCantidad));
	
	EXCEPTION when null_value_not_allowed THEN 
    RAISE EXCEPTION 'Valor nulo';
END;
$$