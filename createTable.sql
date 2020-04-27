create database gameshop
go
use gameshop
go

CREATE TABLE Profile(
  userId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  userAccount VARCHAR(50) NOT NULL UNIQUE,
  userName NVARCHAR(50) NOT NULL,
  userPwd VARCHAR(50) NOT NULL,
  userToken VARCHAR(100),
  nickname NVARCHAR(50) NOT NULL UNIQUE,
  mail VARCHAR(100) NOT NULL UNIQUE,
  gender VARCHAR(1) ,
  userImg VARBINARY(MAX)
)
GO

CREATE TABLE ProfileDetail(
  userId INT NOT NULL FOREIGN KEY REFERENCES Profile(userId),
  address NVARCHAR(MAX),
  birthday DATE,
  phone VARCHAR(100)
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
insert into Product(productName,intro,price,tag,productImage) values
('alien war','intro1',300,'action',
(select * from openrowset(BULK N'C:\DataSource\teamproject\img\sale1.jpg',SINGLE_BLOB)as t3 ))

insert into Product(productName,intro,price,tag,productImage) values
('industry manager','intro2',600,'manager',
(select * from openrowset(BULK N'C:\DataSource\teamproject\img\sale1.jpg',SINGLE_BLOB)as t3 ))

insert into Product(productName,intro,price,tag,productImage) values
('gun','intro3',50,'guns',
(select * from openrowset(BULK N'C:\DataSource\teamproject\img\sale1.jpg',SINGLE_BLOB)as t3 ))

INSERT INTO Product(productName,intro,price,tag,productImage)
select 'Dark Souls','intro4',1000,'Action',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale1.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag,productImage)
select 'Terraria','intro5',800,'RPG',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale2.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag,productImage)
select 'Resident Evil3','intro6',1790,'Horror',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale3.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag,productImage)
select 'Age Of Empires','intro7',600,'RTS',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale4.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag,productImage)
select 'Monster Hunter','intro8',800,'RPG',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic
go
--====================================晨安的product=======================================--
INSERT INTO Product(productName,intro,price,tag, productImage)
select 'DARK SOULS: REMASTERED','有一天，燃起了第一團火。 重新體驗話題性、代表性十足的經典遊戲。 經過畫質提升，將以驚豔的60fps形式呈現，做好重返羅德蘭的準備吧。 黑暗靈魂 Remastered包含遊戲本體，以及DLC《Artorias of the Abyss》。 ','1000','Action',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale1.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Terraria','Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game. Four Pack also available! ','800','RPG',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale2.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Resident Evil3','不管逃到哪裡也會被追至絕路。 拉昆市發生突如其來的生物災害，更為巨大的威脅被投入至這個逐漸崩潰的城鎮中…… 多重的危機、九死一生的驚險動作和重新建構的逃生劇，一一超乎你的預想。 你能逃離這片絕望嗎？ 同時收錄《Resident Evil Resistance》。','1790','Horror',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale3.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Age of Empires II: Definitive Edition','有史以來最受歡迎的戰略遊戲之一迎來 20 週年，為此我們推出了《Age of Empires II: Definitive Edition》。本作擁有驚人的 4K 超高畫質，全面重置的新原聲音樂，以及內含 3 個新戰役和 4 個新文明的全新內容：《最後的可汗》。 ','600','RTS',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale4.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Monster Hunter','新的生命之地。狩獵, 就是本能! 在最新作「Monster Hunter: World」中, 玩家可以體驗終極的狩獵生活, 活用新建構的世界中各種各樣的地形 與生態環境享受狩獵的驚喜與興奮。','1800','RPG',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Sekiro: Shadows Die Twice','在由開發商FromSoftware（Dark Souls系列的製作單位）的全新歷險中開拓你的復仇之路。 勇猛復仇，挽回榮譽，巧妙殺敵。 ','1033','Action',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'For The King','For The King是一款結合桌遊和 roguelike 類型元素的跨越領域戰略型 RPG 遊戲。可以在線和單機進行單人或多人合作的遊戲體驗。 ','318','RTS',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic
go

select * from Product
go


Create Table Orders(
   orderId int identity(1,1),
   userId int,
   buyDatetime datetime default getDate(),
   purchase int not null,
   hash varchar(30),
   Primary Key(orderId),
   Foreign Key (userId) References Profile(userId),
   payResult varchar(1),	-- "P" is for Pending, "Y" is for Complete, "N" id s for Failed
)
go

select * from Orders
go
select * from OrderDetail
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
   eventId int identity(1,1),
   productId int,
   eventName varchar(50),
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