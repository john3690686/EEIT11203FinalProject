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

--====================================辰安的product=======================================--
INSERT INTO Product(productName,intro,price,tag, productImage)
select 'DARK SOULS: REMASTERED','有一天，燃起了第一團火。 重新體驗話題性、代表性十足的經典遊戲。 經過畫質提升，將以驚豔的60fps形式呈現，做好重返羅德蘭的準備吧。 黑暗靈魂 Remastered包含遊戲本體，以及DLC《Artorias of the Abyss》。 ','1000','動作',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale1.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Terraria','Dig, fight, explore, build! Nothing is impossible in this action-packed adventure game. Four Pack also available! ','800','角色扮演',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale2.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Resident Evil3','不管逃到哪裡也會被追至絕路。 拉昆市發生突如其來的生物災害，更為巨大的威脅被投入至這個逐漸崩潰的城鎮中…… 多重的危機、九死一生的驚險動作和重新建構的逃生劇，一一超乎你的預想。 你能逃離這片絕望嗎？ 同時收錄《Resident Evil Resistance》。','1790','恐怖',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale3.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Age of Empires II: Definitive Edition','有史以來最受歡迎的戰略遊戲之一迎來 20 週年，為此我們推出了《Age of Empires II: Definitive Edition》。本作擁有驚人的 4K 超高畫質，全面重置的新原聲音樂，以及內含 3 個新戰役和 4 個新文明的全新內容：《最後的可汗》。 ','600','策略',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale4.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Monster Hunter','新的生命之地。狩獵, 就是本能! 在最新作「Monster Hunter: World」中, 玩家可以體驗終極的狩獵生活, 活用新建構的世界中各種各樣的地形 與生態環境享受狩獵的驚喜與興奮。','1800','角色扮演',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale5.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Sekiro: Shadows Die Twice','在由開發商FromSoftware（Dark Souls系列的製作單位）的全新歷險中開拓你的復仇之路。 勇猛復仇，挽回榮譽，巧妙殺敵。 ','1033','動作',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale6.jpg', Single_Blob)as gamepic

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'For The King','For The King是一款結合桌遊和 roguelike 類型元素的跨越領域戰略型 RPG 遊戲。可以在線和單機進行單人或多人合作的遊戲體驗。','318','策略',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale7.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Mount & Blade II: Bannerlord','The horns sound, the ravens gather. An empire is torn by civil war. Beyond its borders, new kingdoms rise. Gird on your sword, don your armour, summon your followers and ride forth to 
  win glory on the battlefields of Calradia. Establish your hegemony and create a new world out of the ashes of the old.','1399','策略',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale8.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'The Witcher 3: Wild Hunt','當戰火在北方領域延燒，傑洛特將接下終其一生最重大的委託：追尋可以撼動世界的武器，預言之子的下落。','868','角色扮演',
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale9.jpg', Single_Blob)as gamepic
go

INSERT INTO Product(productName,intro,price,tag, productImage)
select 'Divinity: Original Sin 2','The eagerly anticipated sequel to the award-winning RPG. Gather your party. Master deep, tactical combat. Join up to 3 other players - but know that only one of you will have the chance 
  to become a God.','1038','角色扮演',
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
   eventId int Primary Key  identity(1,1),
   productId int,
   eventName varchar(max),
   content varchar(max),
   startDate date not null,
   endDate date not null,
   eventImage varbinary(Max)
)
go

