--Task 2
-- 1.	Creation and selecting database as an active one:
-- One cannot create a database and switch to it in one query. Instead we use the GO command to send the CREATE DATABASE as a separate query first.
CREATE DATABASE LIBRARY;
GO

-- It's not possible to use 'CREATE' and 'USE' in the same query; we assume that the base is already created
USE LIBRARY;

-- 2.	Creation of the MEMBERS table:
CREATE TABLE MEMBERS (
    CardNo char(5) PRIMARY KEY,
    Surname varchar(15) not null,
    Name varchar(15) not null,
    Address varchar(150),
    Birthday_date date not null,
    Gender char,
    Phone_No varchar(15),
    CONSTRAINT CK_Gender CHECK ([Gender] IN ('M', 'F')),
    CONSTRAINT CardNo_length CHECK ( LEN([CardNo]) = 5 )
);

-- 3. Creation of the Employees table and adding the Gender field:
CREATE TABLE Employees (
    emp_id integer PRIMARY KEY IDENTITY(1,1),
    Surname varchar(15) NOT NULL,
    Name varchar(15) NOT NULL,
    Birthday_date date NOT NULL,
    Emp_date date,
    Gender char,
    CONSTRAINT CK_Emp_date CHECK (Emp_date > Birthday_date),
    CONSTRAINT CK_Gender_Employees CHECK ([Gender] IN ('M', 'F'))
);

-- 4.	Creation of the Publishers table:
CREATE TABLE Publishers (
    pub_id integer PRIMARY KEY IDENTITY(1,1),
    Name varchar(50) NOT NULL,
    City varchar(50) NOT NULL,
    Phone_No varchar(15)
);

-- 5.	Creation of the Books table:
CREATE TABLE Books (
    BookID char(5) PRIMARY KEY,
    Pub_ID integer FOREIGN KEY REFERENCES Publishers(pub_id),
    Type varchar,
    Price money NOT NULL,
    Title varchar(40) NOT NULL,
    CONSTRAINT BookID_length CHECK ( LEN([BookID]) = 5 ),
    CONSTRAINT CK_Type CHECK (Type IN ('novel', 'historical', 'for kids', 'poems', 'crime story', 'science fiction', 'science'))
);

-- 6.	Creation of the BOOK_LOANS table and adding constraint forcing the uniqueness of the pair values:
CREATE TABLE BOOK_LOANS (
    LoanID integer PRIMARY KEY IDENTITY(1,1),
    CardNo char(5) FOREIGN KEY REFERENCES MEMBERS(CardNo),
    BookID char(5) FOREIGN KEY REFERENCES Books(BookID),
    emp_id integer FOREIGN KEY REFERENCES Employees(emp_id),
    DateOut date,
    DueDate date,
    Penalty money CHECK (Penalty >= 0) DEFAULT 0,
    CONSTRAINT CK_date CHECK (DueDate > DateOut),
);

