===================================================================================================
About Branch Update:
---------------------------------------------------------------------------------------------------
Apr. 9
1. Add chatroom function
2. Add json to maven repository

http://serverName:port/GameShop/DEBUG.jsp to set up/destroy session (simulating logged in users)
http://serverName:port/GameShop/Chatroom to join chatroom

---------------------------------------------------------------------------------------------------
===================================================================================================

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
