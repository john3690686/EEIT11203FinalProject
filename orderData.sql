USE [gameshop]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK__Orders__userId__4222D4EF]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__produ__45F365D3]
GO
ALTER TABLE [dbo].[OrderDetail] DROP CONSTRAINT [FK__OrderDeta__order__44FF419A]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__buyDatet__412EB0B6]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2020/5/6 下午 03:48:55 ******/
DROP TABLE [dbo].[Orders]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2020/5/6 下午 03:48:55 ******/
DROP TABLE [dbo].[OrderDetail]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 2020/5/6 下午 03:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[detailId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[productId] [int] NULL,
	[price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[detailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2020/5/6 下午 03:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[orderId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
	[buyDatetime] [datetime] NULL,
	[purchase] [int] NOT NULL,
	[hash] [varchar](20) NULL,
	[payResult] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (1, 1, 1, 1000)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (2, 1, 2, 800)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (3, 1, 17, 238)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (4, 2, 12, 1799)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (5, 2, 16, 378)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (6, 2, 7, 318)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (7, 2, 21, 1790)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (8, 2, 4, 600)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (9, 2, 11, 468)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (10, 2, 13, 1790)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (11, 2, 5, 1800)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (12, 3, 5, 1800)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (13, 3, 3, 1790)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (14, 3, 18, 378)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (15, 3, 20, 698)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (16, 3, 1, 1000)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (17, 3, 16, 378)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (18, 4, 2, 800)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (19, 4, 3, 1790)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (20, 4, 22, 858)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (21, 4, 9, 868)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (22, 4, 20, 698)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (23, 5, 18, 378)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (24, 5, 22, 858)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (25, 5, 20, 698)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (26, 5, 6, 1033)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (27, 6, 3, 1790)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (28, 6, 11, 468)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (29, 6, 15, 690)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (30, 6, 22, 858)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (31, 6, 7, 318)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (32, 6, 9, 868)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (33, 6, 14, 468)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (34, 7, 16, 378)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (35, 7, 1, 1000)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (36, 7, 5, 1800)
INSERT [dbo].[OrderDetail] ([detailId], [orderId], [productId], [price]) VALUES (37, 7, 9, 868)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (1, 1, CAST(N'2020-05-06T14:44:27.537' AS DateTime), 2038, N'1b3f6130b32844b7b00d', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (2, 1, CAST(N'2020-05-06T14:45:35.087' AS DateTime), 8943, N'1bcfd97ebbfd450980c7', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (3, 1, CAST(N'2020-05-06T14:48:14.207' AS DateTime), 6044, N'0b602c9d0a7f4edcade3', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (4, 2, CAST(N'2020-05-06T14:56:43.267' AS DateTime), 5014, N'0c985b7f0b8e41b2914b', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (5, 2, CAST(N'2020-05-06T14:57:14.460' AS DateTime), 2967, N'388925b3ba7345b4b00b', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (6, 3, CAST(N'2020-05-06T15:00:51.223' AS DateTime), 5460, N'5f99010e74544308b31c', N'P')
INSERT [dbo].[Orders] ([orderId], [userId], [buyDatetime], [purchase], [hash], [payResult]) VALUES (7, 3, CAST(N'2020-05-06T15:02:01.437' AS DateTime), 4046, N'd8d6980f51484d419da1', N'P')
SET IDENTITY_INSERT [dbo].[Orders] OFF
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [buyDatetime]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[Orders] ([orderId])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([productId])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[Profile] ([userId])
GO
