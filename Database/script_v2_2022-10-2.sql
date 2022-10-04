USE [master]
GO
/****** Object:  Database [BakeryRecipe]    Script Date: 10/2/2022 11:37:58 PM ******/
CREATE DATABASE [BakeryRecipe]

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
/****** Object:  Table [dbo].[Comment]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [nvarchar](500) NOT NULL,
	[Rate] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[Follow]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[Ingredient]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[IngredientRecipe]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientRecipe](
	[IngredientID] [int] NOT NULL,
	[RecipeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IngredientID] ASC,
	[RecipeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instruction]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[Picture]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[img] [varchar](100) NOT NULL,
	[RecipeID] [int] NOT NULL,
 CONSTRAINT [PK_PostImg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[ProductOrder]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[Recipe]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Like] [int] NOT NULL,
	[Dislike] [int] NOT NULL,
	[DatePost] [datetime] NOT NULL,
	[LastDateEdit] [datetime] NULL,
	[PrepTime] [int] NULL,
	[CookTime] [int] NULL,
	[Saved] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK__Posts__AA1260380751D4EE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportComment]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[ReportRecipe]    Script Date: 10/2/2022 11:37:58 PM ******/
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
 CONSTRAINT [PK_ReportPosts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[RecipeID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Save]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[Store]    Script Date: 10/2/2022 11:37:58 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](50) NULL,
	[Avatar] [varchar](100) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](10) NULL,
	[Phone] [varchar](15) NULL,
	[Address] [nvarchar](100) NULL,
	[DateRegister] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK__Users__1788CCAC6665F995] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Video]    Script Date: 10/2/2022 11:37:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[link] [varchar](100) NOT NULL,
	[RecipeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Ingredient] ON 

INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (1, N'egg', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (2, N'flour', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (3, N'butter', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (4, N'sugar', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (5, N'salt', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (6, N'milk', NULL)
INSERT [dbo].[Ingredient] ([ID], [Name], [Img]) VALUES (7, N'baking soda', NULL)
SET IDENTITY_INSERT [dbo].[Ingredient] OFF
GO
INSERT [dbo].[IngredientRecipe] ([IngredientID], [RecipeID]) VALUES (1, 2)
INSERT [dbo].[IngredientRecipe] ([IngredientID], [RecipeID]) VALUES (2, 2)
INSERT [dbo].[IngredientRecipe] ([IngredientID], [RecipeID]) VALUES (3, 2)
INSERT [dbo].[IngredientRecipe] ([IngredientID], [RecipeID]) VALUES (4, 2)
GO
SET IDENTITY_INSERT [dbo].[Instruction] ON 

INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (2, 1, N'step 1: do this', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (3, 2, N'step 2: do that', NULL, 2)
INSERT [dbo].[Instruction] ([ID], [InsStep], [Detail], [Img], [RecipeID]) VALUES (4, 3, N'step 3: do there', NULL, 2)
SET IDENTITY_INSERT [dbo].[Instruction] OFF
GO
SET IDENTITY_INSERT [dbo].[Picture] ON 

INSERT [dbo].[Picture] ([ID], [img], [RecipeID]) VALUES (2, N'https://cdn.tgdd.vn/2022/03/CookRecipe/Avatar/banh-donut-bang-chao-chong-dinh-thumbnail.jpg
', 2)
SET IDENTITY_INSERT [dbo].[Picture] OFF
GO
SET IDENTITY_INSERT [dbo].[Recipe] ON 

INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (2, N'donut', N'donut', 2, 0, CAST(N'2022-01-01T00:00:00.000' AS DateTime), NULL, 60, 60, 6, 0, 3)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (4, N'pizza', N'pizza', 5, 0, CAST(N'2022-01-02T00:00:00.000' AS DateTime), NULL, 10, 15, 3, 0, 4)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (5, N'cake', N'cake', 9, 5, CAST(N'2022-01-03T00:00:00.000' AS DateTime), NULL, 20, 40, 1, 0, 3)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (6, N'cake', N'cake', 3, 3, CAST(N'2022-01-04T00:00:00.000' AS DateTime), NULL, 10, 15, 4, 0, 3)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (7, N'pizza', N'pizza', 4, 3, CAST(N'2022-02-05T00:00:00.000' AS DateTime), NULL, 5, 10, 3, 0, 5)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (8, N'bread', N'bread', 4, 5, CAST(N'2022-04-02T00:00:00.000' AS DateTime), NULL, 5, 10, 2, 0, 3)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (9, N'cookie', N'cookie', 4, 5, CAST(N'2022-05-06T00:00:00.000' AS DateTime), NULL, 10, 10, 20, 0, 4)
INSERT [dbo].[Recipe] ([ID], [Name], [Description], [Like], [Dislike], [DatePost], [LastDateEdit], [PrepTime], [CookTime], [Saved], [IsDeleted], [UserID]) VALUES (10, N'cookie', N'cookie', 5, 3, CAST(N'2022-04-21T00:00:00.000' AS DateTime), NULL, 10, 10, 2, 0, 3)
SET IDENTITY_INSERT [dbo].[Recipe] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Role], [Email], [Password], [Avatar], [FirstName], [LastName], [Gender], [Phone], [Address], [DateRegister], [IsActive], [StoreID]) VALUES (3, N'admin', N'admin0@gmail.com', N'1234567890', N'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-gau-cute.jpg', N'phu', N'huynh', N'male', N'0398550944', NULL, CAST(N'2022-01-01' AS Date), 1, NULL)
INSERT [dbo].[User] ([ID], [Role], [Email], [Password], [Avatar], [FirstName], [LastName], [Gender], [Phone], [Address], [DateRegister], [IsActive], [StoreID]) VALUES (4, N'baker', N'user0@gmail.com', N'123456789', N'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-gau-cute.jpg', N'man', N'vo', N'female', N'033333333', NULL, CAST(N'2022-01-01' AS Date), 1, NULL)
INSERT [dbo].[User] ([ID], [Role], [Email], [Password], [Avatar], [FirstName], [LastName], [Gender], [Phone], [Address], [DateRegister], [IsActive], [StoreID]) VALUES (5, N'baker', N'user1@gmail.com', N'123456', N'https://khoinguonsangtao.vn/wp-content/uploads/2022/07/avatar-gau-cute.jpg', N'hello', N'sdfds', NULL, NULL, NULL, CAST(N'2022-02-02' AS Date), 1, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534B9A735C3]    Script Date: 10/2/2022 11:37:58 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UQ__Users__A9D10534B9A735C3] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FKComment537260] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FKComment537260]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FKComment816296] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FKComment816296]
GO
ALTER TABLE [dbo].[Follow]  WITH CHECK ADD  CONSTRAINT [FKFollow361093] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Follow] CHECK CONSTRAINT [FKFollow361093]
GO
ALTER TABLE [dbo].[Follow]  WITH CHECK ADD  CONSTRAINT [FKFollow945429] FOREIGN KEY([UserID2])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Follow] CHECK CONSTRAINT [FKFollow945429]
GO
ALTER TABLE [dbo].[IngredientRecipe]  WITH CHECK ADD  CONSTRAINT [FKIngredient453484] FOREIGN KEY([IngredientID])
REFERENCES [dbo].[Ingredient] ([ID])
GO
ALTER TABLE [dbo].[IngredientRecipe] CHECK CONSTRAINT [FKIngredient453484]
GO
ALTER TABLE [dbo].[IngredientRecipe]  WITH CHECK ADD  CONSTRAINT [FKIngredient611333] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[IngredientRecipe] CHECK CONSTRAINT [FKIngredient611333]
GO
ALTER TABLE [dbo].[Instruction]  WITH CHECK ADD  CONSTRAINT [FK_Instruction_Recipe] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[Instruction] CHECK CONSTRAINT [FK_Instruction_Recipe]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FKOrder63439] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FKOrder63439]
GO
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FKPicture325360] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FKPicture325360]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FKProduct215436] FOREIGN KEY([IngredientID])
REFERENCES [dbo].[Ingredient] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FKProduct215436]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FKProduct783174] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FKProduct783174]
GO
ALTER TABLE [dbo].[ProductOrder]  WITH CHECK ADD  CONSTRAINT [FKProductOrd41715] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[ProductOrder] CHECK CONSTRAINT [FKProductOrd41715]
GO
ALTER TABLE [dbo].[ProductOrder]  WITH CHECK ADD  CONSTRAINT [FKProductOrd608164] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[ProductOrder] CHECK CONSTRAINT [FKProductOrd608164]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FKRecipe405040] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FKRecipe405040]
GO
ALTER TABLE [dbo].[ReportComment]  WITH CHECK ADD  CONSTRAINT [FKReportComm316353] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[ReportComment] CHECK CONSTRAINT [FKReportComm316353]
GO
ALTER TABLE [dbo].[ReportComment]  WITH CHECK ADD  CONSTRAINT [FKReportComm762006] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([ID])
GO
ALTER TABLE [dbo].[ReportComment] CHECK CONSTRAINT [FKReportComm762006]
GO
ALTER TABLE [dbo].[ReportRecipe]  WITH CHECK ADD  CONSTRAINT [FKReportReci461494] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[ReportRecipe] CHECK CONSTRAINT [FKReportReci461494]
GO
ALTER TABLE [dbo].[ReportRecipe]  WITH CHECK ADD  CONSTRAINT [FKReportReci740530] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[ReportRecipe] CHECK CONSTRAINT [FKReportReci740530]
GO
ALTER TABLE [dbo].[Save]  WITH CHECK ADD  CONSTRAINT [FKSave303065] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[Save] CHECK CONSTRAINT [FKSave303065]
GO
ALTER TABLE [dbo].[Save]  WITH CHECK ADD  CONSTRAINT [FKSave947561] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Save] CHECK CONSTRAINT [FKSave947561]
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD  CONSTRAINT [FKStore298808] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FKStore298808]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FKVideo383719] FOREIGN KEY([RecipeID])
REFERENCES [dbo].[Recipe] ([ID])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FKVideo383719]
GO
USE [master]
GO
ALTER DATABASE [BakeryRecipe] SET  READ_WRITE 
GO
