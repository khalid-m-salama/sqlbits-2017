USE Sqlbitsdemo;

CREATE SCHEMA demo;

CREATE TABLE demo.Data
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Input]  FLOAT,
	[Output] FLOAT
);

CREATE TABLE demo.Models
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(50),
	[Model] VARBINARY(MAX),
	ModifiedDate DateTime
);
