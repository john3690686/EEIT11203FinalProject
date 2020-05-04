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

--========Article Data===================================================================

INSERT INTO Article(userId, articleTitle, articleAbstract, articleContent, articleThumbnail, postDatetime)
values('4', '夏季遊戲節 SGF','　　受到疫情影響，今年眾多國際遊戲重要展覽包括 GDC、E3、Gamescom 都受到影響改為線上或','<p>　　受到疫情影響，今年眾多國際遊戲重要展覽包括 GDC、E3、Gamescom 都受到影響改為線上或直接取消，而舉辦「The Game Awards（遊戲大獎，TGA）」主辦人 Geoff Keighley 近日宣布，將自 5 月至 8 月舉辦全新遊戲慶典「夏季遊戲節（暫譯，Summer Game Fest，簡稱 SGF）」且已有包括 SIE、微軟、EA、Bethesda、Blizzard、Square Enix、CD Projekt Red、Riot 等知名遊戲大廠將共襄盛舉。</p>    <p><img alt="" src="https://p2.bahamut.com.tw/B/2KU/86/201a033265160a0f8dbf010eb918gj25.JPG?w=1000" style="height:282px; width:500px" /></p>    <p>　　「夏季遊戲節」將會是以線上數位形式呈現，將透過包括 Facebook、Twitch、Twitter、Youtube、Mixer 等管道進行直播，屆時配合夏季遊戲節的相關宣布，像是 Xbox、Steam 等平台還將配合限期釋出新遊戲的試玩版等。</p>    <p><iframe frameborder="0" height="300" scrolling="no" src="https://www.youtube.com/embed/igp5BHoYZYE" width="500"></iframe></p>    <p>　　目前已知 Steam 的遊戲節夏季版將於 6 月 9 日至 14 日登場，將聚焦於接下來一年內發行的遊戲，透過限時開放的試玩版等讓玩家來體驗。</p>    <p>　　Geoff Keighley 表示，「在這個充滿不確定與挑戰的年代，讓遊戲作為我們之間的虛擬與共同聯繫點比以往任何時候都來得重要。」夏季遊戲節希望讓粉絲在家中也能擁有一整季的遊戲新聞與其他更多的驚喜。</p>  ',
'https://i.imgur.com/HTfeVcS.jpg','2020-05-04 14:37:54.000')

INSERT INTO Article(userId, articleTitle, articleAbstract, articleContent, articleThumbnail, postDatetime)
values('4','《Apex 英雄》賽季 5「時來運轉」','　　Respawn Entertainment 宣布，射擊遊戲《Apex 英雄》預定於 5 月 12','<p>　　Respawn Entertainment 宣布，射擊遊戲《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=Apex+%E8%8B%B1%E9%9B%84" target="_blank">Apex 英雄</a>》預定於 5 月 12 日展開賽季 5「時來運轉」，並搶先釋出新英雄「蘿芭」故事影片。</p>    <p><img alt="" src="https://p2.bahamut.com.tw/B/2KU/73/d11b74af1ce6adb21effbbea6718glh5.JPG?w=1000" style="height:212px; width:500px" /></p>    <p>　　《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=Apex+%E8%8B%B1%E9%9B%84" target="_blank">Apex 英雄</a>》賽季 5「<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%99%82%E4%BE%86%E9%81%8B%E8%BD%89" target="_blank">時來運轉</a>」預定於 5 月 12 日起登場，玩家將會發現一項新的「任務」遊戲模式，讓玩家在各賽季尋找寶藏以及答案，完成旅程的玩家將得到豐厚獎勵。而隨著賽季 5 開始，積分聯賽系列賽 4 也隨之而來，官方表示玩家會發現該賽季再次一分為二，始於王者峽谷的系列賽，其後在 6 月時將重返世界邊緣。積分聯賽系列賽 4 會繼續著重於獎勵競技型玩家，以回饋他們在《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=Apex+%E8%8B%B1%E9%9B%84" target="_blank">Apex 英雄</a>》所投入的時間。</p>    <p>&nbsp;</p>    <p>　　除此之外，官方同步公開「來自邊疆的故事」系列預告片的全新故事，玩家將深入探索新英雄「蘿芭」的故事。蘿芭是一名狡猾的盜賊，當她發現她的世仇&mdash;&mdash;亡靈&mdash;&mdash;在 Apex 競賽中角逐爭勝，她的人生便踏上復仇之路。痛失雙親和急於揭露競技場內的祕密，催生出蘿芭的使命。</p>    <p><img alt="" src="https://p2.bahamut.com.tw/B/2KU/74/3e0ce13e57944b03af2e7120e418gli5.JPG?w=1000" style="height:212px; width:500px" /></p>    <p><iframe frameborder="0" height="300" scrolling="no" src="https://www.youtube.com/embed/7Go66ItJBCs" width="500"></iframe></p>  ','https://i.imgur.com/GxjHxvT.jpg','2020-05-04 14:40:56.000')

