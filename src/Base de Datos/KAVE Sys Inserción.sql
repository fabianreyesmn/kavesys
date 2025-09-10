USE KAVE_Sys;


/*Tabla: Categoría*/

DESCRIBE Categoria;

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('AB', 'Abrazadera Toma de Agua');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('CM', 'Conexión para Manguera');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('CMH', 'Hembra', 'CM');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('CMM', 'Macho', 'CM');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('E', 'Empaque');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('ECT', 'Contratuerca', 'E');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('EAC', 'Agua-Cal', 'E');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('C', 'Conector Cespol');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('A', 'Adaptador');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('AI', 'Insercion', 'A');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('AC', 'Campana', 'A');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('Cople', 'Cople Inserción');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('T', 'Tee');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TI', 'de Inserción', 'T');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TCM', 'Macho', 'T');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TCH', 'Hembra', 'T');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('R', 'Regatón');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RPB', 'para Bastón', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RRE', 'Redondo Exterior', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RCE', 'Cuadrado Exterior', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RRI', 'Redondo Interior', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RCI', 'Cuadrado Interior', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RM', 'para Muleta', 'R');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('RI', 'Interior', 'R');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('Y', 'Y Griega de Inserción');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('CD', 'Codo');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('CDI', 'de Inserción', 'CD');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('CRI', 'Rosca Interior', 'CD');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('CRE', 'Rosca Exterior', 'CD');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('X', 'Cruz Inserción');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('TP', 'Tapón');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TA', 'Inserción', 'TP');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TM', 'Macho', 'TP');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TH', 'Hembra', 'TP');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('TL', 'para Lavabo', 'TP');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('N', 'Nivelador');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('TN', 'Tornillo Nivelador');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('TO', 'Tope');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('BT', 'Brida para Tinaco');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('CU', 'Cuña para puerta');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('VN', 'Valvula');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('VNX', 'Nariz', 'VN');
INSERT INTO Categoria(ID_Categoria, Nombre, ID_CategoriaPadre) VALUES ('VNG', 'para Garrafón', 'VN');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('S', 'Separador de Piso');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('RB', 'Reducción Bushing');

INSERT INTO Categoria(ID_Categoria, Nombre) VALUES ('CT', 'Contratuerca');

SELECT * FROM Categoria;
/*DELETE FROM Categoria;*/


