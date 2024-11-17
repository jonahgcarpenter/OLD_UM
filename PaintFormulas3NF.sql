ALTER TABLE Formula DROP FOREIGN KEY test;
DROP TABLE IF EXISTS Color, Colorant, Formula;

-- Create paint formula database in 3NF
CREATE TABLE Color(
ColorCode CHAR(3) NOT NULL,
ColorName VARCHAR(20),
PRIMARY KEY(ColorCode)
)ENGINE = InnoDB;


CREATE TABLE Colorant(
ColorantCode VARCHAR(3) NOT NULL,
ColorantName VARCHAR(20),
PRIMARY KEY (ColorantCode)
)ENGINE = InnoDB;

CREATE TABLE Formula(
ColorCode CHAR(3) NOT NULL,
ColorantCode VARCHAR(3) NOT NULL,
Oz INTEGER(2),
Shot INTEGER(2),
HalfShot INTEGER(2),
PRIMARY KEY(ColorCode, ColorantCode),
FOREIGN KEY (ColorCode) REFERENCES Color(ColorCode),
FOREIGN KEY (ColorantCode) REFERENCES Colorant(ColorantCode)
)ENGINE = InnoDB;

--*************  3c.  Add code here  ********************Formula


-- Populate Color table
INSERT INTO Color VALUES('001', 'TangierIsland');
INSERT INTO Color VALUES('002', 'BarnRed');
INSERT INTO Color VALUES('003', 'NavajoRed');
INSERT INTO Color VALUES('004', 'DustyMauve');
INSERT INTO Color VALUES('005', 'Silver');
INSERT INTO Color VALUES('006', 'JPastel');

-- Populate Colorant table
INSERT INTO Colorant VALUES('AXX', 'Organic Yellow');
INSERT INTO Colorant VALUES('B', 'Black Oxide');
INSERT INTO Colorant VALUES('C', 'Yellow Oxide');
INSERT INTO Colorant VALUES('D', 'Phalo Green');
INSERT INTO Colorant VALUES('E', 'Phalo Blue');
INSERT INTO Colorant VALUES('F', 'Red Oxide');
INSERT INTO Colorant VALUES('I', 'Brown Oxide');
INSERT INTO Colorant VALUES('KX', 'Titanium White');
INSERT INTO Colorant VALUES('L', 'Raw_Umber');
INSERT INTO Colorant VALUES('R', 'Organic Red');
INSERT INTO Colorant VALUES('T', 'Medium Yellow');
INSERT INTO Colorant VALUES('V', 'Magenta');

-- Populate Formula table (gallon)
INSERT INTO Formula VALUES('001', 'B', '0', '18', '0');
INSERT INTO Formula VALUES('001', 'F', '0', '10', '0');
INSERT INTO Formula VALUES('001', 'AXX', '3', '6', '0');

INSERT INTO Formula VALUES('002','B', '0', '20', '0');
INSERT INTO Formula VALUES('002','F', '0', '40', '0');
INSERT INTO Formula VALUES('002','V', '0', '12', '0');
INSERT INTO Formula VALUES('002','AXX', '0', '20', '0');
INSERT INTO Formula VALUES('002','KX', '0', '16', '0');


INSERT INTO Formula VALUES('003', 'I', '2', '41', '1');
INSERT INTO Formula VALUES('003', 'R', '5', '47', '1');
INSERT INTO Formula VALUES('003', 'T', '2', '8', '1');
INSERT INTO Formula VALUES('003', 'KX', '0', '47', '0');

INSERT INTO Formula VALUES('004', 'B', '0', '19', '1');
INSERT INTO Formula VALUES('004', 'T', '0', '30', '0');
INSERT INTO Formula VALUES('004', 'V', '1', '8', '0');


INSERT INTO Formula VALUES('005', 'L', '0', '36', '1');
INSERT INTO Formula VALUES('005', 'E', '0', '5', '1');
INSERT INTO Formula VALUES('005', 'V', '0', '5', '1');

INSERT INTO Formula VALUES('006', 'L', '0', '16', '1');
INSERT INTO Formula VALUES('006', 'T', '0', '34', '0');
INSERT INTO Formula VALUES('006', 'V', '1', '38', '0');

SELECT ColorName, ColorantCode, Oz, Shot, HalfShot FROM Formula NATURAL JOIN Color NATURAL JOIN Colorant;