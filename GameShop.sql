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

--===============Event Data===============
INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '5','《魔物獵人》更新擊殺排行榜',
'本次統計時間為 4 月 17~23 日，僅統計 PS4 版，且不包含聚魔之地。 在擊殺排行中，上週位居首位的雷狼龍本週繼續霸榜冠軍，第二名至第五名分別是殲世滅盡龍、絢輝龍、冥赤龍與炎王龍。','2020-04-17','2020-04-23',
BulkColumn from Openrowset( Bulk N'E:\05.jpg', Single_Blob)as gamepic

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '3','《惡靈古堡 3 重製版》上市頭 5 天全球出貨突破 200 萬套 下載版佔比近半',
'CAPCOM 今（13）日宣布，2020 年 4 月 3 日推出的生存驚悚遊戲《惡靈古堡 3 重製版（Resident Evil 3）》（PS4 / Xbox One / PC），上市頭 5 天的全球出貨套數已達到 200 萬套，其中下載版佔比近半。《惡靈古堡》是以生化危機為題材，描寫深陷危機險境的角色運用武器與道具，突破重重難關逃出生天的生存驚悚遊戲，自 1996 年問世以來，全系列累計銷售已超過 9500 萬套，是 CAPCOM旗下最暢銷的系列。
 
　　本次推出的《惡靈古堡 3 重製版》則是 1999 年問世的《惡靈古堡》系列第 3 代的完全重製版，採用自家開發的「RE Engine」以最新技術重現當年的故事內容。此外還加入非對稱對戰玩法的全新多人連線模式。
 
　　官方宣布，《惡靈古堡 3 重製版》於上市頭 5 天的全球出貨套數已達到 200 萬套，其中數位下載版的銷售佔比已經達到約 50% 的水準。而 2019 年 1 月推出的《惡靈古堡 2 重製版》的銷售套數亦成長至 650 萬套。',
'2020-04-03','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\03.jpg', Single_Blob)as gamepic

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '7','戰略 RPG《為了國王 For The King》PS4、Switch 中文版即將發售',
'H2 Interactive 宣布，由 Curve Digital 製作的戰略 RPG《為了國王 For The King》將於 3 月 30 日發售PS4 及 Nintendo Switch 繁體中文版。',
'2020-03-30','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\07.jpg', Single_Blob)as gamepic
go

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '8','戰爭策略名作《騎馬與砍殺2：霸主》2020年3月登上Steam',
'結束多年等待，由 TaleWorlds 開發的中世紀動作角色扮演遊戲續作《騎馬與砍殺 2：霸主》（Mount & Blade 2: Bannerlord），在今年德國科隆遊戲展 Gamescom 2019 正式公布遊戲釋出時間點，預計 2020 年 3 月在 Steam 進入「搶先體驗」（Early Access）公開測試。
經過年初的封閉 Beta 測試活動，這次科隆遊戲展會中，TaleWorlds 在一支全新公開的預告片中證實了《騎馬與砍殺 2：霸主》預計將於 明年 3 月在 Steam 上進入搶先體驗階段。再過半年左右，玩家們就能夠玩到這款令全球玩家望穿秋水的傳奇之作。',
'2020-03-30','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\08.jpg', Single_Blob)as gamepic
go

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '6','2019 Steam大獎揭曉《隻狼》獲年度遊戲獎',
'由 Steam 玩家社群投票決定的 2019 Steam 大獎（Steam Award 2019）在 2020 年第一天正式公布，年度大獎不意外由今年甫拿下遊戲大獎 GOTY 的《隻狼：暗影雙死》（SEKIRO: Shadow Die Twice）獲得殊榮。

