CREATE DATABASE GameShop
ON
(
  NAME = 'GameShop',
  FILENAME='D:\SQLServerDataBase\GameShop.mdf',
  SIZE = 10MB,
  FILEGROWTH=10%
)
GO

USE GameShop
GO

CREATE TABLE Profile(
  userId int NOT NULL PRIMARY KEY identity(1,1) ,
  userName NVARCHAR(50) NOT NULL,
  userPwd NVARCHAR(50) NOT NULL,
  userToken NVARCHAR(100),
  nickname NVARCHAR(50) NOT NULL UNIQUE,
  mail NVARCHAR(100) NOT NULL UNIQUE,
  gender NVARCHAR(1) ,
  userImg VARBINARY(MAX)
)
GO

CREATE TABLE ProfileDetail(
  userId int NOT NULL FOREIGN KEY REFERENCES Profile(userId),
  address NVARCHAR(100),
  birthday DATE,
  phone VARCHAR(15)
)
GO

--DROP TABLE ProfileDetail
--DROP TABLE Profile

INSERT INTO Profile(userId,userName,nickName,userPwd,mail)
VALUES('uid1','unm1','nn1','upd1','u1@')

INSERT INTO ProfileDetail(userId)
VALUES('uid1')