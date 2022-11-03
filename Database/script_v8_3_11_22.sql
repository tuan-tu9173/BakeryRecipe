USE [master]
GO
/****** Object:  Database [BakeryRecipe]    Script Date: 3/11/2022 11:24:13 PM ******/
CREATE DATABASE [BakeryRecipe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BakeryRecipe', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BakeryRecipe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BakeryRecipe_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BakeryRecipe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BakeryRecipe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BakeryRecipe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BakeryRecipe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BakeryRecipe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BakeryRecipe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BakeryRecipe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BakeryRecipe] SET ARITHABORT OFF 
GO
ALTER DATABASE [BakeryRecipe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BakeryRecipe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BakeryRecipe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BakeryRecipe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BakeryRecipe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BakeryRecipe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BakeryRecipe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BakeryRecipe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BakeryRecipe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BakeryRecipe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BakeryRecipe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BakeryRecipe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BakeryRecipe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BakeryRecipe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BakeryRecipe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BakeryRecipe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BakeryRecipe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BakeryRecipe] SET RECOVERY FULL 
GO
ALTER DATABASE [BakeryRecipe] SET  MULTI_USER 
GO
ALTER DATABASE [BakeryRecipe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BakeryRecipe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BakeryRecipe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BakeryRecipe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BakeryRecipe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BakeryRecipe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BakeryRecipe', N'ON'
GO
ALTER DATABASE [BakeryRecipe] SET QUERY_STORE = OFF
GO
USE [BakeryRecipe]
GO
/****** Object:  FullTextCatalog [recipe_ctlg]    Script Date: 3/11/2022 11:24:13 PM ******/
CREATE FULLTEXT CATALOG [recipe_ctlg] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [nvarchar](500) NOT NULL,
	[DateComment] [datetime] NOT NULL,
	[LastDateEdit] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
	[RecipeID] [int] NOT NULL,
 CONSTRAINT [PK__Comments__C3B4DFAABAE3DA4F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Follow]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Follow](
	[UserID] [int] NOT NULL,
	[UserID2] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[UserID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Img] [varchar](100) NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientRecipe]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientRecipe](
	[RecipeID] [int] NOT NULL,
	[IngredientID] [int] NOT NULL,
	[Amount] [nvarchar](50) NULL,
 CONSTRAINT [PK__Ingredie__A1732AF709FB3F20] PRIMARY KEY CLUSTERED 
(
	[IngredientID] ASC,
	[RecipeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instruction]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instruction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InsStep] [int] NOT NULL,
	[Detail] [text] NOT NULL,
	[Img] [varchar](100) NULL,
	[RecipeID] [int] NOT NULL,
 CONSTRAINT [PK_Instruction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Like]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like](
	[RecipeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Like] PRIMARY KEY CLUSTERED 
(
	[RecipeID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateOrder] [int] NOT NULL,
	[Total] [int] NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Shipper] [nvarchar](20) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsFullfilled] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK__Orders__C3905BAFF16F0529] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Picture]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Img] [varchar](100) NOT NULL,
	[IsCover] [bit] NOT NULL,
	[RecipeID] [int] NOT NULL,
 CONSTRAINT [PK_PostImg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Price] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Detail] [text] NULL,
	[img] [varchar](100) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IngredientID] [int] NULL,
	[StoreID] [int] NOT NULL,
 CONSTRAINT [PK__Products__B40CC6ED11F92BC5] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductOrder]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductOrder](
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Like] [int] NOT NULL,
	[Save] [int] NOT NULL,
	[Comment] [int] NOT NULL,
	[Video] [varchar](100) NULL,
	[DatePost] [datetime] NOT NULL,
	[LastDateEdit] [datetime] NULL,
	[PrepTime] [int] NULL,
	[CookTime] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK__Posts__AA1260380751D4EE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportComment]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportComment](
	[ID] [int] NOT NULL,
	[DateReport] [datetime] NOT NULL,
	[Detail] [nvarchar](500) NOT NULL,
	[CommentID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_ReportComments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[CommentID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportRecipe]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportRecipe](
	[ID] [int] NOT NULL,
	[DateReport] [datetime] NOT NULL,
	[Detail] [nvarchar](500) NOT NULL,
	[RecipeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ReportType] [nvarchar](500) NULL,
 CONSTRAINT [PK_ReportPosts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[RecipeID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Save]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Save](
	[RecipeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateRegister] [date] NOT NULL,
	[Logo] [varchar](100) NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/11/2022 11:24:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](50) NULL,
	[Avatar] [varchar](300) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [nvarchar](10) NULL,
	[Phone] [varchar](15) NULL,
	[Address] [nvarchar](100) NULL,
	[Follower] [int] NULL,
	[Following] [int] NULL,
	[DateRegister] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[StoreID] [int] NULL,
	[Birthday] [date] NULL,
 CONSTRAINT [PK__Users__1788CCAC6665F995] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (2, N'Very good ! I added some chocolate chips inside of them as well. I also didn''t put them in the fridge for 2 hours as the instructions said I just just made them. :)', CAST(N'2022-07-01T00:00:00.000' AS DateTime), NULL, 0, 11, 9)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (4, N'I can never make them look as pretty as they do in the pictures, but they taste nice 😂
I skipped the refrigeration because I''m impatient so maybe that''s why', CAST(N'2022-07-08T00:00:00.000' AS DateTime), NULL, 0, 13, 9)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (5, N'The dough for this is extremely crumbly I don’t know if it’s supposed to be that way or what. But I followed the recipe and checked over and over to see if I did something wrong but I can’t figure out why. They also never fell I had to flatten them myself.', CAST(N'2022-07-09T00:00:00.000' AS DateTime), NULL, 0, 14, 9)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (6, N'I love peanut butter cookies so this is a permanent go to in my household', CAST(N'2022-07-10T00:00:00.000' AS DateTime), NULL, 0, 15, 9)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (7, N'It is so good', CAST(N'2022-07-07T00:00:00.000' AS DateTime), NULL, 0, 15, 2)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (8, N'It is so good', CAST(N'2022-07-07T00:00:00.000' AS DateTime), NULL, 0, 15, 4)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (9, N'So delicious and easy! Great rich chocolate flavor, and easy to veganize. All family members liked.', CAST(N'2022-07-07T00:00:00.000' AS DateTime), NULL, 1, 15, 5)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (10, N'ahih
', CAST(N'2022-10-30T09:25:24.000' AS DateTime), CAST(N'2022-10-30T09:25:24.000' AS DateTime), 0, 37, 6)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (11, N'ngon vl
', CAST(N'2022-10-30T09:26:08.000' AS DateTime), CAST(N'2022-10-30T09:26:08.000' AS DateTime), 0, 37, 5)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (12, N'seem good, plz make more recipes
', CAST(N'2022-10-31T11:10:49.000' AS DateTime), CAST(N'2022-10-31T11:10:49.000' AS DateTime), 0, 3, 15)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (13, N' dddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđ dddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđ dddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđ dddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđ dddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđdddddddddddddđ
', CAST(N'2022-10-31T11:18:20.000' AS DateTime), CAST(N'2022-10-31T11:18:20.000' AS DateTime), 0, 3, 15)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (14, N'văn bình luận mẫu bằng tiếng việt.
', CAST(N'2022-10-31T11:20:59.000' AS DateTime), CAST(N'2022-10-31T11:20:59.000' AS DateTime), 0, 3, 15)
INSERT [dbo].[Comment] ([ID], [Comment], [DateComment], [LastDateEdit], [IsDeleted], [UserID], [RecipeID]) VALUES (15, N'この料理はおいしですよ。
', CAST(N'2022-10-31T11:21:41.000' AS DateTime), CAST(N'2022-10-31T11:21:41.000' AS DateTime), 0, 3, 15)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
INSERT [dbo].[Follow] ([UserID], [UserID2]) VALUES (3, 4)
INSERT [dbo].[Follow] ([UserID], [UserID2]) VALUES (3, 5)
INSERT [dbo].[Follow] ([UserID], [UserID2]) VALUES (3, 11)
INSERT [dbo].[Follow] ([UserID], [UserID2]) VALUES (15, 3)
INSERT [dbo].[Follow] ([UserID], [UserID2]) VALUES (38, 3)
GO
SET IDENTITY_INSERT [dbo].[Ingredient] ON 

INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (1, N'egg', N'egg.png')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (2, N'flour', N'flour.png')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (3, N'butter', N'butter.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (4, N'sugar', N'salt.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (5, N'salt', N'sugar.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (6, N'milk', N'milk.png')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (7, N'baking soda', N'bakingsoda.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (8, N'all-purpose flour', N'all-purposeflour.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (9, N'baking powder', N'bakingpowder.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (10, N'unsalted butter', N'unsaltedbutter.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (11, N'granulated sugar', N'granulatedsugar.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (12, N'buttermilk', N'buttermilk.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (13, N'vanilla extract', N'vanillaextract.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (14, N'semi-sweet chocolate chips', N'semi-sweet.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (15, N'almond flour', N'almondflour.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (16, N'unsweetened almond milk', N'unsweetenedalmondmilk.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (17, N'lemon', N'lemon.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (18, N'banana', N'banana.png')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (19, N'chilli pepper', N'chilli_pepper.png')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (20, N'golden caster sugar', N'Goldencastersugar.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (21, N'self raising flour', N'Selfraisingflour.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (22, N'ground almond', N'Groundalmond.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (23, N'ground cinnamon', N'groundcinnamon.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (24, N'nutmeg', N'nutmeg.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (25, N'apple cider', N'applecider.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (30, N'smooth peanut butter', N'e82a41a72062df5fe568461b87b52372.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (31, N'Brown sugar', N'cbf086e8c3e5542c06e094f36cea1378.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (32, N'all-purpose bleached', N'f9fbc23db97a0b2cbd8e99dff7f851f1.jpg')
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (33, N'Cinnamon', NULL)
SET IDENTITY_INSERT [dbo].[Ingredient] OFF
GO
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 1, N'3')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 1, N'3')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 1, N'2')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 1, N'1')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (17, 1, N'1 oz')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 2, N'2')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 2, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 3, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 3, N'175g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 5, N'2.5g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 5, N'1/2 tsp')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 5, N'1 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 5, N'1/2 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 7, N'5g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 7, N'1/2 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 8, N'315g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 8, N'2 and 1/2 cups')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 9, N'13g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 9, N'1 and 1/2 tsp')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 9, N'2 teaspoons')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 10, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 10, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 11, N'1 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 11, N'1 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 11, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 12, N'1 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 13, N'15ml')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 13, N'1 tsp')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 13, N'3 drops')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 13, N'teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (2, 14, N'275g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 15, N'2 and 1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 16, N'1/3 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (4, 17, N'1/2')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 17, N'1')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 20, N'175g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 21, N'200g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (5, 22, N'50g')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 22, N'1 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 23, N'1 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 24, N'1/2 teaspoon')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (6, 25, N'3/4 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 30, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (9, 31, N'1/2 cup')
INSERT [dbo].[IngredientRecipe] ([RecipeID], [IngredientID], [Amount]) VALUES (17, 33, N'1 pound')
GO
SET IDENTITY_INSERT [dbo].[Instruction] ON 

INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (2, 1, N'Preheat oven to 425°F. Spray a 12 cup muffin tray with non-stick cooking spray or line with paper liners.', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (3, 2, N'In a large bowl, toss together the flour, baking powder, baking soda, salt and chocolate chips. Set aside.', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (4, 3, N'In a medium bowl, whisk together the melted butter, sugar, eggs, milk and vanilla. Slowly add to the dry ingredients. Gently fold together until JUST combined.', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (5, 4, N'Divide the batter into the 12 muffin cups and bake at 425°F for 5 minutes. Then reduce the oven temperature to 375°F and continue to bake for another 12-15 minutes or until a toothpick inserted into the center comes out clean. Do not overbake or the muffins will be dry. Let cool for about 5-10 minutes and enjoy warm.', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (6, 1, N'Preheat oven to 350° and line a 12-cup muffin pan with cupcake liners.', NULL, 4)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (7, 2, N'In a large bowl, whisk to combine almond flour, Swerve, baking powder, baking soda, and salt. Whisk in melted butter, almond milk, eggs, and vanilla until just combined.', NULL, 4)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (9, 3, N'Gently fold blueberries and lemon zest (if using) until evenly distributed. Scoop equal amounts of batter into each cupcake liner and bake until slightly golden and a toothpick inserted into the center of a muffin comes out clean, 23 minutes. Let cool slightly before serving.', NULL, 4)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (10, 1, N'In a large mixing bowl, cream softened butter and peanut butter together with a hand mixer. Mix for 30 seconds. Add both sugars and beat for 3 minutes until light and fluffy. Add egg and vanilla and mix just until combined.', NULL, 9)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (11, 2, N'In a medium mixing bowl, whisk together flour, salt and baking soda. Add to butter and sugar mixture in 3 additions, mixing just until combined. If desired, you can add chocolate chips or chopped nuts to the cookie dough. Cover the bowl with dough and place in the fridge for at least 2 hours.', NULL, 9)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (14, 3, N'Preheat oven to 350 degrees F. Scoop 1.5 tablespoon size balls of dough, roll in your hands in balls and roll in sugar. Place on baking sheet, about 2" apart, and bake for 8 to 9 minutes. Cool on sheet for 3 to 5 minutes, then remove onto a cooling rack.', NULL, 9)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (15, 1, N'Buoc 1', N'instruction_1_16.jpg', 16)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (16, 2, N'Buoc 2\', N'instruction_2_16.jpg', 16)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (17, 1, N'Throw egg and some cinnamon in', N'instruction_1_17.png', 17)
SET IDENTITY_INSERT [dbo].[Instruction] OFF
GO
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (2, 13)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (4, 4)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (6, 38)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (8, 5)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (9, 3)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (10, 38)
INSERT [dbo].[Like] ([RecipeID], [UserID]) VALUES (15, 3)
GO
SET IDENTITY_INSERT [dbo].[Picture] ON 

INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (2, N'22.jpg', 0, 2)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (3, N'21.jpg', 1, 2)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (4, N'51.jpg', 1, 5)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (5, N'41.jpg', 1, 4)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (6, N'61.jpg', 1, 6)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (8, N'71.jpg', 1, 7)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (9, N'81.jpg', 1, 8)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (10, N'91.jpg', 1, 9)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (11, N'101.jpg', 1, 10)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (12, N'bbgbw3fwezgpzx6hjlzk.jpg', 1, 15)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (13, N'474b9866d66f07462cc5236d2f8d1e69.jpg', 1, 13)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (14, N'chocolate-chip-muffins-3.jpg', 0, 2)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (15, N'The-Best-Keto-Low-Carb-Blueberry-Muffins.jpg', 0, 4)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (16, N'keto-blueberry-muffins-1-of-1.jpg', 0, 4)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (17, N'Madeira loaf cake', 0, 5)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (18, N'madeira-cake-97509-1.jpeg', 0, 5)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (19, N'picture_0_16.jpg', 1, 16)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (20, N'picture_1_16.jpg', 0, 16)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (21, N'picture_0_17.jpg', 0, 17)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (22, N'picture_1_17.jpg', 0, 17)
INSERT [dbo].[Picture] ([ID], [Img], [IsCover], [RecipeID]) VALUES (23, N'picture_2_17.jpg', 1, 17)
SET IDENTITY_INSERT [dbo].[Picture] OFF
GO
