Yuzuha Branch Update Log
---
2020/04/22
更新項目:
1. 加入ECPay 綠界付款功能 (tw.gamehop.controller.ECPayController, 一拖拉庫的ECPay packages，以及library/build path: log4j JAR)
2. 增加 SQL 資料表 Orders table 欄位 payResult varchar(1) 來記錄付款狀態, P: pending, Y: OK, N: failed
3. 修改 tw.gamehop.controller.ShoppingCart，更改按下付款後的路徑到 ECPayController
4. 修改 tw.gamehop.model.Orders，增加SQL資料表對應的 payResult 項目
5. 修改 tw.gamehop.model.Orders，增加搭配 ECPay 所需撈資料的功能
6. 增加 tw.gamehop.model.OrdersService
7. 修改 tw.gamehop.model.p_ProfileDAO & tw.gamehop.model.p_ProfileService，新增用 UserID 撈 Email 的功能
8. 更新 4/20 已完成但未上傳的 Chatroom 排版修正、使用規範說明等
9. (4/20)更新 Chatroom client 會把 ip 放進訊息並丟給 WebSocket Server 的功能
10. (4/20)增加 WebSocket 透過 JDBC 把所有對話紀錄通通塞進 SQL 的功能(預設不啟用)
11. (4/20)增加 Chatroom SSL WSS 協定支援。
12. 於 pom.xml 加入新的 maven repository
13. Chatroom logging 用的 SQL table 指令
已知 BUG:
手機 Chrome Mobile 無法使用 WebSocket 功能，故無法使用 Chatroom (Chrome限制，Android Firefox Preview可以使用 Chatroom)
---
需修改設定
1. tw.gamehop.controller.ECPayController，需自行加入寄 Email 用的 SMTP server 帳號密碼伺服器位置等認證資料 (line: 152~152)
2. tw.gamehop.controller.ChatRoomWebSocket，如要使用 logging，需自行加入 SQL 的帳號密碼 (line: 25, 26)
3. SQL GameShop.dbo.Orders 資料表需加入 payStatus 欄位 (SQL CMD::  ALTER TABLE GameShop.dbo.Orders ADD payStatus VARCHAR(1)    )


=========================================================================================================



JAVA檔案:ThirdTeamProject


1.開啟Eclipse
先自己建立Tomcat，
    並修改context.xml如下:
	<Context>
	<Resource
	  url="jdbc:sqlserver://localhost:1433;databaseName=GameShop"
	  driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
	  username="sa"
*要改>>	  password="1qaz2wsx"
	  auth="Container"
	  type="javax.sql.DataSource"
	  name="connectSqlServerJdbc/GameShop"/>



	........</Context>
2.
import>>General>>Projects from Folder or Archive>>next
右上Directory選擇 ThirdTeamProject資料夾
選擇 GameShop
finish
==============================================================
網頁如用其他IDE設計可放在根目錄下，搭配TempCSS和TempJS，設計好之後再丟進WebContainer
