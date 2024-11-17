DROP TABLE IF EXISTS Employees, Departments;

CREATE TABLE Employees (
          EmployeeID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
          EmployeeName varchar(50),
          Age int,
          Salary double,
          Dept varchar(50)
) Engine=InnoDB;

CREATE TABLE Departments (
          DeptID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
          DeptName varchar(50),
          Age int,
          Budget double,
          BldgNum int
) Engine=InnoDB;

insert into Employees (EmployeeName, Age, Salary, Dept) values ('Marcia, Myers', 25, 73000, 'Sales');
insert into Employees (EmployeeName, Age, Salary, Dept) values ('Conrad, Ballard', 28, 63000, 'Sales');
insert into Employees (EmployeeName, Age, Salary, Dept) values ('Meredith, Powers', 29, 64000, 'HR');
insert into Employees (EmployeeName, Age, Salary, Dept) values ('Perry, Jackson', 23, 92000, 'Marketing');
insert into Employees (EmployeeName, Age, Salary, Dept) values ('Earl Horton', 35, 50000, 'Marketing');

insert into Departments (DeptName, Age, Budget, BldgNum) values ('Sales', 10, 300000, 1);
insert into Departments (DeptName, Age, Budget, BldgNum) values ('HR', 10, 150000, 2);
insert into Departments (DeptName, Age, Budget, BldgNum) values ('Marketing', 0, 300000, .5);