由黑魂系列團隊 From Software 去年推出的《隻狼：暗影雙死》甫一推出隨即在全球玩家社群造成轟動，本次擊敗與之一同競爭的《惡靈古堡 2 重製版》、《惡魔獵人 5》、《天命 2》、《星際大戰 絕地：組織》，獲得 Steam 年度最佳遊戲實至名歸。',
'2020-01-01','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\06.jpg', Single_Blob)as gamepic

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '2','挖掘！製作！戰鬥！《泰拉瑞亞 Terraria》NS 中文版 12 月 19 日發售',
'Spike Chunsoft Co., Ltd. 今（2）日宣布，將發行由美國 Re-Logic/Pipeworks 公司所開發的造物動作冒險遊戲《泰拉瑞亞（Terraria）》Nintendo Switch 中文版。本作預定於 2019 年 12 月 19 日發售，售價為新台幣 1,090 元／港幣 278 元。《泰拉瑞亞 Terraria》是由方塊所創造出的廣闊世界，玩家可以自由地挖掘、收集素材、製作道具及建築，創造出專屬自己的世界的造物動作冒險遊戲。
 
　　本作自 2011 年 PC 版發售後，在全世界創下了銷售量達 2,000 萬以上的亮眼成績，Spike Chunsoft 從 2013 年起便在日本的各遊戲平台販售，日本國內累計出貨量・下載數超過 90 萬，可說是受到眾多玩家支持的超人氣作品。而本次的新作 Nintendo Switch 版將會支援 PC 版的最新大型更新檔 Ver. 1.3。',
'2019-12-19','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\02.jpg', Single_Blob)as gamepic

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '9','【獵魔士】Netflix新劇效應！《Witcher 3》遊玩人數創新紀錄',
'《巫師》小說同名原著改編真人電視影集《獵魔士》於 Netfilx 上映後，除了為小說帶來了不小的推廣效果外，也對《巫師》系列的遊戲帶來了不小的影響，光是《巫師 3》（The Witcher 3）在 12 月 25 號的同時在線遊玩人數便創下了 55468 位的佳績。',
'2019-12-13','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\09.jpg', Single_Blob)as gamepic
go

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '10','《神諭：原罪2》推出第3部免費DLC',
'Larian Studios 最近公開他們為《神諭：原罪2》推出的第3波免費 DLC 已經登陸PC、PS4 與 Xbox One 和近期發行的 Switch 版本囉。這次的 DLC 名為「秩序與魔法（Order & Magic）」，帶來新的追隨者、新物品、強而有力的咒語、改善與Switch上的好友邀請功能。',
'2019-11-20','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\10.jpg', Single_Blob)as gamepic
go

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '4','【GC 19】《世紀帝國 2：決定版》宣布將於 11 月 14 日正式推出',
'微軟於今日在 Gamescom 展前所展開的「Inside Xbox - Live @ gamescom 2019」活動上，正式宣布《世紀帝國 2：決定版》將於 11 月 14 日推出的消息。《世紀帝國 2：決定版》為經典即時策略遊戲《世紀帝國 2》的強化版。除了有 4K 超高畫質、以及全新重製音軌等內容外，也增加了 4 個全新文明以及 3 個新章節。隨著這次 gamescom 的展開，官方也宣布遊戲將於 11 月正式上市。',
'2019-11-14','2020-05-08',
BulkColumn from Openrowset( Bulk N'E:\04.jpg', Single_Blob)as gamepic

INSERT INTO Event(productId,eventName,content,startDate,endDate, EventImage)
select '1','《黑暗靈魂 Remastered》將於 5 月 11 日至 5 月 12 日舉行公開測試',
'台灣萬代南夢宮娛樂今（2）日宣布，FROMSOFTWARE Inc .開發，預定於 2018 年 5 月 24 日正式發售的動作角色扮演遊戲《黑暗靈魂 Remastered》PlayStation 4／Xbox One 版將會舉行網路伺服器功能公開測試，藉由本次大規模的網路壓力測試以驗證連線系統機能，提升正式發售時的連線遊玩品質。',
'2018-05-11','2018-05-24',
BulkColumn from Openrowset( Bulk N'E:\01.jpg', Single_Blob)as gamepic




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