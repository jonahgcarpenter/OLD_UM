DROP TABLE IF EXISTS login2023;
DROP TABLE IF EXISTS carCust2023;
DROP TABLE IF EXISTS payment2023;
DROP TABLE IF EXISTS rental2023;
DROP TABLE IF EXISTS auto2023;

CREATE TABLE login2023 (username VARCHAR(8) NOT NULL,
					password VARCHAR(60),
					permission CHARACTER(1),
					PRIMARY KEY(username)
					);
					
CREATE TABLE carCust2023(cusID INT NOT NULL auto_increment,
					 lname VARCHAR(45),
					 fname VARCHAR(45),
					 driversLicense VARCHAR(10),
					 st VARCHAR(10),
					 username VARCHAR(8),
					 PRIMARY KEY (cusID)
					 );
CREATE TABLE rental2023(rentNum	INT(3) NOT NULL,
					driversLicense VARCHAR(10),
					VIN CHARACTER(17),
					startDate DATE,
					endDate DATE,
					PRIMARY KEY (rentNum, driversLicense)
					);
					
CREATE TABLE payment2023(creditCardNum VARCHAR(20) NOT NULL,
					 rentNum INT(3),
					 cType VARCHAR(20),
					 PRIMARY KEY (creditCardNum, rentNum)
					 );
		
CREATE TABLE auto2023(VIN CHARACTER(17) NOT NULL ,
				  make VARCHAR(30),
				  model VARCHAR(45),
				  category VARCHAR(20),
				  rate DECIMAL(4, 2),
				  PRIMARY KEY(VIN)
				  );

				  
