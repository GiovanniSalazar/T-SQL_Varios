

DROP TABLE Ventas

CREATE TABLE Ventas (
  id INT NOT NULL IDENTITY(1,1), 
  oficina VARCHAR(30) NOT NULL,
  periodo VARCHAR(30) NOT NULL,
  cantidad INT  
 );

INSERT INTO Ventas
    (oficina, periodo, cantidad)
VALUES 
    ('Oficina 1', '2019', 100),
    ('Oficina 1', '2018', 150),
    ('Oficina 2', '2017', 200),
    ('Oficina 2', '2015', 220),
	('Oficina 3', '2017', 300),
    ('Oficina 3', '2015', 50),
    ('Oficina 4', '2010', 10),
	('Oficina 4', '2016', 60)


DECLARE @Query_SQL VARCHAR(MAX)

DECLARE @col VARCHAR(MAX) = STUFF((SELECT DISTINCT
    ',' + QUOTENAME(periodo)
  FROM Ventas
  FOR xml PATH (''), TYPE)
  .value('.', 'varchar(Max)')
  , 1, 1, '')

 DECLARE @Total varchar(max) = STUFF((SELECT DISTINCT
      '+ ISNULL(' + QUOTENAME(periodo) + ',0)'
    FROM Ventas
    FOR xml PATH (''), TYPE)
    .value('.', 'varchar(Max)')
    , 1, 1, '')


 SET @Query_SQL='
               Select *,(' + @Total + ') As Total From 
			   (select oficina, periodo, cantidad			
					from Ventas
			   ) x
				pivot 
				( 
					 max(cantidad)
					for periodo in (' + @col + ')
				) p '

--Print(@Query_SQL)
exec(@Query_SQL)