INSERT INTO Article(userId, articleTitle, articleAbstract, articleContent, articleThumbnail, postDatetime)
values('3','在家裡自導自演一場 B 級恐怖片吧','    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs','<p><img alt="" src="https://truth.bahamut.com.tw/s01/202005/94904225dd790582355aae566785783a.JPG?w=1000" style="height:421px; width:500px" /></p>    <p><span style="font-size:medium"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;過去有段時間很喜歡《</span></span><span style="color:#464646">德州電鋸殺人狂</span><span style="color:#464646">》、</span><span style="color:#464646">《</span><span style="color:#464646">十三號星期五</span><span style="color:#464646">》</span><span style="color:#464646">、</span><span style="color:#464646">《</span><span style="color:#464646">恐怖蠟像館</span><span style="color:#464646">》</span><span style="color:#464646">等恐怖片，尤其是一群青少年被追殺的類型，即使這種類型的恐怖片劇情大同小異，還是樂在其中。前幾年推出的電玩遊戲</span><span style="color:#464646">《</span><span style="color:#464646">十三號星期五</span><span style="color:#464646">》</span><span style="color:#464646">，雖然沒有實際遊玩，但也看了不少遊戲實況。可見我對這類題材</span><s><span style="color:#464646">幾乎病態</span></s><span style="color:#464646">的熱愛，而</span><span style="color:#464646">《</span><span style="color:#464646">Final Girl</span><span style="color:#464646">》</span><span style="color:#464646">就是一款結合</span><s><span style="color:#464646">青少年</span></s><span style="color:#464646">美少女、殺人魔、旅遊勝地等各種恐怖片經典要素的桌遊。</span></p>    <p><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/d6b41eb076a4d3df352216f320e84e41.JPG?w=1000" style="height:335px; width:500px" /></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;《</span><span style="color:#464646">Final Girl</span><span style="color:#464646">》</span><span style="color:#464646">是由&nbsp;<a href="https://ref.gamer.com.tw/redir.php?url=https%3A%2F%2Fwww.kickstarter.com%2Fprofile%2Fvanrydergames" style="color:#a8a8a8; text-decoration:underline" target="_blank">A.J. Porfirio</a>&nbsp;推出，在 Kickstarter 短短兩小時就達成集資目標的單人桌遊。玩家扮演一名少女，和朋友或家人一起旅遊，但原本快樂的旅程因為殺人魔的出現而變調，玩家必須努力救出其他夥伴、擊敗殺人魔，才能逃出這場夢魘。</span></span></span></span></p>    <p>&nbsp;</p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;遊戲的特色是電影主題式的劇本，每套劇本包含兩個主角、一個殺人魔與一個場景，玩家可以依照自己的喜好，搭配任意劇本中主角、殺人魔及場景這三個要素來進行遊戲。目前共推出四套劇本：The happy trails horror（恐怖快樂小徑）、The haunting of creech manor（猛鬼莊園）、Carnage at the carnival（血腥馬戲團）、Slaughter in the groves（森林殺人魔）。</span></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/ac8285817a2813e3693b90bd0b243886.PNG?w=1000" style="height:483px; width:500px" /></span></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/95679a6aea415594d4ceba164b66a43e.JPG?w=1000" style="height:441px; width:500px" /></span></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/666e2df486aaf01473d0ae45dbed260e.PNG?w=1000" style="height:454px; width:500px" /></span></span></span></span></span></p>    <p><img alt="" src="https://truth.bahamut.com.tw/s01/202005/6a91ab3f09eaf271f78493949d7453e8.PNG?w=1000" style="height:438px; width:500px" /></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646">遊戲規則</span></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;首先是玩家的回合，玩家打出卡片來移動、休息、攻擊、尋找道具，接著擲骰判定行動結果。道具能夠幫助玩家擊敗殺人魔，拯救足夠的生存者則能夠解開女主角的特殊能力，因此在規劃行動時，如何武裝自己、同時解救生存者是致勝的關鍵。</span></span><span style="color:#464646">接著玩家可以消耗每回合剩餘的時間，購買下一回合使用的卡片。由於行動和購買卡片都會消耗時間，因此妥善的運用時間也是十分重要的。</span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;玩家的回合結束後，輪到殺人魔行動。從 Terror 卡片組成的牌庫中抽卡，卡片將會決定接下來的突發事件或殺人魔的行動。殺人魔的能力會隨著受害者的人數變多而增強，而遊戲只會在女主角或殺人魔一方死亡時才會結束，因此玩家必須和時間賽跑！</span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/e03d8dcf0f3507d96926af24c0d54f01.JPG?w=1000" style="height:302px; width:500px" /></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/e4c4fab96697f9aec093efb7e1c40788.JPG?w=1000" style="height:286px; width:500px" /></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="color:#464646"><img alt="" src="https://truth.bahamut.com.tw/s01/202005/6f7b339a6ab0af7d74f88aa5045b7ea9.PNG?w=1000" style="height:291px; width:500px" /></span></span></span></span></p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;從遊戲的試玩影片看來，整體的遊戲張力、緊湊刺激感還滿不錯的，由卡片隨機決定的突發事件，例如殺人魔破窗而入，或是男朋友離奇失蹤等，這些可以預期卻又突如其來的發展，都會迫使玩家不得不改變計畫。每次遊戲玩家可以任意搭配角色、殺人魔及場景，每個殺人魔又各自擁有 6 種不同的能力，這些要素讓《</span></span><span style="color:#464646">Final Girl</span><span style="color:#464646">》就像真的在看恐怖片一樣，可以預期遊戲可能出現的各種橋段，但每場遊戲又不完全一樣，增加了可玩的遊戲性。</span></span></span></span></p>    <p>&nbsp;</p>    <p><span style="font-size:15px"><span style="color:#a8a8a8"><span style="background-color:#ffffff"><span style="font-size:medium"><span style="color:#464646">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行文至此，似乎可以明白為何</span></span><span style="color:#464646">《</span><span style="color:#464646">Final Girl</span><span style="color:#464646">》</span><span style="color:#464646">可以在兩小時內達成集資目標，具備恐怖片的各種要素，又可以同時擔任恐怖片導演、編劇、演員的角色，讓喜愛恐怖片的玩家難以抵抗。雖然只能單人遊戲，但在武漢肺炎肆虐的現在，卻成為居家隔離消磨時間的好選擇。</span></span></span></span></p>  ','https://i.imgur.com/ceeSwCj.jpg','2020-05-04 14:52:48.000')

