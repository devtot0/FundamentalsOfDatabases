CREATE DATABASE test_kacper;

USE test_kacper;

CREATE TABLE test_kacper.dbo.BANDS (
band_id INT PRIMARY KEY,
[name] VARCHAR(40),
origin_country VARCHAR(50),
formed_year INT
);

SELECT COUNT(*) FROM test_kacper.dbo.BANDS;
INSERT INTO test_kacper.dbo.BANDS VALUES(0,'The Beatles','England',1960);
SELECT * FROM test_kacper.dbo.BANDS;

CREATE TABLE test_kacper.dbo.MEMBERS (
member_id INT IDENTITY(100,1),
band_id INT FOREIGN KEY REFERENCES BANDS(band_id),
surname VARCHAR(60),
[name] VARCHAR(50)
);

SET IDENTITY_INSERT test_kacper.dbo.MEMBERS ON;

INSERT INTO test_kacper.dbo.MEMBERS(member_id, band_id, surname, [name]) VALUES(100,0,'Lennon','John');
INSERT INTO test_kacper.dbo.BANDS VALUES (1,'Queen','Great Britain',1971);
INSERT INTO test_kacper.dbo.MEMBERS(member_id, band_id, surname, [name]) VALUES (100,1,'Mercury','Freddie');

ALTER TABLE BANDS ADD CHECK(formed_year>1920);
INSERT INTO test_kacper.dbo.BANDS VALUES (2,'NobodyExpectsUs','Spain',1536);

SET IDENTITY_INSERT test_kacper.dbo.MEMBERS OFF;