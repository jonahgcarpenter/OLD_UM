DROP TABLE IF EXISTS login2023;

CREATE TABLE login2023 (username VARCHAR(8) NOT NULL,
					password VARCHAR(60),
					permission CHARACTER(1),
					PRIMARY KEY(username)
					);
				  
INSERT INTO login2023 VALUES ('amiller', '$2y$10$ZTNlZjZmMWVkMjMxOWE3MOsaMyvDRUPJSR5VWJ.QwG0zd4rkdLaMu', 'y');
INSERT INTO login2023 VALUES ('jsmith', '$2y$10$ZTNlZjZmMWVkMjMxOWE3MOsaMyvDRUPJSR5VWJ.QwG0zd4rkdLaMu', 'n');
