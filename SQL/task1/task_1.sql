--Define new database named test_yourname using CREATE DATABASE statement.
--One cannot create a database and switch to it in one query. Instead we use the GO command to send the CREATE DATABASE as a separate query first.
CREATE DATABASE test_f9;
GO

--Check the name of the database you are connected to. You can change a current database using the statement: USE database_name
USE test_f9;

--Define table named BANDS, which consists of the following columns: band_id – integer, primery key,  name – varchar limited to 40 characters, origin_country -  varchar limited to 50 characters, formed_year – integer.
CREATE TABLE BANDS (
	band_id INTEGER PRIMARY KEY,
	name VARCHAR(40),
	origin_country VARCHAR(50),
	formed_year INTEGER
	);

--Check the number of records in that table using SELECT count(*) … statement.
SELECT COUNT(*) FROM BANDS; 

----Insert into the table one record: name: The Beatles, origin_country: England, formed_year 1960
INSERT INTO BANDS (band_id, name, origin_country, formed_year)
VALUES (1, 'The Beatles', 'England', 1960);

--Display all the data using SELECT statement.
SELECT * FROM BANDS;

--Check the number of records in that table again.
SELECT COUNT(*) FROM BANDS; 

--Create another table named MEMBERS consisted of: memeber_id - integer incremental from 100 by 1, band_id - int, surname - varchar limited to 60 characters, name varchar limited to 50 characters.
CREATE TABLE MEMBERS (
	member_id INTEGER PRIMARY KEY IDENTITY(100, 1),
	band_id INTEGER,
	surname VARCHAR(60),
	name VARCHAR(50),
	);

--Add foreign key on band_id column of MEMBERS table, which references BANDS table.
ALTER TABLE MEMBERS ADD
CONSTRAINT fk_members_bands FOREIGN KEY (band_id) REFERENCES BANDS(band_id)

--Insert into that table 2 records for The Beatles band: John Lennon and Paul McCartney.
DECLARE @band INT;

SELECT @band = band_id
FROM BANDS
WHERE name = 'The Beatles';

INSERT INTO MEMBERS (band_id, surname, name)
VALUES (@band, 'Lennon', 'John');

INSERT INTO MEMBERS (band_id, surname, name)
VALUES (@band, 'McCartney', 'Paul');


--Insert into BANDS table another record: name: Queen, origin_country: Great Britain, formed_year: 1971
INSERT INTO BANDS (band_id, name, origin_country, formed_year)
VALUES (2, 'Queen', 'Great Britain', 1971);

--Insert another member: Freddie Mercury.
--DECLARE @band INT;

SELECT @band = band_id
FROM BANDS
WHERE name = 'Queen';

INSERT INTO MEMBERS (band_id, surname, name)
VALUES (@band, 'Mercury', 'Freddie');


--Add constraint, which doesn’t allow entering year earlier than 1920.
ALTER TABLE BANDS ADD CHECK (formed_year >= 1920);

--Add another record to ensure that the constraint works properly.
--Will return an error.
--INSERT INTO BANDS (band_id, name, origin_country, formed_year)
--VALUES (3, 'Louisiana Five', 'United States', 1917);

