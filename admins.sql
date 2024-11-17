DROP TABLE IF EXISTS admins;

CREATE TABLE admins (
	id int NOT NULL auto_increment,
	username varchar(50) NOT NULL,
	hashed_password varchar(60) NOT NULL,
	PRIMARY KEY (id)
);
