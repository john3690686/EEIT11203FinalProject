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
  salt VARCHAR(MAX),
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

Create Table Product(
   productId int identity(1,1),
   productName varchar(50) not null,
   intro nvarchar(500),
   price int not null,
   tag varchar(50),
   productImage varbinary(Max),
   uploadTime datetime,
   downloadTime datetime,
   primary Key(productId)
)
go

select * from Profile
go

select * from ProfileDetail
go

--====================================���w��product=======================================--
INSERT INTO Product(productName,intro,price,tag, productImage)
select 'DARK SOULS: REMASTERED','���@�ѡA�U�_�F�Ĥ@�Τ��C ���s������D�ʡB�N��ʤQ�����g��C���C �g�L�e�责�ɡA�N�H���v��60fps�Φ��e�{�A���n����ù�w�����ǳƧa�C �·t�F�� Remastered�]�t�C������A�H��DLC�mArtorias of the Abyss�n�C ','1000','�ʧ@',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale1.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Terraria','Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game. Four Pack also available! ','800','�����t',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale2.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Resident Evil3','���ްk����̤]�|�Q�l�ܵ����C �ԩ����o�ͬ�p��Ӫ��ͪ��a�`�A�󬰥��j���¯ٳQ��J�ܳo�ӳv���Y�쪺�����K�K �h�����M���B�E���@�ͪ����I�ʧ@�M���s�غc���k�ͼ@�A�@�@�W�G�A���w�Q�C �A��k���o������ܡH �P�ɦ����mResident Evil Resistance�n�C','1790','����',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale3.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Age of Empires II: Definitive Edition','���v�H�ӳ̨��w�諸�Բ��C�����@��� 20 �g�~�A�����ڭ̱��X�F�mAge of Empires II: Definitive Edition�n�C���@�֦���H�� 4K �W���e��A�������m���s���n���֡A�H�Τ��t 3 �ӷs�ԧЩM 4 �ӷs��������s���e�G�m�̫᪺�i���n�C ','600','����',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale4.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Monster Hunter','�s���ͩR���a�C���y, �N�O����! �b�̷s�@�uMonster Hunter: World�v��, ���a�i�H����׷������y�ͬ�, ���ηs�غc���@�ɤ��U�ئU�˪��a�� �P�ͺA���Ҩɨ����y����߻P���ġC','1800','�����t',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Sekiro: Shadows Die Twice','�b�Ѷ}�o��FromSoftware�]Dark Souls�t�C���s�@���^�����s���I���}�ݧA���_�������C �i�r�_���A���^�a�A�A�������ġC ','1033','�ʧ@',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale6.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'For The King','For The King�O�@�ڵ��X��C�M roguelike ������������V���Բ��� RPG �C���C�i�H�b�u�M����i���H�Φh�H�X�@���C������C','318','����',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale7.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Mount & Blade II: Bannerlord','The horns sound, the ravens gather. An empire is torn by civil war. Beyond its borders, new kingdoms rise. Gird on your sword, don your armour, summon your followers and ride forth to 
  win glory on the battlefields of Calradia. Establish your hegemony and create a new world out of the ashes of the old.','1399','����',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale8.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'The Witcher 3: Wild Hunt','��Ԥ��b�_���쩵�N�A�Ǭ��S�N���U�ר�@�ͳ̭��j���e�U�G�l�M�i�H�ٰʥ@�ɪ��Z���A�w�����l���U���C','868','�����t',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale9.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Divinity: Original Sin 2','The eagerly anticipated sequel to the award-winning RPG. Gather your party. Master deep, tactical combat. Join up to 3 other players - but know that only one of you will have the chance 
  to become a God.','1038','�����t',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale10.jpg', Single_Blob)as gamepic
go

select * from Product
go

Create Table Orders(
   orderId int identity(1,1),
   userId int,
   buyDatetime datetime default getDate(),
   purchase int not null,
   hash varchar(20),
   payResult varchar(1),
   Primary Key(orderId),
   Foreign Key (userId) References Profile(userId),
)
go

select * from Orders
go


Create Table OrderDetail(
   detailId int not null primary key identity(1,1),
   orderId int,
   productId int,
   price int not null,
   Foreign Key (orderId) References Orders(orderId),
   Foreign Key (productId) References Product(productId),
)
go
select * from OrderDetail
go
Create Table Comment(
   comId int identity(1,1),
   userId int,
   productId int,
   comment varchar(255),
   postDatetime datetime,
   reply varchar(255),
   replyDatetime datetime default getDate(),
   Primary Key(comId),
   Foreign Key (userId) References Profile(userId),
   Foreign Key (productId) References Product(productId),
)
go

Create Table Wish(
   wishId int identity(1,1),
   userId int,
   productId int,
   accomplish varchar(30),
   Primary Key(wishId),
   Foreign Key (userId) References Profile(userId),
   Foreign Key (productId) References Product(productId),
)
go
select * from Wish
go

Create Table Event(
   eventId int primary key identity(1,1),
   productId int,
   eventName varchar(255),
   content varchar(255),
   startDate datetime not null,
   endDate datetime not null,
   eventImage varbinary(Max)
)
go

select * from Profile
go

Create View ComandPro as
Select C.comId, P.userId, P.nickname, C.productId,  
C.comment, C.postDatetime, 
C.reply, C.replyDatetime from Profile as P
Join	Comment as C on P.userId = C.userId
GO
--DROP TABLE Product
--DROP TABLE ProfileDetail
--DROP TABLE Profile
--DELETE FROM ProfileDetail 
--DELETE FROM Profile

--EXEC sp_rename 'Profile.userToken', 'salt', 'COLUMN';
--ALTER TABLE Profile ALTER column salt varchar(Max)

Create Table Article(
	articleID int identity(1,1) not null,
	userId int NOT NULL ,
	articleTitle nvarchar(100) not null,
	articleAbstract nvarchar(200) not null,
	articleContent nvarchar(max) not null,
	articleThumbnail nvarchar(max),
	postDatetime datetime,
	updateDatetime datetime 
)
go

Create Table ArticleMessage(
	messageID int identity(1,1) not null,
	articleID int  not null,
	respUserId int NOT NULL ,
	messageContent nvarchar(max) not null,
	postDatetime datetime
)
go

Create Table ReplyMessage(
	replyMessageID int  identity(1,1) not null,
	articleID int  not null,
	messageID int not null,
	messageContent nvarchar(max) not null,
	postDatetime datetime
)

select * from Article
select * from ArticleMessage
select * from ReplyMessage
go
