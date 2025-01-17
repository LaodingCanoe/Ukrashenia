USE [master]
GO
/****** Object:  Database [SharipovTrade]    Script Date: 11.11.2024 9:26:21 ******/
CREATE DATABASE [SharipovTrade]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SharipovTrade', FILENAME = N'W:\Program file\MSSQL16.MSSQLSERVER\MSSQL\DATA\SharipovTrade.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SharipovTrade_log', FILENAME = N'W:\Program file\MSSQL16.MSSQLSERVER\MSSQL\DATA\SharipovTrade_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SharipovTrade].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SharipovTrade] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SharipovTrade] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SharipovTrade] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SharipovTrade] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SharipovTrade] SET ARITHABORT OFF 
GO
ALTER DATABASE [SharipovTrade] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SharipovTrade] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SharipovTrade] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SharipovTrade] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SharipovTrade] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SharipovTrade] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SharipovTrade] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SharipovTrade] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SharipovTrade] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SharipovTrade] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SharipovTrade] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SharipovTrade] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SharipovTrade] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SharipovTrade] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SharipovTrade] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SharipovTrade] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SharipovTrade] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SharipovTrade] SET RECOVERY FULL 
GO
ALTER DATABASE [SharipovTrade] SET  MULTI_USER 
GO
ALTER DATABASE [SharipovTrade] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SharipovTrade] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SharipovTrade] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SharipovTrade] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SharipovTrade] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SharipovTrade', N'ON'
GO
USE [SharipovTrade]
GO
/****** Object:  User [egor]    Script Date: 11.11.2024 9:26:21 ******/
CREATE USER [egor] FOR LOGIN [egor] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [egor]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] NOT NULL,
	[OrderStatus] [nvarchar](max) NOT NULL,
	[OrderDeliveryDate] [date] NOT NULL,
	[OrderPickupPoint] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[ClientID] [int] NULL,
	[OrderCode] [int] NOT NULL,
 CONSTRAINT [PK__Order__C3905BAF12A4B4CF] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderID] [int] NOT NULL,
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK__OrderPro__817A2662FF07FFCE] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PickUpPoint]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickUpPoint](
	[PickUpID] [int] NOT NULL,
	[PickUpIndex] [nvarchar](10) NOT NULL,
	[PickUpCity] [nvarchar](50) NOT NULL,
	[PickUpStreet] [nvarchar](50) NOT NULL,
	[PickUpHouse] [int] NULL,
 CONSTRAINT [PK_PickUpPoint] PRIMARY KEY CLUSTERED 
(
	[PickUpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](100) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductDescription] [nvarchar](max) NULL,
	[ProductCategory] [nvarchar](max) NOT NULL,
	[ProductManufacturer] [nvarchar](max) NOT NULL,
	[ProductCost] [decimal](19, 4) NOT NULL,
	[ProductDiscountAmount] [int] NOT NULL,
	[ProductQuantityInStock] [int] NOT NULL,
	[ProductPostav] [nvarchar](max) NOT NULL,
	[ProductUnit] [nvarchar](10) NOT NULL,
	[ProductPhoto] [nvarchar](50) NULL,
	[ProductMaxDiscount] [int] NOT NULL,
 CONSTRAINT [PK__Product__2EA7DCD512ED5571] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__Role__8AFACE3A4E60934D] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11.11.2024 9:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] NOT NULL,
	[UserSurname] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPatronymic] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](max) NOT NULL,
	[UserPassword] [nvarchar](max) NOT NULL,
	[UserRole] [int] NOT NULL,
 CONSTRAINT [PK__User__1788CCACB2450AC9] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (1, N'Новый ', CAST(N'2022-05-07' AS Date), 2, CAST(N'2022-05-01' AS Date), 51, 111)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (2, N'Новый ', CAST(N'2022-05-08' AS Date), 8, CAST(N'2022-05-02' AS Date), NULL, 112)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (3, N'Новый ', CAST(N'2022-05-09' AS Date), 10, CAST(N'2022-05-03' AS Date), NULL, 113)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (4, N'Завершен', CAST(N'2022-05-10' AS Date), 12, CAST(N'2022-05-04' AS Date), NULL, 114)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (5, N'Новый ', CAST(N'2022-05-11' AS Date), 15, CAST(N'2022-05-05' AS Date), NULL, 115)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (6, N'Новый ', CAST(N'2022-05-12' AS Date), 18, CAST(N'2022-05-06' AS Date), 52, 116)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (7, N'Завершен', CAST(N'2022-05-13' AS Date), 20, CAST(N'2022-05-07' AS Date), NULL, 117)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (8, N'Новый ', CAST(N'2022-05-14' AS Date), 25, CAST(N'2022-05-08' AS Date), NULL, 118)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (9, N'Завершен', CAST(N'2022-05-15' AS Date), 30, CAST(N'2022-05-09' AS Date), NULL, 119)
