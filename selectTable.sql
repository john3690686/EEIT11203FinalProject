use gameshop
go

select * from Profile
go

select * from ProfileDetail
go

select * from Product
go

select * from Orders
go

select * from OrderDetail
go

select * from Wish
go
select * from Wish where userId=3
go
select * from Event
select * from Profile
go

select * from ProfileDetail
go

insert into Event(productId,eventName,content,startDate,endDate) values(3,'EventTest','discount','20071207','20071207')
go
insert into Event(productId,eventName,content,startDate,endDate) values(2,'EventTest2','discount2','20200424','20200429')
insert into Event(productId,eventName,content,startDate,endDate) values(2,'Event3','好禮大放送','20200424','20200429')
insert into Event(productId,eventName,content,startDate,endDate) values(2,'Event4','禮包買三送一','20200426','20200429')
insert into Event(productId,eventName,content,startDate,endDate) values(2,'Event5','buy one get one free','20200426','20200429')

update Event set eventImage=
BulkColumn from Openrowset( Bulk N'C:\DataSource\teamproject\img\sale7.jpg', Single_Blob)as gamepic
where productId=1

update Event set startDate='20200428' where productId=2