INSERT INTO Article(userId, articleTitle, articleAbstract, articleContent, articleThumbnail, postDatetime)
values('3','微軟首度揭露新一代 Xbox Series X','　　Xbox 今（1）日在官方 Twitter 上預告，將於台灣時間 5 月 7 日晚間 11:00','<p>　　Xbox 今（1）日在官方 Twitter 上<a href="https://twitter.com/Xbox/status/1255889762864361472" target="_blank">預告</a>，將於台灣時間 5 月 7 日晚間 11:00 帶來最新一集「Inside Xbox」直播節目，首度揭露預定 2020 年底推出之研發中新一代主機「Xbox Series X」的遊戲實際遊玩展示。</p>    <p>&nbsp;</p>    <ul>   <li>&nbsp;</li>  </ul>    <p><img alt="image" src="https://p2.bahamut.com.tw/B/2KU/31/f5bc0a212351f90595a213dda918ger5.JPG?v=1588309705659" style="height:281px; width:500px" title="" /></p>    <p>&nbsp;</p>    <p>　　Xbox Series X 是微軟預定 2020 年年底推出的下一代 Xbox 主機。配備整合 AMD Ryzen Zen 2&nbsp;CPU 核心與 Radeon RDNA 2 繪圖架構 GPU 核心的整合處理器。提供 8 倍於前代、高達 12TFLOPS 的圖形處理效能。支援硬體加速光影追蹤，最高 8K 解析度 120fps 畫面輸出，內建高速 SSD，並相容 Xbox One 遊戲軟體。</p>    <p>&nbsp;</p>    <p><iframe frameborder="0" height="300" scrolling="no" src="https://www.youtube.com/embed/WM9uEejFrVo" width="500"></iframe></p>    <p>&nbsp;</p>    <p>　　繼 2019 年 12 月在 The Game Awards 頒獎典禮正式公布 Xbox Series X 之後，如今官方終於要首度帶來 Xbox Series X 遊戲的實際遊玩展示，將邀請全球合作開發團隊共同展示最新開發的 Xbox Series X 遊戲。</p>    <p>&nbsp;</p>    <p>　　對 Xbox Series X 感興趣的玩家，不妨密切注意 5 月 7 晚間播出的「Inside Xbox」直播節目。</p>  ','https://i.imgur.com/R3jkyrH.jpg','2020-05-04 14:55:05.000')

