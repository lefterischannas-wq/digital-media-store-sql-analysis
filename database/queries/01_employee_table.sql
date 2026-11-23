CREATE TABLE EMPLOYEE (
    EmployeeId INTEGER NOT NULL,
    LastName TEXT(20) NOT NULL,
    FirstName TEXT(20) NOT NULL,
    Title TEXT(30),
    ReportsTo INTEGER,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Email TEXT(60) NOT NULL,
    PRIMARY KEY (EmployeeId),
    FOREIGN KEY (ReportsTo) REFERENCES EMPLOYEE (EmployeeId)
);

INSERT INTO EMPLOYEE (EmployeeId, LastName, FirstName, Title, ReportsTo, BirthDate, HireDate, Email) VALUES
(1, 'Adams', 'Andrew', 'General Manager', NULL, '1962-02-18', '2002-08-14', 'andrew@chinookcorp.com'),
(2, 'Edwards', 'Nancy', 'Sales Manager', 1, '1958-12-08', '2002-05-01', 'nancy@chinookcorp.com'),
(3, 'Peacock', 'Jane', 'Sales Support Agent', 2, '1973-08-29', '2002-04-01', 'jane@chinookcorp.com'),
(4, 'Park', 'Margaret', 'Sales Support Agent', 2, '1947-09-19', '2003-05-03', 'margaret@chinookcorp.com'),
(5, 'Johnson', 'Steve', 'Sales Support Agent', 2, '1965-03-03', '2003-10-17', 'steve@chinookcorp.com'),
(6, 'Mitchell', 'Michael', 'IT Manager', 1, '1973-07-01', '2003-10-17', 'michael@chinookcorp.com'),
(7, 'King', 'Robert', 'IT Staff', 6, '1970-05-29', '2004-01-02', 'robert@chinookcorp.com'),
(8, 'Callahan', 'Laura', 'IT Staff', 6, '1968-01-09', '2004-03-04', 'laura@chinookcorp.com');

SELECT * FROM EMPLOYEE;
