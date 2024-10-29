/*
El siguiente Store Procedure recibira 3 parametros
	1.-Una fecha de inicio 
	2.-Una fecha final 
	3.-IDEmpleado 

Lo que devolvera el Store Procedure sera el ID Del Empleado, su nombre completo y las ganancias que ha generado por la ventas
en ese periodo de tiempo 

En dado caso de no poner el ID del empleado al momento del ejecutar el Store, te va a traer el Total de las Ventas de los empleados en las fechas
que se ingresaron. 

*/

CREATE OR ALTER PROCEDURE SP_REPORTE_VENTAS_FECHAS(
		@FechaInicial DATETIME , 
		@FechaFinal DATETIME ,
		@IDEmpleado INT NULL
)
AS 
BEGIN 
		SELECT E.IDEmpleado,CONCAT(E.NombreEmp,' ',E.ApPat,' ',E.ApMat) AS 'Nombre_Empleado' , SUM(VD.Cantidad*VD.PrecioUnit) AS 'Total de la Venta'
		FROM Empleado E 
		JOIN Ventas V ON E.IDEmpleado = V.IDEmpleado
		JOIN VentasD VD ON V.IDVenta = VD.IDVenta
		WHERE (E.IDEmpleado = @IDEmpleado OR @IDEmpleado IS NULL) AND (V.FechaVta BETWEEN @FechaInicial AND @FechaFinal) 
		GROUP BY E.IDEmpleado,E.NombreEmp,E.ApPat,E.ApMat 
END 

select * from Ventas

EXEC SP_REPORTE_VENTAS_FECHAS '2019-08-12','2023-05-25',NULL



















