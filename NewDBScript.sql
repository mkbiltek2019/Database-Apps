USE [master]
GO
/****** Object:  Database [SagittaDB]    Script Date: 19/03/2015 10:25:47 PM ******/
CREATE DATABASE [SagittaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SagittaDB', FILENAME = N'G:\SotUni\DataBases\Performance\SagittaDB.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SagittaDB_log', FILENAME = N'G:\SotUni\DataBases\Performance\SagittaDB_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SagittaDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SagittaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SagittaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SagittaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SagittaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SagittaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SagittaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SagittaDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SagittaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SagittaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SagittaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SagittaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SagittaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SagittaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SagittaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SagittaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SagittaDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SagittaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SagittaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SagittaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SagittaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SagittaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SagittaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SagittaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SagittaDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SagittaDB] SET  MULTI_USER 
GO
ALTER DATABASE [SagittaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SagittaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SagittaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SagittaDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SagittaDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SagittaDB]
GO
/****** Object:  Table [dbo].[ExpensesByMonth]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpensesByMonth](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseMonth] [date] NULL,
	[VendorId] [int] NULL,
	[Expenses] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Measures]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Measures](
	[ID] [int] IDENTITY(100,100) NOT NULL,
	[Measure Name] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NOT NULL,
	[Product Name] [nvarchar](max) NOT NULL,
	[MeasureID] [int] NOT NULL,
	[Price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalesReports]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[SupermarketId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualPrice] [money] NOT NULL,
	[ReportDate] [date] NOT NULL,
 CONSTRAINT [PK_SalesReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supermarkets]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supermarkets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Supermarkets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendors]    Script Date: 19/03/2015 10:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Vendor Name] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Measures] ON 

INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (100, N'g')
INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (200, N'kg')
INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (300, N'ml')
INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (400, N'l')
INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (500, N'package')
INSERT [dbo].[Measures] ([ID], [Measure Name]) VALUES (600, N'bottle')
SET IDENTITY_INSERT [dbo].[Measures] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (1, 1, N'Beer “Zagorka”', 600, 2.5600)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (2, 8, N'Coffee "3v1"', 500, 0.3400)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (3, 2, N'Chocolate "Milka"', 100, 1.8900)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (4, 5, N'Chips "Chippi"', 100, 2.3800)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (5, 6, N'Coca-Cola', 400, 2.2500)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (6, 10, N'Peanuts', 100, 1.2600)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (7, 9, N'Rakia', 300, 8.6900)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (12, 1, N'Beer "Beck’s"', 100, 1.0300)
INSERT [dbo].[Products] ([ID], [VendorID], [Product Name], [MeasureID], [Price]) VALUES (14, 9, N'Vodka "Targovishte"', 100, 7.5600)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[SalesReports] ON 

INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (1, 3, 4, 5, 2.8500, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (3, 2, 4, 3, 7.8000, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (5, 3, 1, 75, 1.0500, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (7, 1, 1, 146, 0.8800, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (9, 14, 1, 67, 7.7000, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (10, 3, 2, 9, 2.9000, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (14, 12, 2, 43, 1.2000, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (15, 1, 2, 78, 0.9200, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (16, 1, 3, 11, 1.0000, CAST(N'2014-06-21' AS Date))
INSERT [dbo].[SalesReports] ([Id], [ProductId], [SupermarketId], [Quantity], [ActualPrice], [ReportDate]) VALUES (17, 14, 3, 20, 8.5000, CAST(N'2014-06-21' AS Date))
SET IDENTITY_INSERT [dbo].[SalesReports] OFF
SET IDENTITY_INSERT [dbo].[Supermarkets] ON 

INSERT [dbo].[Supermarkets] ([Id], [Name]) VALUES (1, N'Plovdiv-Stolipinovo')
INSERT [dbo].[Supermarkets] ([Id], [Name]) VALUES (2, N'Kaspichan-Center')
INSERT [dbo].[Supermarkets] ([Id], [Name]) VALUES (3, N'Bourgas-Plaza')
INSERT [dbo].[Supermarkets] ([Id], [Name]) VALUES (4, N'Zmeyovo-Bai Ivan')
SET IDENTITY_INSERT [dbo].[Supermarkets] OFF
SET IDENTITY_INSERT [dbo].[Vendors] ON 

INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (1, N'Zagorka')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (2, N'Nestle')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (3, N'Lindt')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (4, N'Bulgartabak')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (5, N'Chipi')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (6, N'Coca Cola')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (7, N'Bankia')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (8, N'NesCafe')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (9, N'Vinprom Karnobat')
INSERT [dbo].[Vendors] ([ID], [Vendor Name]) VALUES (10, N'Detelina')
SET IDENTITY_INSERT [dbo].[Vendors] OFF
ALTER TABLE [dbo].[ExpensesByMonth]  WITH CHECK ADD  CONSTRAINT [FK_VendorId] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendors] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ExpensesByMonth] CHECK CONSTRAINT [FK_VendorId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Product_Measure] FOREIGN KEY([MeasureID])
REFERENCES [dbo].[Measures] ([ID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Product_Measure]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Product_Vendor] FOREIGN KEY([VendorID])
REFERENCES [dbo].[Vendors] ([ID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Product_Vendor]
GO
ALTER TABLE [dbo].[SalesReports]  WITH CHECK ADD  CONSTRAINT [FK_SalesReports_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[SalesReports] CHECK CONSTRAINT [FK_SalesReports_Products]
GO
ALTER TABLE [dbo].[SalesReports]  WITH CHECK ADD  CONSTRAINT [FK_SalesReports_Supermarkets] FOREIGN KEY([SupermarketId])
REFERENCES [dbo].[Supermarkets] ([Id])
GO
ALTER TABLE [dbo].[SalesReports] CHECK CONSTRAINT [FK_SalesReports_Supermarkets]
GO
USE [master]
GO
ALTER DATABASE [SagittaDB] SET  READ_WRITE 
GO
