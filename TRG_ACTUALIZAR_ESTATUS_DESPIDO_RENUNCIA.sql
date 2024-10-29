/*
	La tabla empleados tiene dos campos sobre los que queremos trabajar, 
	el campo Estatus (1 si el empleado sigue trabajando y 0 por si ya renuncion o lo despidieron) 
	y el campo FechaRenunciaDespido en el cual ingresaremos por medio de un update la fecha en la que el empleado fue despedido o renuncio

	Cuando le hagamos un update al campo FechaRenunciaDespido con la fecha en la que renuncio la persona 
	el campo Estatus cambiara en automatico a 0, indicando que el empleado fue dado de baja. 
*/


/*
	PASOS A SEGUIR
	1.-Actualizar el campo FechaRenunciaDespido, la fecha que ingresemos no debe de ser menor a la fecha de contratación 
	2.-Actualizar el campo Estatus con valor 1, a valor 0. 


*/


CREATE OR ALTER TRIGGER TRG_Actualizar_FechaRenunciaDespido_Estatus_DespidoRenuncia
ON Empleado 
AFTER UPDATE
AS
BEGIN 
	DECLARE @IDEmpleado INT  
	DECLARE @FechaContratacion DATETIME
	DECLARE @FechaBaja DATETIME

	SELECT @IDEmpleado = IDEmpleado, 
	@FechaContratacion = FechaContratacion, 
	@FechaBaja = FechaRenunciaDespido
	FROM inserted

		IF ( @FechaBaja >= @FechaContratacion  )
			BEGIN 
				UPDATE Empleado
				SET Estatus = 0
				WHERE  @IDEmpleado = IDEmpleado
			END 
		ELSE 
			BEGIN
				RAISERROR('No puedo dar de baja al empleado, por que la fecha de baja es anterior a la fecha de contratacion o la fecha es Nula',16,1)
			END 
END 

SELECT IDEmpleado,Estatus,FechaContratacion,FechaRenunciaDespido 
FROM Empleado
WHERE IDEmpleado = 1 

UPDATE Empleado 
SET Estatus =1 
WHERE IDEmpleado = 1



UPDATE Empleado 
SET FechaRenunciaDespido = '2019-07-04'
where IDEmpleado = 1












