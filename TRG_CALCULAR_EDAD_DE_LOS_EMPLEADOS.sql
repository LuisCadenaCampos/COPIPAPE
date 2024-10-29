/*
	Este Trigger calculara la EdadContratacion de los empleados 
	despues de que se haga un Insert en la tabla Empleados,
	el campo que tomara para calcular esto es FechaNac
*/



/*
PASOS A SEGUIR 
1.-El campo FechaNac debe de estar llenado con la fecha de nacimiento del empleado
2.-Una vez ingresado el campo anteriormente mencionado, junto a los otros campos del Empleado seguiremos con el paso 3 
3.-Calcularemos la EdadDeContratacion a partir de FechaNacimiento 
4.-Actualizaremos (Hacer un Update) el campo EdadContratacion en la tabla Empleado, del ultimo ID que se ingreso. 
*/


CREATE OR ALTER TRIGGER TRG_Calcular_Edad_Empleados 
ON Empleado 
AFTER INSERT 
AS
BEGIN
		
		DECLARE @IDEMPLEADO INT 

		SELECT @IDEMPLEADO = IDEmpleado
		FROM inserted

		UPDATE Empleado
		SET EdadContratacion = DATEDIFF(YY,FechaNac,GETDATE())
		WHERE Estatus = 1 AND @IDEMPLEADO = IDEmpleado
END;








