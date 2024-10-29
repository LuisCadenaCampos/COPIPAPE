/*
	Este Store Procedure calcula la antiguedad de la empresa en años
	Tomando el campo Fundacion que es del tipo DATE
*/


CREATE OR ALTER PROCEDURE SP_CALCULAR_ANTIGUEDAD_EMPRESA
AS 
BEGIN
	UPDATE Empresa
	SET AntiguedadEmpresa = DATEDIFF(YY,Fundacion,GETDATE())
	WHERE RSocial = 'Servicios Papeleros COPIPAPE'
END


exec  SP_CALCULAR_ANTIGUEDAD_EMPRESA


