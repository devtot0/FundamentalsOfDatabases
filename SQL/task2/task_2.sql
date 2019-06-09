--Task 2
-- 1.	Creation and selecting database as an active one:
-- One cannot create a database and switch to it in one query. Instead we use the GO command to send the CREATE DATABASE as a separate query first.
CREATE DATABASE LIBRARY;

GO

USE LIBRARY;

--2.	Creation of the MEMBERS table:
CREATE TABLE MEMBERS (
    CardNo CHAR(5) PRIMARY KEY,
    Surname VARCHAR(15) NOT NULL,
    Name VARCHAR(15) NOT NULL,
    Address VARCHAR(150),
    Birthday_DATE DATE NOT NULL,
    Gender CHAR,
    Phone_No VARCHAR(15),
    CONSTRAINT CK_Gender CHECK ([Gender] IN ('M', 'F')),
    CONSTRAINT CardNo_length CHECK ( LEN([CardNo]) = 5 )
);

--3.	Creation of the Employees table and adding the Gender field:
CREATE TABLE Employees (
    emp_id INTEGER PRIMARY KEY IDENTITY(1,1),
    Surname VARCHAR(15) NOT NULL,
    Name VARCHAR(15) NOT NULL,
    Birthday_DATE DATE NOT NULL,
    Emp_DATE DATE,
    Gender CHAR,
    CONSTRAINT CK_Emp_DATE CHECK (Emp_DATE > Birthday_DATE),
    CONSTRAINT CK_Gender_Employees CHECK ([Gender] IN ('M', 'F'))
);

--4.	Creation of the Publishers table:
CREATE TABLE Publishers (
    pub_id INTEGER PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Phone_No VARCHAR(15)
);

--5.	Creation of the Books table:
CREATE TABLE Books (
    BookID CHAR(5) PRIMARY KEY,
    Pub_ID INTEGER FOREIGN KEY REFERENCES Publishers(pub_id),
    Type VARCHAR,
    Price MONEY NOT NULL,
    Title VARCHAR(40) NOT NULL,
    CONSTRAINT BookID_length CHECK ( LEN([BookID]) = 5 ),
    CONSTRAINT CK_Type CHECK (Type IN ('novel', 'historical', 'for kids', 'poems', 'crime story', 'science fiction', 'science'))
);

--6.	Creation of the BOOK_LOANS table and adding constraint forcing the uniqueness of the pair values:
CREATE TABLE BOOK_LOANS (
    LoanID INTEGER PRIMARY KEY IDENTITY(1,1),
    CardNo CHAR(5) FOREIGN KEY REFERENCES MEMBERS(CardNo),
    BookID CHAR(5) FOREIGN KEY REFERENCES Books(BookID),
    emp_id INTEGER FOREIGN KEY REFERENCES Employees(emp_id),
    DateOut DATE,
    DueDate DATE,
    Penalty MONEY CHECK (Penalty >= 0) DEFAULT 0,
    CONSTRAINT CK_DATE CHECK (DueDate > DateOut),
);

--Additional exercises
--1.	Creation and selecting database as active one:
CREATE DATABASE video_renting;
GO
USE video_renting;

--2.	Creation of Member table:
CREATE TABLE Member (
	MEMBER_ID INTEGER IDENTITY(1, 1) PRIMARY KEY,
	LAST_NAME VARCHAR(25) NOT NULL,
	FIRST_NAME VARCHAR(25),
	ADDRESS VARCHAR(100),
	CITY VARCHAR(30),
	PHONE VARCHAR(15),
	JOIN_DATE DATETIME DEFAULT GETDATE() NOT NULL
	);

--3.	Creation of Title table with Category and Rating as enumerable char values:
CREATE TABLE Title (
	TITLE_ID INTEGER IDENTITY(1, 1) PRIMARY KEY,
	TITLE VARCHAR(60) NOT NULL,
	DESCRIPTION VARCHAR(400) NOT NULL,
	RATING VARCHAR(4) CHECK (RATING IN ('G', 'PG', 'R', 'NC17', 'NR')),
	CATEGORY VARCHAR(20) CHECK (CATEGORY IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY')),
	RELEASE_DATE DATETIME
	);

--4.	Creation of Title_copy table with primary key as composition of own ID with foreign key to Title ID:
CREATE TABLE Title_copy (
	COPY_ID INTEGER NOT NULL,
	TITLE_ID INTEGER FOREIGN KEY REFERENCES Title(TITLE_ID) NOT NULL,
	RATING VARCHAR(15) CHECK (RATING IN ('AVAILABLE', 'DESTROYED', 'RENTED', 'RESERVED')) NOT NULL,
	CONSTRAINT pk_title_copy PRIMARY KEY (
		COPY_ID,
		TITLE_ID
		)
	);

--5.	Creation of Rental table with a foreign key to Title_copy primary key which consists of two values:
CREATE TABLE Rental (
	BOOK_DATE DATE DEFAULT GETDATE(),
	COPY_ID INTEGER,
	MEMBER_ID INTEGER FOREIGN KEY REFERENCES Member(MEMBER_ID),
	TITLE_ID INTEGER,
	ACT_RET_DATE DATETIME,
	EXP_RET_DATE DATETIME DEFAULT DATEADD(day, 2, GETDATE()),
	CONSTRAINT pk_rental PRIMARY KEY (
		BOOK_DATE,
		MEMBER_ID,
		COPY_ID
		),
	CONSTRAINT fk_rental FOREIGN KEY (
		COPY_ID,
		TITLE_ID
		) REFERENCES Title_copy(COPY_ID, TITLE_ID)
	);

--6.	Creation of Reservation table with unique composition of two values: 
CREATE TABLE Reservation (
	RES_DATE DATETIME NOT NULL,
	MEMBER_ID INTEGER FOREIGN KEY REFERENCES Member(MEMBER_ID) NOT NULL,
	TITLE_ID INTEGER FOREIGN KEY REFERENCES Title(TITLE_ID) NOT NULL,
	CONSTRAINT fk_reservation PRIMARY KEY (
		RES_DATE,
		MEMBER_ID,
		TITLE_ID
		),
	CONSTRAINT unique_composition UNIQUE (
		RES_DATE,
		MEMBER_ID
		)
	);

--7.	Results of execution of popul_video.sql query can be obtained by:
SELECT * FROM Member;
 
SELECT * FROM Title;
 
SELECT * FROM Title_copy;
 
SELECT * FROM Rental;
 
SELECT * FROM Reservation;
