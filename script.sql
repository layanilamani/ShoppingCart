USE [master]
GO
/****** Object:  Database [ShoppingCart]    Script Date: 3/13/2020 5:02:03 PM ******/
CREATE DATABASE [ShoppingCart]
GO
USE [ShoppingCart]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[ParentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryBrands]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryBrands](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[BrandId] [int] NULL,
 CONSTRAINT [PK_CategoryBrands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[Amount] [float] NULL,
	[OrderId] [int] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL,
	[CustomerId] [int] NULL,
	[OrderStatus] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[ImageName] [varchar](50) NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Price] [float] NULL,
	[CategoryId] [int] NULL,
	[Details] [varchar](max) NULL,
	[BrandId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[UserTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Brands] ON 

INSERT [dbo].[Brands] ([Id], [Name]) VALUES (1, N'nike')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (2, N'under amrour')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (3, N'adidas')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (4, N'puma')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (5, N'asics')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (6, N'fendi')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (7, N'guess')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (8, N'valentino')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (9, N'dior')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (10, N'versace')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (11, N'armani')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (12, N'prada')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (13, N'dolce and gabbana')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (14, N'chanel')
INSERT [dbo].[Brands] ([Id], [Name]) VALUES (15, N'gucci')
SET IDENTITY_INSERT [dbo].[Brands] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (1, N'Sportswear', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (2, N'mens', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (3, N'womens', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (4, N'kids', 2)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (5, N'fashion', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (6, N'household', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (7, N'interiors', NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (9, N'clothing', 2)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (10, N'bags', 2)
INSERT [dbo].[Categories] ([Id], [Name], [ParentId]) VALUES (1009, N'shoes', NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[CategoryBrands] ON 

INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (1, 1, 1)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (2, 1, 2)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (3, 1, 3)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (4, 1, 4)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (5, 1, 5)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (6, 2, 6)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (18, 3, 6)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (7, 2, 7)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (19, 3, 7)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (8, 2, 8)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (20, 3, 8)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (9, 2, 9)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (21, 3, 9)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (10, 2, 10)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (22, 3, 10)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (11, 2, 11)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (12, 2, 12)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (13, 2, 13)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (14, 2, 14)
INSERT [dbo].[CategoryBrands] ([Id], [CategoryId], [BrandId]) VALUES (15, 2, 15)
SET IDENTITY_INSERT [dbo].[CategoryBrands] OFF
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageName]) VALUES (1, 2, N'Giordano-Men-Socks-3.jpg')
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageName]) VALUES (2, 3, N'560 (2).jpg')
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageName]) VALUES (3, 4, N'560.jpg')
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [CategoryId], [Details], [BrandId]) VALUES (2, N'tipu', 25, 2, N'testing.......', 2)
INSERT [dbo].[Products] ([Id], [Name], [Price], [CategoryId], [Details], [BrandId]) VALUES (3, N'moza1', 12, 5, N'kala moza', 6)
INSERT [dbo].[Products] ([Id], [Name], [Price], [CategoryId], [Details], [BrandId]) VALUES (4, N'black t shirt', 25, 6, N'kali t shirt', 4)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [Email], [Password], [UserTypeId]) VALUES (1, N'ali', N'ali@gmail.com', N'123', 2)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Password], [UserTypeId]) VALUES (2, N'bilal', N'bilal@gmail.com', N'123', 2)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Password], [UserTypeId]) VALUES (3, N'admin', N'admin@aptech.com', N'123', 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Password], [UserTypeId]) VALUES (1003, N'tipu', N'tipu@gmail.com', N'123', 2)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[UserTypes] ([Id], [Name]) VALUES (2, N'Buyer')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
/****** Object:  Index [IX_CategoryBrands]    Script Date: 3/13/2020 5:02:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CategoryBrands] ON [dbo].[CategoryBrands]
(
	[BrandId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories]
GO
ALTER TABLE [dbo].[CategoryBrands]  WITH CHECK ADD  CONSTRAINT [FK_CategoryBrands_Brands] FOREIGN KEY([BrandId])
REFERENCES [dbo].[Brands] ([Id])
GO
ALTER TABLE [dbo].[CategoryBrands] CHECK CONSTRAINT [FK_CategoryBrands_Brands]
GO
ALTER TABLE [dbo].[CategoryBrands]  WITH CHECK ADD  CONSTRAINT [FK_CategoryBrands_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[CategoryBrands] CHECK CONSTRAINT [FK_CategoryBrands_Categories]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Brands] FOREIGN KEY([BrandId])
REFERENCES [dbo].[Brands] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Brands]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserTypes] FOREIGN KEY([UserTypeId])
REFERENCES [dbo].[UserTypes] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserTypes]
GO
/****** Object:  StoredProcedure [dbo].[LoginUser]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[LoginUser]
@Email varchar(50),
@Password varchar(50)
As
Begin
	--select count(*) from users where email = @Email and Password = @Password
	
	select top 1 * from Users where Email = @Email and Password = @Password	
End

GO
/****** Object:  StoredProcedure [dbo].[Signup]    Script Date: 3/13/2020 5:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Signup]
@Email varchar(50),
@Password varchar(50),
@Name varchar(50)
As
Begin	 
	insert into Users (Name, Email, Password) values(@Name, @Email, @Password)

	select @@IDENTITY
End

GO
