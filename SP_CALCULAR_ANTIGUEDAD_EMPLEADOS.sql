/*
El siguiente Store Procedure calcula la antiguedad de los empleados, partiendo desde la fecha en la 
que fueron contratados, pero tomando a los empleados cuyo estatus sea igual a 1, el cual demuestra
que el empleado sigue trabajando activamente dentro de la empresa.
*/


CREATE OR ALTER PROCEDURE SP_ANTIGUEDAD_EMPLEADOS
AS
BEGIN
	/*
	1.-Tomar solo los empleados cuyo Estatus es igual a 1
	2.-Calcular la antiguedad de esos empleados  a partir del campo FechaContratacion 
	3.-Debemos de tomar la fecha actual y calcular la diferencia con la fecha de contratacion 
	4.-Actualizar ese valor en el campo AntiguedadDias 
	*/
	UPDATE Empleado
	SET AntiguedadAnios = DATEDIFF(YY,FechaContratacion,GETDATE())
	WHERE Estatus = 1

END




EXEC SP_ANTIGUEDAD_EMPLEADOS

SELECT IDEmpleado,FechaContratacion,AntiguedadAnios FROM Empleado