/*Tabla: ProductoInventario*/

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI1', 'ABRAZ. T.D. 1 1/2" X 1/2"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB112', 'PI1', 1, 40.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI2', 'ABRAZ. T.D. 2 X 1/2"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB2', 'PI2', 1, 45.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI3', 'ABRAZ. T.D. 2 1/2" X 1/2"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB212', 'PI3', 1, 65.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI4', 'ABRAZ. T.D. 3 X 1/2"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB3', 'PI4', 1, 70.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI5', 'ABRAZ. T.D. 4 X 1/2"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB4', 'PI5', 1, 85.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI6', 'ABRAZ. T.D. 1 1/2" X 3/4"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB112X34', 'PI6', 1, 40.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI7', 'ABRAZ. T.D. 2 X 3/4"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB2X34', 'PI7', 1, 45.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI8', 'ABRAZ. T.D. 2 1/2" X 3/4"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB212X34', 'PI8', 1, 65.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI9', 'ABRAZ. T.D. 3 X 3/4"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB3X34', 'PI9', 1, 70.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI10', 'ABRAZ. T.D. 4 X 3/4"', 'AB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AB4X34', 'PI10', 1, 85.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI11', 'CONEX. MANG. HEM 1/2"', 'CMH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CMH', 'PI11', 25, 8.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI12', 'CONEX. MANG. MACH 1/2"', 'CMM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CMM', 'PI12', 25, 4.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI13', 'EMP. PLANO 1/2" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E101', 'PI13', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI14', 'EMP. CONICO 1/2" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E102', 'PI14', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI15', 'EMP. PLANO 5/8" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E103', 'PI15', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI16', 'EMP. CONICO 5/8" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E104', 'PI16', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI17', 'EMP. O-RING 3/8" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E110', 'PI17', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI18', 'EMP. O-RING 1/2" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E111', 'PI18', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI19', 'EMP. O-RING 5/8" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E112', 'PI19', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI20', 'EMP. PLANO MANG. C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E113', 'PI20', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI21', 'EMP. PLANO 3/4" C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E120', 'PI21', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI22', 'EMP. EST. 1/2" CH. C/100', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E126', 'PI22', 1, 46.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI23', 'EMP. TUER. PITON 3/8"', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E105', 'PI23', 100, 0.92, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI24', 'EMP. ESTOP. 3/8"', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E109', 'PI24', 50, 0.92, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI25', 'EMP. TUERG. ALIM. 3/8"', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E125', 'PI25', 50, 0.92, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI26', 'EMP. REGADERA', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E128', 'PI26', 50, 0.92, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI27', 'EMP. PIST. PINTAR', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E201', 'PI27', 100, 2.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI28', 'EMP. ACOP. DELG', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E130', 'PI28', 25, 5.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI29', 'EMP. ACOP. ANCHO', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E131', 'PI29', 25, 8.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI30', 'EMP. ACOP. ANCIA', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E132', 'PI30', 25, 8.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI31', 'EMP. MEDIDOR', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E123', 'PI31', 100, 1.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI32', 'EMP. VAL. ALIM', 'E');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('E140', 'PI32', 25, 3.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI33', 'CONEC. CESPOL 40 X 32', 'C');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('C40', 'PI33', 50, 4.35, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI34', 'CONEC. CESPOL 50 X 32', 'C');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('C503', 'PI34', 50, 6.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI35', 'CONEC. CESPOL 50 X 40', 'C');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('C504', 'PI35', 50, 6.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI36', 'ADAPTADOR 3/8"', 'A');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI38', 'PI36', 50, 4.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI37', 'ADAPTADOR 1/2"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI12', 'PI37', 50, 4.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI38', 'ADAPTADOR 3/4"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI34', 'PI38', 25, 5.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI39', 'ADAPTADOR 1"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI1X', 'PI39', 25, 7.35, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI40', 'ADAPTADOR 1 1/4"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI114', 'PI40', 25, 9.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI41', 'ADAPTADOR 1 1/2"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI112', 'PI41', 25, 12.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI42', 'ADAPTADOR 2"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI2', 'PI42', 10, 20.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI43', 'ADAPTADOR 3"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI3X', 'PI43', 4, 71.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI44', 'ADAPT 1/8" X 1/4"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI18X14', 'PI44', 50, 3.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI45', 'ADAPT. 3/4" X 1/2"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI34X12', 'PI45', 25, 5.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI46', 'ADAPT. 1/2" X 3/4"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI12X34', 'PI46', 25, 5.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI47', 'ADAPT. 1" X 1/2"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI1X12', 'PI47', 25, 7.35, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI48', 'ADAPT. 1" X 3/4"', 'AI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AI1X34', 'PI48', 25, 7.35, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI49', 'ADAPT. CAMP. 3/8"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC38', 'PI49', 50, 5.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI50', 'ADAPT. CAMP. 1/2"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC12', 'PI50', 50, 6.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI51', 'ADAPT. CAMP. 3/4"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC34', 'PI51', 25, 6.73, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI52', 'ADAPT. CAMP. 1"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC1X', 'PI52', 25, 8.92, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI53', 'ADAPT. CAMP. 1 1/4"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC114', 'PI53', 10, 14.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI54', 'ADAPT. CAMP. 1 1/2"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC112', 'PI54', 10, 16.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI55', 'ADAPT. CAMP. 2"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC2X', 'PI55', 10, 22.05, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI56', 'ADAPT. CAMP. 3"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC3X', 'PI56', 5, 83.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI57', 'ADAP. CAMP. 1/2" X 3/4"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC12X34', 'PI57', 25, 6.73, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI58', 'ADAP. 3/4" X 1/2"', 'AC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('AC34X12', 'PI58', 25, 6.73, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI59', 'COPLE 1/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople14', 'PI59', 50, 3.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI60', 'COPLE 3/8"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople38', 'PI60', 50, 3.88, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI61', 'COPLE 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople12', 'PI61', 50, 4.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI62', 'COPLE 3/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople34', 'PI62', 25, 5.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI63', 'COPLE 1"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople1X', 'PI63', 25, 8.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI64', 'COPLE 1 1/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople114', 'PI64', 25, 9.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI65', 'COPLE 1 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople112', 'PI65', 25, 12.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI66', 'COPLE 2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople2', 'PI66', 10, 20.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI67', 'COPLE 3"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople3X', 'PI67', 4, 71.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI68', 'COPLE 1/2" X 3/8"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople12X38', 'PI68', 25, 4.80, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI69', 'COPLE 3/4" X 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople34X12', 'PI69', 25, 6.35, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI70', 'COPLE 1" X 3/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople1X34', 'PI70', 25, 8.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI71', 'COPLE 1" X 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople1X12', 'PI71', 25, 8.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI72', 'COPLE 1 1/2" X 3/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople112X34', 'PI72', 10, 15.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI73', 'COPLE 2" X 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople2X12', 'PI73', 10, 21.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI74', 'COPLE 2" X 3/4"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople2X34', 'PI74', 10, 21.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI75', 'COPLE 2" X 1"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople2X1', 'PI75', 10, 21.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI76', 'COPLE 2" X 1 1/2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople2X112', 'PI76', 10, 21.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI77', 'COPLE 3" X 2"', 'Cople');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Cople3X2', 'PI77', 5, 71.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI78', 'TEE 1/4"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI14', 'PI78', 50, 4.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI79', 'TEE 3/8"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI38', 'PI79', 50, 6.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI80', 'TEE 1/2"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI12', 'PI80', 50, 7.33, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI81', 'TEE 3/4"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI34', 'PI81', 25, 9.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI82', 'TEE 1"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI1X', 'PI82', 25, 11.73, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI83', 'TEE 1 1/4"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI114', 'PI83', 10, 20.96, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI84', 'TEE 1 1/2"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI112', 'PI84', 10, 30.57, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI85', 'TEE 2"', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI2', 'PI85', 5, 48.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI86', 'TEE 1/2" X 3/8" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI12X38', 'PI86', 25, 7.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI87', 'TEE 3/4" X 1/2" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI34X12', 'PI87', 25, 9.65, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI88', 'TEE 1" X 1/2" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI1X12', 'PI88', 25, 12.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI89', 'TEE 1" X 3/4" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI1X34', 'PI89', 25, 12.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI90', 'TEE 2" X 1/2" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI2X12', 'PI90', 5, 48.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI91', 'TEE 2" X 3/4" INSER.', 'TI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TI2X34', 'PI91', 5, 48.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI92', 'TEE 1/2" X 1/2" MACH.', 'TCM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCM12', 'PI92', 50, 7.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI93', 'TEE 3/4" X 3/4" MACH.', 'TCM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCM34', 'PI93', 25, 9.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI94', 'TEE 1/2" X 1/2" HEM.', 'TCH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCH12', 'PI94', 25, 10.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI95', 'TEE 1" X 1/2" HEM.', 'TCH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCH112', 'PI95', 25, 13.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI96', 'TEE 2" X 1/2" HEM.', 'TCH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCH212', 'PI96', 5, 44.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI97', 'TEE 2" X 3/4" HEM.', 'TCH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TCH234', 'PI97', 5, 44.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI98', 'REG P/BASTON 1/2"', 'RPB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB12', 'PI98', 10, 5.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI99', 'REG P/BASTON 5/8"', 'RPB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB58', 'PI99', 10, 8.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI100', 'YEE 3/8"', 'Y');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Y38', 'PI100', 25, 7.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI101', 'YEE 1/2" INSER.', 'Y');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Y12', 'PI101', 25, 8.95, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI102', 'YEE 3/4"', 'Y');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Y34X', 'PI102', 25, 12.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI103', 'YEE 3/4" X 1/2"', 'Y');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('Y3412', 'PI103', 25, 12.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI104', 'CODO 3/8"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI38', 'PI104', 50, 5.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI105', 'CODO 1/2"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI12', 'PI105', 50, 6.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI106', 'CODO 3/4"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI34', 'PI106', 25, 7.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI107', 'CODO 1"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI1X', 'PI107', 25, 10.95, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI108', 'CODO 1 1/4"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI114', 'PI108', 10, 20.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI109', 'CODO 1 1/2"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI112', 'PI109', 10, 27.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI110', 'CODO 2"', 'CDI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CDI2', 'PI110', 5, 36.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI111', 'CODO ROSC. INT 3/8"', 'CRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CRI38', 'PI111', 25, 6.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI112', 'CODO ROSC. INT. 1/2"', 'CRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CRI', 'PI112', 50, 7.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI113', 'CODO ROSC. EXT 1/2"', 'CRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CRE', 'PI113', 50, 6.95, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI114', 'CRUZ INS. 1/2"', 'X');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('X12', 'PI114', 25, 9.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI115', 'TAPON INSER. 1/2"', 'TA');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TA12', 'PI115', 50, 3.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI116', 'TAPON INSER. 3/4"', 'TA');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TA34', 'PI116', 25, 4.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI117', 'TAPON INSER. 1"', 'TA');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TA1X', 'PI117', 25, 6.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI118', 'REG. RED EXT 3/8"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE38', 'PI118', 100, 1.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI119', 'REG. RED EXT 1/2"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE12', 'PI119', 100, 1.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI120', 'REG. RED EXT 5/8"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE58', 'PI120', 100, 2.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI121', 'REG. RED EXT 3/4"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE34', 'PI121', 100, 3.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI122', 'REG. RED EXT 7/8"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE78', 'PI122', 100, 3.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI123', 'REG. RED EXT 1"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE1X', 'PI123', 50, 4.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI124', 'REG. RED EXT 1 1/8"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE118', 'PI124', 20, 6.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI125', 'REG. RED EXT 1 1/4"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE114', 'PI125', 20, 7.30, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI126', 'REG. RED EXT 1 1/2"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE112', 'PI126', 20, 11.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI127', 'REG. RED EXT 2"', 'RRE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRE2', 'PI127', 20, 20.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI128', 'REG. CUAD EXT 3/4"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCE34', 'PI128', 50, 3.60, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI129', 'REG. CUAD EXT TEE 3/4"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCET34', 'PI129', 50, 4.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI130', 'REG. CUAD EXT 1"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCE1X', 'PI130', 50, 4.45, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI131', 'REG. CUAD EXT 1 1/4"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCE114', 'PI131', 20, 5.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI132', 'REG. CUAD EXT 1 1/2"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCE112', 'PI132', 20, 7.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI133', 'REG. CUAD EXT 2"', 'RCE');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCE2', 'PI133', 20, 17.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI134', 'REG. RED INT 1/2"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI12', 'PI134', 100, 0.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI135', 'REG. RED INT 3/4"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI34', 'PI135', 100, 1.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI136', 'REG. RED INT 7/8"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI78', 'PI136', 100, 1.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI137', 'REG. RED INT 1"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI1X', 'PI137', 100, 1.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI138', 'REG. RED INT 1 1/4"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI114', 'PI138', 100, 3.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI139', 'REG. RED INT 1 1/2"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI112', 'PI139', 100, 3.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI140', 'REG. RED INT 2"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI2', 'PI140', 50, 4.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI141', 'REG. RED INT 3"', 'RRI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RRI3', 'PI141', 20, 7.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI142', 'REG. CUAD INT 1/2"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI12', 'PI142', 100, 0.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI143', 'REG. CUAD INT 3/4"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI34', 'PI143', 100, 1.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI144', 'REG. CUAD INT 1"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI1X', 'PI144', 100, 2.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI145', 'REG. CUAD INT 1 1/4"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI114', 'PI145', 50, 3.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI146', 'REG. CUAD INT 1 1/2"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI112', 'PI146', 50, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI147', 'REG. CUAD INT 2"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI2', 'PI147', 20, 6.80, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI148', 'REG. CUAD INT 2 1/4"', 'RCI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RCI214', 'PI148', 1, 8.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI149', 'REG. P/BASTON 3/4"', 'RPB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RPB34', 'PI149', 10, 8.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI150', 'REG. P/BASTON 7/8"', 'RPB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RPB78', 'PI150', 10, 8.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI151', 'REG. P/BASTON 1"', 'RPB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RPB1X', 'PI151', 10, 8.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI152', 'REG. P/MULETA 7/8"', 'RM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RM', 'PI152', 10, 17.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI153', 'REG. INT 3/4" X 1 3/4"', 'RI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RI34', 'PI153', 50, 3.40, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI154', 'REG. INT 2" X 1"', 'RI');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RI21', 'PI154', 50, 4.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI155', 'NIVELADOR 3/4" X 1 3/4"', 'N');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('N34', 'PI155', 20, 6.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI156', 'NIVELADOR 1"', 'N');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('N1', 'PI156', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI157', 'NIVEL. RED 1 1/2" X 3/8"', 'N');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('N112', 'PI157', 20, 10.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI158', 'TORNI NIV 5/16" X 1"', 'TN');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TN', 'PI158', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI159', 'TORNI NIV 1/4" X 1"', 'TN');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TN141', 'PI159', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI160', 'TORNI NIV 1/4" X 1 1/2"', 'TN');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TN14', 'PI160', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI161', 'TOR. NIV 5/16" X 1 1/2"', 'TN');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TN516', 'PI161', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI162', 'TORNI NIV 3/8" X 1 1/2"', 'TN');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TN38', 'PI162', 20, 5.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI163', 'TOPE #0 - 13mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO0', 'PI163', 100, 0.70, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI164', 'TOPE #1 - 19mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO1', 'PI164', 100, 0.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI165', 'TOPE #2 - 18mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO2', 'PI165', 100, 0.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI166', 'TOPE #3 - 23mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO3', 'PI166', 100, 1.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI167', 'TOPE #4 - 26mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO4', 'PI167', 100, 1.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI168', 'TOPE #5 - 28mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO5', 'PI168', 100, 2.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI169', 'TOPE #6 - 34mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO6', 'PI169', 50, 3.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI170', 'TOPE #7 - 42mm', 'TO');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TO7', 'PI170', 20, 6.20, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI171', 'TAPON LAVABO', 'TL');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TL', 'PI171', 25, 4.95, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI172', 'BRIDA 1/2"', 'BT');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('BT12', 'PI172', 10, 10.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI173', 'BRIDA P/TINACO 1 1/2"', 'BT');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('BT112', 'PI173', 10, 33.15, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI174', 'CUÑA PARA PUERTA', 'CU');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CU', 'PI174', 10, 8.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI175', 'VALVULA NARIZ', 'VNX');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('VNX', 'PI175', 10, 21.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI176', 'VAL NARIZ P/GARRAFON', 'VNG');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('VNG', 'PI176', 10, 25.80, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI177', 'SEPARADOR 1/8" - C/120', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S18', 'PI177', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI178', 'SEPAR. 3/16" - C/100', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S316', 'PI178', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI179', 'SEPAR. 1/4" - C/90', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S14', 'PI179', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI180', 'SEPAR. 5/16" - C/60', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S516', 'PI180', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI181', 'SEPAR. 3/8" - C/55', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S38', 'PI181', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI182', 'SEPAR. 1/2" - C/40', 'S');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('S12', 'PI182', 1, 31.00, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI183', 'TAPON MACHO 1/2" NPT', 'TM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TM12', 'PI183', 50, 3.75, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI184', 'TAPON MACHO 3/4"', 'TM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TM34', 'PI184', 25, 4.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI185', 'TAPON MACHO 1"', 'TM');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TM1X', 'PI185', 10, 6.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI186', 'TAPON HEM. 1/2"', 'TH');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('TH12', 'PI186', 25, 4.85, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI187', 'RED. BUCH. 3/4" X 1/2"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB3412', 'PI187', 25, 5.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI188', 'REDUC. BUCH. 1" X 1/2"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB112', 'PI188', 10, 7.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI189', 'REDUC. BUCH. 1" X 3/4"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB134', 'PI189', 10, 7.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI190', 'RED. BUCH. 1 1/4" X 1/2"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB11412', 'PI190', 10, 10.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI191', 'RED. BUCH. 1 1/4" X 3/4"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB11434', 'PI191', 10, 10.10, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI192', 'RED. BUCH. 1 1/2" X 1/2"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB11212', 'PI192', 10, 11.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI193', 'RED. BUCH. 1 1/2" X 3/4"', 'RB');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('RB11234', 'PI193', 10, 11.25, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI194', 'CONTRATUERCA 1/2"', 'CT');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('CT', 'PI194', 50, 3.50, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI195', 'EMP. CONTRATUERCA', 'ECT');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('ECT145', 'PI195', 50, 0.90, 1);

INSERT INTO ProductoInventario(ID_Inventario, Descripcion, ID_Categoria) VALUES ('PI196', 'EMP. AGUA-CAL', 'EAC');
INSERT INTO ProductoFabricado(Clave, ID_Inventario, Piezas, Precio, Existencias) VALUES ('EAC103', 'PI196', 50, 2.20, 1);


SELECT inventario.ID_Inventario, Clave, Descripcion, Piezas, Precio, Existencias FROM ProductoInventario inventario, ProductoFabricado fabricado
WHERE fabricado.ID_Inventario = inventario.ID_Inventario ORDER BY ROUND( SUBSTR(inventario.Id_Inventario, 3) ) ASC; 


/*Tabla: Usuario*/

DESCRIBE Usuario;

-- INSERT INTO Usuario(ID_Usuario, Nombre, ApellidoPaterno, ApellidoMaterno, CorreoElectronico, Tipo) VALUES ('1', 'Gustavo', 'Avendaño', 'Guevara', 'gusavegue@gmail.com', 'Administrador');

SELECT * FROM Usuario;