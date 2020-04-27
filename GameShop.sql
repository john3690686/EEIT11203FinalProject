CREATE DATABASE GameShop
ON
(
  NAME = 'GameShop',
  FILENAME='C:\GitHub\FinalProject\GameShop.mdf',
  SIZE = 10MB,
  FILEGROWTH=10%
)
GO

USE GameShop
GO


CREATE TABLE Profile(
  userId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  userAccount VARCHAR(50) NOT NULL UNIQUE,
  userName NVARCHAR(50) NOT NULL,
  userPwd VARCHAR(MAX) NOT NULL,
  salt INT NOT NULL,
  nickname NVARCHAR(50) NOT NULL UNIQUE,
  mail VARCHAR(100) NOT NULL UNIQUE,
  gender VARCHAR(1) ,
  userImg VARBINARY(MAX),
  mailState BIT DEFAULT 0
)
GO

CREATE TABLE ProfileDetail(
  userId INT NOT NULL FOREIGN KEY REFERENCES Profile(userId),
  address NVARCHAR(MAX),
  birthday DATE,
  phone VARCHAR(100),
  mailCode VARCHAR(255) NOT NULL,
  codeStartingDate DATE NOT NULL
)
GO

--DROP TABLE ProfileDetail
--DROP TABLE Profile
--DELETE FROM ProfileDetail 
--DELETE FROM Profile

--ALTER TABLE Profile ALTER column salt int
--EXEC sp_rename 'Profile.userToken', 'salt', 'COLUMN';