drop table if exists GameShop.dbo.chatRecord
create table GameShop.dbo.chatRecord(
	id int identity(1,1),
	datetime datetime not NULL DEFAULT GETDATE(),
	send nvarchar(50),
	sendIP varchar(20),
	target nvarchar(50),
	message nvarchar(max),
)

select * from GameShop.dbo.chatRecord