INSERT INTO login2023 VALUES ('kdavidso', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'y');
INSERT INTO login2023 VALUES ('jturner', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'y');
INSERT INTO login2023 VALUES ('amiller', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'y');
INSERT INTO login2023 VALUES ('jsmith', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('jjones', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('kander', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('abaker', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('sedell', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('sfrank', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('cyoung', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('jwill', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('dvon', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('rcaudill', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('pliu', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');
INSERT INTO login2023 VALUES ('tnance', '$2y$10$ZjY5MTkxMDdhZjYwZDNiN.Cy5MZ/cfr5J7c7Ctb.h0JsJL8FY./rW', 'n');

INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Smith', 'John', '800123456', 'MS', 'jsmith');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Jones', 'Josh', '800123457', 'MI', 'jjones');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Anderson', 'Karen', '800123458', 'NY', 'kander');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Baker', 'Allison', '800123459', 'CA', 'abaker');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Caudill', 'Robert', '800123460', 'OR', 'rcaudill');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Edell', 'Steve', '800123461', 'OH', 'sedell');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Franklin', 'Susan', '800123462', 'MS', 'sfrank');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Young', 'Carol', '800123463', 'NY', 'cyoung');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Williams', 'John', '800123464', 'MI', 'jwill');
INSERT INTO carCust2023(lname, fname, driversLicense, st, username) VALUES('Von', 'David', '800123465', 'CA', 'dvon');
				  

INSERT INTO rental2023 VALUES('001', '800123456', '1f2545y789920by45', '2023-05-01', '2023-05-10');
INSERT INTO rental2023 VALUES('002', '800123457', '1f1345y789920by45', '2023-05-02', '2023-05-04');
INSERT INTO rental2023 VALUES('003', '800123458', '1t3245y789920by45', '2023-05-03', '2023-05-05');
INSERT INTO rental2023 VALUES('004', '800123459', '1n3245y789920by45', '2023-05-01', '2023-05-03');
INSERT INTO rental2023 VALUES('005', '800123460', '1t2145y789920by45', '2023-05-02', '2023-05-14');
INSERT INTO rental2023 VALUES('006', '800123461', '1t2245y789920by45', '2023-05-03', '2023-05-8');
INSERT INTO rental2023 VALUES('007', '800123462', '1t1345y789920by45', '2023-05-01', '2023-05-10');
INSERT INTO rental2023 VALUES('008', '800123463', '1f3145y789920by45', '2023-05-02', '2023-05-05');
INSERT INTO rental2023 VALUES('009', '800123464', '1n2445y789920by45', '2023-05-03', '2023-05-04');
INSERT INTO rental2023 VALUES('010', '800123465', '1n1145y789920by45', '2023-05-01', '2023-05-08');
				  
INSERT INTO payment2023 VALUES('5777-1234-5678-9012', '001', 'Master Card');
INSERT INTO payment2023 VALUES('4777-1234-5678-9012', '002', 'Visa');
INSERT INTO payment2023 VALUES('4877-1234-5678-9012', '003', 'Visa');
INSERT INTO payment2023 VALUES('5877-1234-5678-9012', '004', 'Master Card');
INSERT INTO payment2023 VALUES('7777-1234-5678-9012', '005', 'AMEX');
INSERT INTO payment2023 VALUES('6777-1234-5678-9012', '006', 'Discover');
INSERT INTO payment2023 VALUES('6877-1234-5678-9012', '007', 'Discover');
INSERT INTO payment2023 VALUES('5977-1234-5678-9012', '008', 'Master Card');
INSERT INTO payment2023 VALUES('4977-1234-5678-9012', '009', 'Visa');
INSERT INTO payment2023 VALUES('4677-1234-5678-9012', '010', 'Visa');

				  
INSERT INTO auto2023 VALUES('1f1145y789920by45', 'Ford', 'Edge', 'Fullsize', 35.52);
INSERT INTO auto2023 VALUES('1f1245y789920by45', 'Ford', 'Edge', 'Fullsize', 35.52);
INSERT INTO auto2023 VALUES('1f1345y789920by45', 'Ford', 'Edge', 'Fullsize', 35.52);
INSERT INTO auto2023 VALUES('1f1445y789920by45', 'Ford', 'Edge', 'Fullsize', 35.52);
INSERT INTO auto2023 VALUES('1f2145y789920by45', 'Ford', 'Focus', 'Compact', 23.52);
INSERT INTO auto2023 VALUES('1f2245y789920by45', 'Ford', 'Focus', 'Compact', 23.52);
INSERT INTO auto2023 VALUES('1f2345y789920by45', 'Ford', 'Focus', 'Compact', 23.52);
INSERT INTO auto2023 VALUES('1f2445y789920by45', 'Ford', 'Focus', 'Compact', 23.52);
INSERT INTO auto2023 VALUES('1f2545y789920by45', 'Ford', 'Focus', 'Compact', 23.52);
INSERT INTO auto2023 VALUES('1f3145y789920by45', 'Ford', 'F150', 'Truck or Van', 40.22);

INSERT INTO auto2023 VALUES('1t1145y789920by45', 'Toyota', 'Corolla', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1t1245y789920by45', 'Toyota', 'Corolla', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1t1345y789920by45', 'Toyota', 'Corolla', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1t1445y789920by45', 'Toyota', 'Corolla', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1t1545y789920by45', 'Toyota', 'Corolla', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1t2145y789920by45', 'Toyota', 'Camry', 'Fullsize', 27.22);
INSERT INTO auto2023 VALUES('1t2245y789920by45', 'Toyota', 'Camry', 'Fullsize', 27.22);
INSERT INTO auto2023 VALUES('1t2345y789920by45', 'Toyota', 'Camry', 'Fullsize', 27.22);
INSERT INTO auto2023 VALUES('1t3145y789920by45', 'Toyota', 'Land Cruiser', 'SUV', 44.46);
INSERT INTO auto2023 VALUES('1t3245y789920by45', 'Toyota', 'Land Cruiser', 'SUV', 44.46);

INSERT INTO auto2023 VALUES('1n1145y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n1245y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n1345y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n1445y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n1545y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n1645y789920by45', 'Nissan', 'Versa', 'Compact', 24.52);
INSERT INTO auto2023 VALUES('1n2145y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n2245y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n2345y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n2445y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n2545y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n2645y789920by45', 'Nissan', 'Sentra', 'Fullsize', 27.52);
INSERT INTO auto2023 VALUES('1n3145y789920by45', 'Nissan', 'Quest', 'Truck or Van', 37.52);
INSERT INTO auto2023 VALUES('1n3245y789920by45', 'Nissan', 'Quest', 'Truck or Van', 37.52);
INSERT INTO auto2023 VALUES('1n3345y789920by45', 'Nissan', 'Quest', 'Truck or Van', 37.52);
INSERT INTO auto2023 VALUES('1n3445y789920by45', 'Nissan', 'Quest', 'Truck or Van', 37.52);
INSERT INTO auto2023 VALUES('1n4145y789920by45', 'Nissan', 'Pathfinder', 'SUV', 47.52);
INSERT INTO auto2023 VALUES('1n4245y789920by45', 'Nissan', 'Pathfinder', 'SUV', 47.52);


-- Insert data into carCust table
INSERT INTO carCust2023 (lname, fname, driversLicense, st, username)
VALUES ('Mouse', 'Mickey', 'D123456', 'CA', 'mickey');

-- Insert data into rental table
INSERT INTO rental2023 (rentNum, driversLicense, VIN, startDate, endDate)
VALUES (1, 'D123456', 'ABC12345678901234', '2023-05-10', '2023-05-17');

-- Insert data into payment table
INSERT INTO payment2023 (creditCardNum, rentNum, cType)
VALUES ('1234567812345678', 1, 'AMEX');

