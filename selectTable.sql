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

insert into Event(productId,eventName,content,startDate,endDate) values(7,'EventTest','discount','20071207','20071207')
go
insert into Event(productId,eventName,content,startDate,endDate) values(2,'EventTest2','discount2','20200424','20200429')