INSERT [dbo].[Order] ([OrderID], [OrderStatus], [OrderDeliveryDate], [OrderPickupPoint], [OrderDate], [ClientID], [OrderCode]) VALUES (10, N'Новый ', CAST(N'2022-05-16' AS Date), 36, CAST(N'2022-05-10' AS Date), 53, 120)
GO
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (1, N'F933T5', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (1, N'K478R4', 10)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (2, N'D034T5', 6)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (2, N'S563T4', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (3, N'D826T5', 11)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (3, N'K083T5', 11)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (4, N'B037T5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (4, N'D832R2', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (5, N'D044T5', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (5, N'R922T5', 7)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (6, N'F933T5', 5)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (6, N'V783T5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (7, N'H937R3', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (7, N'S039T5', 3)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (8, N'F903T5', 4)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (8, N'F937R4', 3)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (9, N'D826T5', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (9, N'R836R5', 1)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (10, N'D044T5', 2)
INSERT [dbo].[OrderProduct] ([OrderID], [ProductArticleNumber], [Quantity]) VALUES (10, N'D832R2', 5)
GO
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (1, N'344288', N' г. Ковров', N' ул. Чехова', 1)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (2, N'614164', N' г.Ковров', N'  ул. Степная', 30)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (3, N'394242', N' г. Ковров', N' ул. Коммунистическая', 43)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (4, N'660540', N' г. Ковров', N' ул. Солнечная', 25)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (5, N'125837', N' г. Ковров', N' ул. Шоссейная', 40)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (6, N'125703', N' г. Ковров', N' ул. Партизанская', 49)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (7, N'625283', N' г. Ковров', N' ул. Победы', 46)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (8, N'614611', N' г. Ковров', N' ул. Молодежная', 50)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (9, N'454311', N' г.Ковров', N' ул. Новая', 19)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (10, N'660007', N' г.Ковров', N' ул. Октябрьская', 19)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (11, N'603036', N' г. Ковров', N' ул. Садовая', 4)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (12, N'450983', N' г.Ковров', N' ул. Комсомольская', 26)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (13, N'394782', N' г. Ковров', N' ул. Чехова', 3)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (14, N'603002', N' г. Ковров', N' ул. Дзержинского', 28)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (15, N'450558', N' г. Ковров', N' ул. Набережная', 30)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (16, N'394060', N' г.Ковров', N' ул. Фрунзе', 43)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (17, N'410661', N' г. Ковров', N' ул. Школьная', 50)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (18, N'625590', N' г. Ковров', N' ул. Коммунистическая', 20)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (19, N'625683', N' г. Ковров', N' ул. 8 Марта', NULL)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (20, N'400562', N' г. Ковров', N' ул. Зеленая', 32)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (21, N'614510', N' г. Ковров', N' ул. Маяковского', 47)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (22, N'410542', N' г. Ковров', N' ул. Светлая', 46)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (23, N'620839', N' г. Ковров', N' ул. Цветочная', 8)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (24, N'443890', N' г. Ковров', N' ул. Коммунистическая', 1)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (25, N'603379', N' г. Ковров', N' ул. Спортивная', 46)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (26, N'603721', N' г. Ковров', N' ул. Гоголя', 41)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (27, N'410172', N' г. Ковров', N' ул. Северная', 13)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (28, N'420151', N' г. Ковров', N' ул. Вишневая', 32)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (29, N'125061', N' г. Ковров', N' ул. Подгорная', 8)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (30, N'630370', N' г. Ковров', N' ул. Шоссейная', 24)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (31, N'614753', N' г. Ковров', N' ул. Полевая', 35)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (32, N'426030', N' г. Ковров', N' ул. Маяковского', 44)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (33, N'450375', N' г. Ковров ', N'ул. Клубная', 44)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (34, N'625560', N' г. Ковров', N' ул. Некрасова', 12)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (35, N'630201', N' г. Ковров', N' ул. Комсомольская', 17)
INSERT [dbo].[PickUpPoint] ([PickUpID], [PickUpIndex], [PickUpCity], [PickUpStreet], [PickUpHouse]) VALUES (36, N'190949', N' г. Ковров', N' ул. Мичурина', 26)
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'B025Y5', N'Блюдо', N'Блюдо декоративное flower 35 см Home Philosophy', N'Интерьерные аксессуары', N'Home Philosophy', CAST(1890.0000 AS Decimal(19, 4)), 3, 8, N'Стокманн', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'B037T5', N'Блюдо', N'Блюдо декоративное Flower 35 см', N'Интерьерные аксессуары', N'Home Philosophy', CAST(690.0000 AS Decimal(19, 4)), 2, 14, N'Стокманн', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'D034T5', N'Диффузор', N'Диффузор Mikado intense Апельсин с корицей', N'Ароматы для дома', N'Miksdo', CAST(800.0000 AS Decimal(19, 4)), 2, 15, N'Hoff', N'шт.', N'Resources/photo/D034T5.jpg', 20)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'D044T5', N'Декор настенный', N'Декор настенный Фантазия 45х45х1 см', N'Интерьерные аксессуары', N'Home Philosophy', CAST(1790.0000 AS Decimal(19, 4)), 3, 7, N'Стокманн', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'D826T5', N'Диффузор', N'Диффузор True Scents 45 мл манго', N'Ароматы для дома', N'True Scents', CAST(600.0000 AS Decimal(19, 4)), 2, 13, N'Hoff', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'D832R2', N'Растение', N'Декоративное растение 102 см', N'Интерьерные аксессуары', N'Home Philosophy', CAST(1000.0000 AS Decimal(19, 4)), 3, 15, N'Стокманн', N'шт.', NULL, 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'D947R5', N'Диффузор', N'Диффузор Aroma Harmony Lavender', N'Ароматы для дома', N'Aroma', CAST(500.0000 AS Decimal(19, 4)), 4, 6, N'Hoff', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'F837T5', N'Фоторамка', N'Шкатулка для украшений из дерева Stowit', N'Картины и фоторамки', N'Gallery', CAST(999.0000 AS Decimal(19, 4)), 2, 15, N'Hoff', N'шт.', NULL, 5)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'F903T5', N'Фоторамка', N'Фоторамка Gallery 20х30 см', N'Картины и фоторамки', N'Gallery', CAST(600.0000 AS Decimal(19, 4)), 2, 3, N'Hoff', N'шт.', NULL, 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'F928T5', N'Фоторамка', N'Фоторамка Prisma 10х10 см', N'Картины и фоторамки', N'Umbra', CAST(1590.0000 AS Decimal(19, 4)), 2, 13, N'Стокманн', N'шт.', NULL, 25)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'F933T5', N'Кашпо', N'Настольное кашпо с автополивом Cube Color', N'Горшки и подставки', N'Cube Color', CAST(1400.0000 AS Decimal(19, 4)), 4, 23, N'Hoff', N'шт.', N'Resources/photo/F933T5.jpg', 20)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'F937R4', N'Фоторамка', N'Фоторамка 10х15 см Gallery серый с патиной/золотой', N'Картины и фоторамки', N'Gallery', CAST(359.0000 AS Decimal(19, 4)), 4, 17, N'Hoff', N'шт.', NULL, 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'H023R8', N'Часы', N'Часы настенные Ribbon 30,5 см', N'Часы', N'Umbra', CAST(5600.0000 AS Decimal(19, 4)), 20, 6, N'Стокманн', N'шт.', N'Resources/photo/H023R8.jpg', 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'H937R3', N'Часы', N'Часы настенные 6500 30,2 см', N'Часы', N'Umbra', CAST(999.0000 AS Decimal(19, 4)), 3, 4, N'Hoff', N'шт.', N'Resources/photo/H937R3.jpg', 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'K083T5', N'Аромат', N'Сменный аромат Figue noire 250 мл', N'Ароматы для дома', N'Esteban', CAST(2790.0000 AS Decimal(19, 4)), 2, 6, N'Стокманн', N'шт.', NULL, 20)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'K478R4', N'Аромат', N'Аромат для декобукета Esteban', N'Ароматы для дома', N'Esteban', CAST(3500.0000 AS Decimal(19, 4)), 4, 4, N'Стокманн', N'шт.', N'Resources/photo/K478R4.jpg', 30)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'K937T4', N'Аромат', N'Деко-букет Кедр 250 мл', N'Ароматы для дома', N'Esteban', CAST(7900.0000 AS Decimal(19, 4)), 2, 17, N'Стокманн', N'шт.', NULL, 25)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'P846R4', N'Подставка', N'Подставка для цветочных горшков 55x25x35 см Valley', N'Горшки и подставки', N'Valley', CAST(1400.0000 AS Decimal(19, 4)), 3, 12, N'Стокманн', N'шт.', NULL, 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'P927R2', N'Подставка', N'Подставка для цветочных горшков Valley', N'Горшки и подставки', N'Valley', CAST(4000.0000 AS Decimal(19, 4)), 2, 4, N'Стокманн', N'шт.', N'Resources/photo/P927R2.jpg', 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'P936E4', N'Подставка', N'Подставка для газет и журналов Zina', N'Горшки и подставки', N'Umbra', CAST(3590.0000 AS Decimal(19, 4)), 4, 9, N'Стокманн', N'шт.', N'Resources/photo/P936E4.jpg', 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'R836R5', N'Шкатулка', N'Шкатулка для украшений из дерева Stowit', N'Шкатулки и подставки', N'Umbra', CAST(8000.0000 AS Decimal(19, 4)), 5, 3, N'Стокманн', N'шт.', NULL, 30)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'R922T5', N'Шкатулка', N'Шкатулка из керамики Lana 6х7 см', N'Шкатулки и подставки', N'Home Philosophy', CAST(690.0000 AS Decimal(19, 4)), 2, 4, N'Стокманн', N'шт.', NULL, 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'S039T5', N'Свеча', N'Свеча True Moods Feel happy', N'Свечи', N'True Scents', CAST(250.0000 AS Decimal(19, 4)), 2, 18, N'Hoff', N'шт.', NULL, 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'S563T4', N'Свеча', N'Свеча в стакане True Scents', N'Свечи', N'True Scents', CAST(1000.0000 AS Decimal(19, 4)), 3, 12, N'Hoff', N'шт.', N'Resources/photo/S563T4.jpg', 20)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'S936Y5', N'Свеча', N'Свеча в стакане True Scents', N'Ароматы для дома', N'True Scents', CAST(299.0000 AS Decimal(19, 4)), 3, 4, N'Hoff', N'шт.', NULL, 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'S937T5', N'Подсвечник', N'Подсвечник 37 см', N'Ароматы для дома', N'Kersten', CAST(2600.0000 AS Decimal(19, 4)), 3, 23, N'Стокманн', N'шт.', NULL, 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'V432R6', N'Ваза', N'Ваза из фаянса 28,00 x 9,50 x 9,50 см', N'Вазы', N'Kersten', CAST(1990.0000 AS Decimal(19, 4)), 3, 30, N'Стокманн', N'шт.', NULL, 10)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'V483R7', N'Ваза', N'Ваза «Весна» 18 см стекло, цвет прозрачный', N'Вазы', N'Весна', CAST(100.0000 AS Decimal(19, 4)), 3, 7, N'Hoff', N'шт.', N'Resources/photo/V483R7.jpg', 15)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'V783T5', N'Ваза', N'Ваза из керамики Betty', N'Вазы', N'Home Philosophy', CAST(1300.0000 AS Decimal(19, 4)), 2, 13, N'Стокманн', N'шт.', N'Resources/photo/V783T5.jpg', 25)
INSERT [dbo].[Product] ([ProductArticleNumber], [ProductName], [ProductDescription], [ProductCategory], [ProductManufacturer], [ProductCost], [ProductDiscountAmount], [ProductQuantityInStock], [ProductPostav], [ProductUnit], [ProductPhoto], [ProductMaxDiscount]) VALUES (N'V937E4', N'Ваза', N'Ваза 18H2535S 30,5 см', N'Вазы', N'Kersten', CAST(1999.0000 AS Decimal(19, 4)), 3, 21, N'Hoff', N'шт.', NULL, 15)
GO
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Клиент')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Менеджер')
GO
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Алексеев ', N'Владислав', N'Аркадьевич', N'loginDEbct2018', N'Qg3gff', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Савельева ', N'Евфросиния', N'Арсеньевна', N'loginDEvtg2018', N'ETMNzL', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Никонов ', N'Мэлс', N'Лукьевич', N'loginDEuro2018', N'a1MIcO', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (4, N'Горшкова ', N'Агафья', N'Онисимовна', N'loginDEpst2018', N'0CyGnX', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (5, N'Горбачёв ', N'Пантелеймон', N'Германович', N'loginDEpsu2018', N'Vx9cQ{', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (6, N'Ершова ', N'Иванна', N'Максимовна', N'loginDEzqs2018', N'qM9p7i', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (7, N'Туров ', N'Денис', N'Геласьевич', N'loginDEioe2018', N'yMPu&2', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (8, N'Носова ', N'Наина', N'Эдуардовна', N'loginDEcmk2018', N'3f+b0+', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (9, N'Куликов ', N'Андрей', N'Святославович', N'loginDEfsp2018', N'&dtlI+', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (10, N'Нестеров ', N'Агафон', N'Георгьевич', N'loginDExcd2018', N'SZXZNL', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (11, N'Козлов ', N'Геласий', N'Христофорович', N'loginDEvlf2018', N'O5mXc2', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (12, N'Борисова ', N'Анжелика', N'Анатольевна', N'loginDEanv2018', N'Xiq}M3', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (13, N'Суханов ', N'Станислав', N'Фролович', N'loginDEzde2018', N'tlO3x&', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (14, N'Тетерина ', N'Феврония', N'Эдуардовна', N'loginDEriv2018', N'GJ2mHL', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (15, N'Муравьёва ', N'Александра', N'Ростиславовна', N'loginDEhcp2018', N'n2nfRl', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (16, N'Новикова ', N'Лукия', N'Ярославовна', N'loginDEwjv2018', N'ZfseKA', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (17, N'Агафонова ', N'Лариса', N'Михаиловна', N'loginDEiry2018', N'5zu7+}', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (18, N'Сергеева ', N'Агата', N'Юрьевна', N'loginDEgbr2018', N'}+Ex1*', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (19, N'Колобова ', N'Елена', N'Евгеньевна', N'loginDExxv2018', N'+daE|T', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (20, N'Ситников ', N'Николай', N'Филатович', N'loginDEbto2018', N'b1iYMI', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (21, N'Белов ', N'Роман', N'Иринеевич', N'loginDEfbs2018', N'v90Rep', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (22, N'Волкова ', N'Алла', N'Лукьевна', N'loginDEple2018', N'WlW+l8', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (23, N'Кудрявцева ', N'Таисия', N'Игоревна', N'loginDEhhx2018', N'hmCHeQ', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (24, N'Семёнова ', N'Октябрина', N'Христофоровна', N'loginDEayn2018', N'Ka2Fok', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (25, N'Смирнов ', N'Сергей', N'Яковович', N'loginDEwld2018', N'y9HStF', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (26, N'Брагина ', N'Алина', N'Валерьевна', N'loginDEhuu2018', N'X31OEf', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (27, N'Евсеев ', N'Игорь', N'Донатович', N'loginDEmjb2018', N'5mm{ch', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (28, N'Суворов ', N'Илья', N'Евсеевич', N'loginDEdgp2018', N'1WfJjo', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (29, N'Котов ', N'Денис', N'Мартынович', N'loginDEgyi2018', N'|7nYPc', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (30, N'Бобылёва ', N'Юлия', N'Егоровна', N'loginDEmvn2018', N'Mrr9e0', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (31, N'Брагин ', N'Бронислав', N'Георгьевич', N'loginDEfoj2018', N'nhGc+D', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (32, N'Александров ', N'Владимир', N'Дамирович', N'loginDEuuo2018', N'42XmH1', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (33, N'Фокин ', N'Ириней', N'Ростиславович', N'loginDEhsj2018', N's+jrMW', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (34, N'Воронов ', N'Митрофан', N'Антонович', N'loginDEvht2018', N'zMyS8Z', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (35, N'Маслов ', N'Мстислав', N'Антонинович', N'loginDEeqo2018', N'l5CBqA', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (36, N'Щербаков ', N'Георгий', N'Богданович', N'loginDExrf2018', N'mhpRIT', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (37, N'Кириллова ', N'Эмилия', N'Федосеевна', N'loginDEfku2018', N'a1m+8c', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (38, N'Васильев ', N'Серапион', N'Макарович', N'loginDExix2018', N'hzxtnn', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (39, N'Галкина ', N'Олимпиада', N'Владленовна', N'loginDEqrf2018', N'mI8n58', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (40, N'Яковлева ', N'Ксения', N'Онисимовна', N'loginDEhlk2018', N'g0jSed', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (41, N'Калашникова ', N'Александра', N'Владимировна', N'loginDEwoe2018', N'yOtw2F', 1)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (42, N'Медведьева ', N'Таисия', N'Тихоновна', N'loginDExyu2018', N'7Fg}9p', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (43, N'Карпова ', N'Ольга', N'Лукьевна', N'loginDEcor2018', N'2cIrC8', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (44, N'Герасимов ', N'Мстислав', N'Дамирович', N'loginDEqon2018', N'YeFbh6', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (45, N'Тимофеева ', N'Ксения', N'Валерьевна', N'loginDEyfd2018', N'8aKdb0', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (46, N'Горбунов ', N'Вячеслав', N'Станиславович', N'loginDEtto2018', N'qXYDuu', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (47, N'Кошелева ', N'Кира', N'Владиславовна', N'loginDEdal2018', N'cJWXL0', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (48, N'Панфилова ', N'Марина', N'Борисовна', N'loginDEbjs2018', N'Xap2ct', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (49, N'Кудрявцев ', N'Матвей', N'Игоревич', N'loginDEdof2018', N'kD|LRU', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (50, N'Зуев ', N'Эдуард', N'Пантелеймонович', N'loginDEsnh2018', N'111', 3)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (51, N'Архипова', N'Оливия ', N'Дмитриевна', N'123', N'123', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (52, N'Никонова', N'Татьяна', N'Захаровна', N'456', N'456', 2)
INSERT [dbo].[User] ([UserID], [UserSurname], [UserName], [UserPatronymic], [UserLogin], [UserPassword], [UserRole]) VALUES (53, N'Рябова', N'Диана', N'Павловна', N'789', N'789', 2)
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ProductPhoto]  DEFAULT (NULL) FOR [ProductPhoto]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickUpPoint] FOREIGN KEY([OrderPickupPoint])
REFERENCES [dbo].[PickUpPoint] ([PickUpID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickUpPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([ClientID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Order__2D27B809] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Order__2D27B809]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Produ__2E1BDC42] FOREIGN KEY([ProductArticleNumber])
REFERENCES [dbo].[Product] ([ProductArticleNumber])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Produ__2E1BDC42]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK__User__UserRole__267ABA7A] FOREIGN KEY([UserRole])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK__User__UserRole__267ABA7A]
GO
USE [master]
GO
ALTER DATABASE [SharipovTrade] SET  READ_WRITE 
GO