--===============Event Data===============--
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1','微軟將於 5月7日首度揭露新一代 Xbox Series X 主機遊戲實際遊玩展示',
'Xbox今（1）日在官方 Twitter 上預告，將於台灣時間 5 月 7 日晚間 11:00 帶來最新一集「Inside Xbox」直播節目，首度揭露預定 2020 年底推出之研發中新一代主機「Xbox Series X」的遊戲實際遊玩展示。Xbox Series X 是微軟預定 2020 年年底推出的下一代 Xbox 主機。配備整合 AMD Ryzen Zen 2 CPU 核心與 Radeon RDNA 2 繪圖架構 GPU 核心的整合處理器。提供 8 倍於前代、高達12TFLOPS 的圖形處理效能。支援硬體加速光影追蹤，最高 8K 解析度 120fps 畫面輸出，內建高速 SSD，並相容 Xbox One 遊戲軟體。',
'2020-05-01','2020-05-07',
(select * from BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\Xbox01.jpg', Single_Blob)as a where eventId=1)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('2','保有史上最高獎金電競比賽紀錄的《Dota 2》國際邀請賽宣布今年因疫情將延期舉辦',
'Valve 今日宣布，旗下《Dota 2》年度重要賽事第十屆《Dota 2》國際邀請賽（TI10）將因疫情延期舉辦，或許可能要到明年（2021 年）才能舉辦。Valve 表示，由於疫情引發全球衛生危機，經過多方面的考量、他們決定延後舉辦國際邀請賽，他們研究了許多可能舉辦的時間，但賽事或許要到 2021 年才能舉辦。考量到各地限制人群聚集的規定、病毒的傳播軌跡與全球通航政策等因素，Valve 指出，他們短期內還無法提供明確的賽事舉辦日期，但他們也在重新規劃秋季巡迴賽，並將盡快提供更多消息。 Valve 表示，第十屆國際邀請賽總獎金也將會包含下一個戰鬥通行證 25% 銷售額，他們計畫不久後會先推出戰鬥通行證，而非等到賽事快來臨時，但由於團隊目前是以在家上班的方式工作，所以戰鬥通行證的推出時程也會較以往至少延遲數週。',
'2020-05-01','9999-01-01',(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\Dota2.png', Single_Blob)as a))
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1003','維京戰魂不朽！《刺客教條：維京紀元》正式揭露 將同步在 PS5、Xbox SX 主機推出',
'Ubisoft 於台灣時間 30 日晚間正式公開由 Ubisoft 蒙特婁工作室領軍開發的旗下暢銷遊戲《刺客教條（Assasin''s Creed）》系列最新作《刺客教條：維京紀元（Assassin’s Creed Valhalla）》首部預告片，確定遊戲將於 2020 年底在 PS4、Xbox One、PC 以及下一代 PS5、Xbox Series X 主機同步推出。',
'2020-04-30','9999-01-01',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\刺客教條：維京紀元.jpg', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1004','《動物森友會》「貍克」登上封面！大誌雜誌第 122 期將探討 ACG「異世界」題材',
'The Big Issue Taiwan 大誌雜誌第 122 期將於 2020 年 5 月 1 日出刊，現正當紅的《集合啦！動物森友會》角色「貍克」登上封面！除了封面故事以「動物森友會與森友們」為主題，亦向名人邀稿帶來「我的動森之島」特輯。',
'2020-05-01','9999-01-01',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\動物森友會.jpg', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1005','《泡泡糖忍戰》搶先體驗會 四面八方來回縱橫的新時代忍術對戰',
'GungHo 預定 5 月 28 日推出的 Nintendo Switch 忍者泡泡糖動作遊戲《泡泡糖忍戰（ニンジャラ）》（採基本免費制營運）在 4 月 29 日舉辦了搶先體驗會，以下就要為大家帶來搶先體驗會的試玩報導。',
'2020-04-29','9999-01-01',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\泡泡糖忍戰.jpg', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1006','突襲地獄對抗成群惡魔！《垂死之光》曝光新 DLC《地獄突襲 Hellraid》並預定今夏推出',
'遊戲開發商 Techland 公開《垂死之光（Dying Light）》全新 DLC《地獄突襲（Hellraid）》，玩家將有機會體驗地獄之旅並在深淵中大殺四方。《垂死之光：地獄突襲》預定今年夏季推出。
 
　　於 2015 年推出的《垂死之光》是款採用跑酷玩法的動作遊戲，玩家在充斥著殭屍的廣大開放世界舞台中盡可能的生存下去。今日，官方宣布將推出全新 DLC《地獄突襲》，並強調將帶領玩家真實地體驗一次突襲地獄、對抗成群惡魔的探險之旅。',
'2020-04-30','9999-01-01',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\垂死之光.png', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1007','《上古卷軸 Online：Greymoor》宣布將延後約一週上市 公開全新古文明系統影片',
'Bethesda Softworks 宣布，《上古卷軸 Online》最新冒險篇章《上古卷軸 Online：Greymoor》將延後約 一週上市，同步公開了最新遊戲預告影片。
 
　　原本 Bethesda 今年 1 月宣布《上古卷軸 Online：Greymoor》將於 5 月 18 日登陸 PC/Mac 平台、6 月 2 日推出 Xbox One 與 PS4 版，但官方今日發表聲明，將延後約一週上市。也就是說，《上古卷軸 Online：Greymoor》預定於台灣時間 5 月 27 日推出 PC/Mac 版本，而 6 月 10 日上市 Xbox One 與 PS4 版。',
'2020-04-30','9999-01-01',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\上古卷軸 Online：Greymoor.jpg', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1008','續作《海商王 4》公布發售日與封測版本資訊 封測將開放西班牙戰役與四個可玩角色',
'遊戲開發商 Gaming Minds Studios 與發行商 Kalypso Media 今日宣布《海商王》系列續作《海商王 4》2020 年 9 月 25 日發售，同時預告將在上市前於 PS4 平台展開封閉測試。',
'2020-04-30','2020-09-25',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\海商王4.jpg', Single_Blob)as a)
)
go

insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1009','《三國志 14》之《銀英傳》合作企劃第 3 彈 DLC 開放下載 免費更新同步實施',
'臺灣光榮特庫摩宣布，好評發售中的歷史模擬遊戲「三國志」系列最新作《三國志 14》（Windows / PlayStation 4）於今日 4 月 30 日（四）發布《銀河英雄傳說》第 3 彈 DLC 合作免費 DLC 第 3 彈。',
'2020-04-30','2020-04-30',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\三國志 14.jpg', Single_Blob)as a)
)
go


insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1010','獨立遊戲團隊解謎新作《Timelie》5 月 21 日發售 藉著操控時間軸來探索抽象世界',
'獨立遊戲團隊 Urnique Studio 宣布旗下研發的解謎新作《Timelie》將於 5 月 21 日發售，利用操控時間的能力解決問題並發現這抽象世界中的秘密。',
'2020-04-30','2020-05-21',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\Timelie.jpg', Single_Blob)as a)
)
insert into Event(productId,eventName,content,startDate,endDate,eventImage) values('1011','獨立團隊同樂新作《Gotcha》登陸 Steam 平台 限時內從大人手中救出其他小孩',
'由獨立遊戲製作團隊 Kidom 宣布，旗下同樂遊戲《Gotcha》將於今（30）日正式於 Steam 平台推出，玩家可以與最多三名朋友一起遊玩，逃離大人的追捕。',
'2020-04-30','2020-04-30',
(select * from Openrowset(Bulk N'C:\DataSource\teamproject\img\Gotcha.jpg', Single_Blob)as a)
)
go
select * from Event


Create View ComandPro as
Select C.comId, P.userId, P.nickname, C.productId,  
C.comment, C.postDatetime, 
C.reply, C.replyDatetime from Profile as P
Join	Comment as C on P.userId = C.userId
GO


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

--DROP TABLE Product
--DROP TABLE ProfileDetail
--DROP TABLE Profile
--DELETE FROM ProfileDetail 
--DELETE FROM Profile

--EXEC sp_rename 'Profile.userToken', 'salt', 'COLUMN';
--ALTER TABLE Profile ALTER column salt varchar(Max)