INSERT INTO Article(userId, articleTitle, articleAbstract, articleContent, articleThumbnail, postDatetime)
values('3','《最後生還者》表示不歡迎仇恨同性戀之玩家','　《最後生還者》開發工作室 Naughty Dog 副總裁兼創意總監尼爾‧杜克曼（Neil Druc','<p>　《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%9C%80%E5%BE%8C%E7%94%9F%E9%82%84%E8%80%85" target="_blank">最後生還者</a>》開發工作室 Naughty Dog 副總裁兼創意總監尼爾‧杜克曼（Neil Druckmann）今日稍早在個人 Instagram 限時動態引用美國知名搖滾樂手科特‧柯本（Kurt Cobain）的名言：「如果你以任何方式仇恨同性戀、有色人種或女性，請幫我們一個忙：他○的滾開，不要參加我們的演出，也不要購買我們的專輯」。</p>    <p>&nbsp;</p>    <ul>   <li>   <p>尼爾‧杜克曼的限時動態截圖，現已無法觀看</p>   </li>  </ul>    <p><img alt="image" src="https://p2.bahamut.com.tw/B/2KU/88/62d0de34c06ac75df12193c8d218g585.JPG?v=1588232311219" style="height:983px; width:500px" title="尼爾・杜克曼的限時動態截圖，現已無法觀看" /></p>    <p>　　《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%9C%80%E5%BE%8C%E7%94%9F%E9%82%84%E8%80%85+%E4%BA%8C%E9%83%A8%E6%9B%B2" target="_blank">最後生還者 二部曲</a>》是 2013 年 6 月推出後獲得一致好評、累計銷售超過 1700 萬套、並囊括多項年度遊戲大獎的《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%9C%80%E5%BE%8C%E7%94%9F%E9%82%84%E8%80%85" target="_blank">最後生還者</a>》的續篇作品。故事設定在前作結局後 5 年的時空，敘述與歷盡滄桑的喬爾經歷無數生死關頭、如今已長大成人的少女艾莉，為了維護她所堅持的正義並尋求終結，再次踏上一場殘酷的旅程。</p>    <p>&nbsp;</p>    <ul>   <li>   <p>在官方預告片中即有直接指出，本作主角艾莉為女同性戀者</p>   </li>  </ul>    <p><img alt="image" src="https://p2.bahamut.com.tw/B/2KU/98/4ce5022716eb4bfefe0809e8a418g5i5.JPG?v=1588232351924" style="height:281px; width:500px" title="在官方預告片中即有直接指出主角艾莉為女同性戀者" /></p>    <p>　　針對日前部分管道流出了一些跟主要劇情有關的影片片段，甚至是一些細節的劇情流程列表，Naughty Dog 也已透過官方推特發文表示：「我們知道過去幾天對玩家來說是非常難受的，我們也有同感。看到有人對外分享遊戲上市前的開發中內容，真的是相當令人失望。希望各位盡量避免觀看劇透，也拜託各位不要破壞別人的體驗。《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%9C%80%E5%BE%8C%E7%94%9F%E9%82%84%E8%80%85+%E4%BA%8C%E9%83%A8%E6%9B%B2" target="_blank">最後生還者 二部曲</a>》很快就會交到大家手上。無論各位看到什麼、聽到什麼，最終的體驗都是值得的。」</p>    <p>&nbsp;</p>    <ul>   <li>   <p><a href="https://twitter.com/Naughty_Dog/status/1254840504182665219" target="_blank">官方推特連結</a></p>   </li>  </ul>    <p><img alt="image" src="https://p2.bahamut.com.tw/B/2KU/89/8f41d452ab7ed02c0cfe933e5318g595.JPG?v=1588232424921" style="height:281px; width:500px" title="官方推特連結" /></p>    <p>　　《<a href="https://acg.gamer.com.tw/search.php?encode=utf8&amp;kw=%E6%9C%80%E5%BE%8C%E7%94%9F%E9%82%84%E8%80%85+%E4%BA%8C%E9%83%A8%E6%9B%B2" target="_blank">最後生還者 二部曲</a>》雖然因疫情造成的物流問題延後推出，但現已確定將於 6 月 19 日上市。</p>    <p>&nbsp;</p>    <p>※ 根據過去紀錄顯示，有一些惡意帳號會專門到相關的文章中故意爆雷，因此在意的玩家可能需要加倍小心，包含本篇報導底下留言都須留意，也請巴友協助配合。</p>  ','https://i.imgur.com/ICJX2sE.jpg','2020-05-04 14:57:20.000')

go

--===================================================================================

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