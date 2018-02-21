USE [master]
GO
/****** Object:  Database [loteria2]    Script Date: 20/02/2018 09:45:00 p. m. ******/
CREATE DATABASE [loteria2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'loteriaM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\loteriaM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'loteriaM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\loteriaM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [loteria2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [loteria2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [loteria2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [loteria2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [loteria2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [loteria2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [loteria2] SET ARITHABORT OFF 
GO
ALTER DATABASE [loteria2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [loteria2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [loteria2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [loteria2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [loteria2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [loteria2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [loteria2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [loteria2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [loteria2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [loteria2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [loteria2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [loteria2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [loteria2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [loteria2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [loteria2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [loteria2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [loteria2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [loteria2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [loteria2] SET  MULTI_USER 
GO
ALTER DATABASE [loteria2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [loteria2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [loteria2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [loteria2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [loteria2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [loteria2] SET QUERY_STORE = OFF
GO
USE [loteria2]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [loteria2]
GO
/****** Object:  User [p207398]    Script Date: 20/02/2018 09:45:00 p. m. ******/
CREATE USER [p207398] FOR LOGIN [p207398] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p207398]
GO
/****** Object:  Table [dbo].[cartas]    Script Date: 20/02/2018 09:45:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartas](
	[INTCVECARTA] [int] IDENTITY(1,1) NOT NULL,
	[VCHNOMBRE] [nvarchar](45) NOT NULL,
	[RUTAIMAGEN] [nvarchar](45) NULL,
	[VCHTEXTO] [nvarchar](45) NULL,
 CONSTRAINT [PK_cartas_INTCVECARTA] PRIMARY KEY CLUSTERED 
(
	[INTCVECARTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cartascategoria]    Script Date: 20/02/2018 09:45:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartascategoria](
	[INTIDCATEGORIA] [int] NOT NULL,
	[INTCVECARTA] [int] NOT NULL,
 CONSTRAINT [PK_cartascategoria_INTIDCATEGORIA] PRIMARY KEY CLUSTERED 
(
	[INTIDCATEGORIA] ASC,
	[INTCVECARTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 20/02/2018 09:45:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[INTIDCATEGORIA] [int] IDENTITY(1,1) NOT NULL,
	[VCHNOMBRE] [nvarchar](45) NOT NULL,
	[VCHDESCRIPCION] [nvarchar](45) NULL,
 CONSTRAINT [PK_categoria_INTIDCATEGORIA] PRIMARY KEY CLUSTERED 
(
	[INTIDCATEGORIA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoriasdejugador]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoriasdejugador](
	[INTIDCATEGORIA] [int] NOT NULL,
	[INTCVEJUGADOR] [int] NOT NULL,
	[INTIDPESO] [int] NULL,
	[BOOLACTIVO] [smallint] NULL,
 CONSTRAINT [PK_categoriasdejugador_INTIDCATEGORIA] PRIMARY KEY CLUSTERED 
(
	[INTIDCATEGORIA] ASC,
	[INTCVEJUGADOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detallejuego]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detallejuego](
	[INTIDDETALLE] [int] IDENTITY(1,1) NOT NULL,
	[INTCVECARTA] [int] NOT NULL,
	[INTIDJUEGO] [int] NOT NULL,
	[USASONIDO] [smallint] NOT NULL,
	[USAIMAGEN] [smallint] NOT NULL,
	[CORRECTO] [smallint] NOT NULL,
 CONSTRAINT [PK_detallejuego_INTIDDETALLE] PRIMARY KEY CLUSTERED 
(
	[INTIDDETALLE] ASC,
	[INTCVECARTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[historialresultados]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[historialresultados](
	[INTIDJUEGO] [int] IDENTITY(1,1) NOT NULL,
	[INTCVEJUGADOR] [int] NOT NULL,
	[DATEFECHA] [datetime2](0) NOT NULL,
	[INTACIERTOS] [int] NOT NULL,
	[INTERRORES] [int] NOT NULL,
	[INTCALIFICACION] [int] NOT NULL,
	[INTTOTALCARTAS] [int] NOT NULL,
	[BOOLDIFICIL] [smallint] NOT NULL,
	[INTSONIDO] [int] NULL,
 CONSTRAINT [PK_historialresultados_INTIDJUEGO] PRIMARY KEY CLUSTERED 
(
	[INTIDJUEGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jugador]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jugador](
	[INTCVEJUGADOR] [int] IDENTITY(2,1) NOT NULL,
	[INTCVEUSUARIO] [int] NOT NULL,
	[VCHNOMBRE] [nvarchar](45) NOT NULL,
	[GENERO] [nvarchar](1) NULL,
	[GRADO] [int] NULL,
	[FECHANACIMIENTO] [datetime2](0) NOT NULL,
	[FECHAINSCRIPCION] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_jugador_INTCVEJUGADOR] PRIMARY KEY CLUSTERED 
(
	[INTCVEJUGADOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sesioncategorias]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sesioncategorias](
	[INTIDRESULTADOSESION] [int] NOT NULL,
	[INTIDCATEGORIA] [int] NOT NULL,
	[INTCVEJUGADOR] [int] NOT NULL,
 CONSTRAINT [PK_sesioncategorias_INTIDRESULTADOSESION] PRIMARY KEY CLUSTERED 
(
	[INTIDRESULTADOSESION] ASC,
	[INTIDCATEGORIA] ASC,
	[INTCVEJUGADOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[INTCVEUSUARIO] [int] IDENTITY(3,1) NOT NULL,
	[VCHUSUARIO] [nvarchar](45) NOT NULL,
	[VCHPASSWORD] [nvarchar](45) NOT NULL,
	[CHRTIPOUSUARIO] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_usuario_INTCVEUSUARIO] PRIMARY KEY CLUSTERED 
(
	[INTCVEUSUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cartas] ON 

INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (1, N'Gato', N'gato.jpg', N'Un gato bailando')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (2, N'Alien', N'LV-426.jpg', N'Alien vs')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (5, N'Burro', N'burro.jpg', N' Rebuzna y tiene orejas grandes')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (6, N'Vaca', N'vaca.jpg', N'Animal que da leche')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (7, N'Vino', N'vino.png', N'Bebida hecha a base de uva')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (8, N'Vaso', N'vaso.png', N'Recipiente usado para servir agua')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (9, N'Becerro', N'vitello-clipart-19.jpg', N'El hijo de la vaca')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (10, N'Gato', N'gato.jpg', N'Maulla y rasguña')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (11, N'Güero', N'guero.jpg', N'Una persona con cabello amarillo')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (12, N'Guitarra', N'guitarra.png', N' Instrumento musical de cuerdas')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (13, N'Paraguas', N'paraguas.jpg', N'Sinónimo de parasol')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (14, N'Pingüino', N'pinguino.jpg', N'Animal del ártico de color blanco y negro')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (15, N'Jinete', N'jinete.jpg', N'Persona que monta un caballo')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (16, N'Kilo', N'kilo.jpg', N'Deme un kilo de tortillas')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (17, N'Cuento', N'cuento.jpg', N'Libro para niños')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (18, N'Queso', N'queso.jpg', N'Lo que llevan las quesadillas')
INSERT [dbo].[cartas] ([INTCVECARTA], [VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (19, N'Quinto', N'quinto.jpg', N'Va después del cuarto lugar')
SET IDENTITY_INSERT [dbo].[cartas] OFF
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 1)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 11)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 12)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 13)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 14)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (1, 15)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (3, 2)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (5, 5)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (5, 6)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (5, 7)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (5, 8)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (5, 9)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (6, 16)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (6, 17)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (6, 18)
INSERT [dbo].[cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (6, 19)
SET IDENTITY_INSERT [dbo].[categoria] ON 

INSERT [dbo].[categoria] ([INTIDCATEGORIA], [VCHNOMBRE], [VCHDESCRIPCION]) VALUES (1, N'G', N'G en conjunto con Gui, gue, güe/i y como J')
INSERT [dbo].[categoria] ([INTIDCATEGORIA], [VCHNOMBRE], [VCHDESCRIPCION]) VALUES (3, N'ffsd', N'dsfs')
INSERT [dbo].[categoria] ([INTIDCATEGORIA], [VCHNOMBRE], [VCHDESCRIPCION]) VALUES (4, N'cuatro', N'descripcion cuatro')
INSERT [dbo].[categoria] ([INTIDCATEGORIA], [VCHNOMBRE], [VCHDESCRIPCION]) VALUES (5, N'/B/ y /V/', N'Parecidas en deletreo')
INSERT [dbo].[categoria] ([INTIDCATEGORIA], [VCHNOMBRE], [VCHDESCRIPCION]) VALUES (6, N'/K/ con C y Q', N'seguidas de una vocal')
SET IDENTITY_INSERT [dbo].[categoria] OFF
INSERT [dbo].[categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR], [INTIDPESO], [BOOLACTIVO]) VALUES (1, 2, 3, 1)
INSERT [dbo].[categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR], [INTIDPESO], [BOOLACTIVO]) VALUES (4, 13, 2, 1)
INSERT [dbo].[categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR], [INTIDPESO], [BOOLACTIVO]) VALUES (5, 13, 1, 1)
INSERT [dbo].[categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR], [INTIDPESO], [BOOLACTIVO]) VALUES (6, 13, 1, 1)
SET IDENTITY_INSERT [dbo].[detallejuego] ON 

INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (2, 1, 22, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (3, 1, 22, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (4, 1, 22, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (5, 1, 22, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (6, 18, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (7, 18, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (8, 8, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (9, 7, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (10, 9, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (11, 7, 23, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (12, 5, 24, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (13, 9, 24, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (14, 6, 24, 1, 0, 1)
INSERT [dbo].[detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (15, 6, 24, 1, 0, 1)
SET IDENTITY_INSERT [dbo].[detallejuego] OFF
SET IDENTITY_INSERT [dbo].[historialresultados] ON 

INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (6, 2, CAST(N'2018-02-17T02:17:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (11, 2, CAST(N'2018-02-17T02:58:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (12, 2, CAST(N'2018-02-17T02:59:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (13, 2, CAST(N'2018-02-17T03:00:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (14, 2, CAST(N'2018-02-17T03:01:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (15, 2, CAST(N'2018-02-17T03:04:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (16, 2, CAST(N'2018-02-17T03:11:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (17, 2, CAST(N'2018-02-17T03:13:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 5)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (22, 13, CAST(N'2018-02-20T08:59:00.0000000' AS DateTime2), 2, 2, 5, 4, 0, 0)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (23, 13, CAST(N'2018-02-20T09:02:00.0000000' AS DateTime2), 3, 1, 7, 4, 0, 0)
INSERT [dbo].[historialresultados] ([INTIDJUEGO], [INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (24, 13, CAST(N'2018-02-20T09:05:00.0000000' AS DateTime2), 3, 1, 7, 4, 0, 2)
SET IDENTITY_INSERT [dbo].[historialresultados] OFF
SET IDENTITY_INSERT [dbo].[jugador] ON 

INSERT [dbo].[jugador] ([INTCVEJUGADOR], [INTCVEUSUARIO], [VCHNOMBRE], [GENERO], [GRADO], [FECHANACIMIENTO], [FECHAINSCRIPCION]) VALUES (2, 1, N'Juan Camaney', N'M', 2, CAST(N'2010-01-03T00:00:00.0000000' AS DateTime2), CAST(N'2011-01-03T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[jugador] ([INTCVEJUGADOR], [INTCVEUSUARIO], [VCHNOMBRE], [GENERO], [GRADO], [FECHANACIMIENTO], [FECHAINSCRIPCION]) VALUES (13, 5, N'Pedro Perez', N'M', 1, CAST(N'2009-06-09T00:00:00.0000000' AS DateTime2), CAST(N'2018-01-29T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[jugador] OFF
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([INTCVEUSUARIO], [VCHUSUARIO], [VCHPASSWORD], [CHRTIPOUSUARIO]) VALUES (4, N'alexyee', N'test', N'A')
INSERT [dbo].[usuario] ([INTCVEUSUARIO], [VCHUSUARIO], [VCHPASSWORD], [CHRTIPOUSUARIO]) VALUES (5, N'prueba5', N'prueba5', N'J')
INSERT [dbo].[usuario] ([INTCVEUSUARIO], [VCHUSUARIO], [VCHPASSWORD], [CHRTIPOUSUARIO]) VALUES (7, N'JugadorPrueba', N'temp', N'J')
SET IDENTITY_INSERT [dbo].[usuario] OFF
/****** Object:  Index [jugador$INTCVEJUGADOR_UNIQUE]    Script Date: 20/02/2018 09:45:01 p. m. ******/
ALTER TABLE [dbo].[jugador] ADD  CONSTRAINT [jugador$INTCVEJUGADOR_UNIQUE] UNIQUE NONCLUSTERED 
(
	[INTCVEJUGADOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cartas] ADD  DEFAULT (NULL) FOR [RUTAIMAGEN]
GO
ALTER TABLE [dbo].[cartas] ADD  DEFAULT (NULL) FOR [VCHTEXTO]
GO
ALTER TABLE [dbo].[categoria] ADD  DEFAULT (NULL) FOR [VCHDESCRIPCION]
GO
ALTER TABLE [dbo].[categoriasdejugador] ADD  DEFAULT (NULL) FOR [INTIDPESO]
GO
ALTER TABLE [dbo].[categoriasdejugador] ADD  DEFAULT (NULL) FOR [BOOLACTIVO]
GO
ALTER TABLE [dbo].[historialresultados] ADD  DEFAULT (NULL) FOR [INTSONIDO]
GO
ALTER TABLE [dbo].[jugador] ADD  DEFAULT (NULL) FOR [GENERO]
GO
ALTER TABLE [dbo].[jugador] ADD  DEFAULT (NULL) FOR [GRADO]
GO
ALTER TABLE [dbo].[cartascategoria]  WITH CHECK ADD  CONSTRAINT [cartascategoria$fk_CATEGORIA_has_CARTAS_CARTAS1] FOREIGN KEY([INTCVECARTA])
REFERENCES [dbo].[cartas] ([INTCVECARTA])
GO
ALTER TABLE [dbo].[cartascategoria] CHECK CONSTRAINT [cartascategoria$fk_CATEGORIA_has_CARTAS_CARTAS1]
GO
ALTER TABLE [dbo].[cartascategoria]  WITH CHECK ADD  CONSTRAINT [cartascategoria$fk_CATEGORIA_has_CARTAS_CATEGORIA1] FOREIGN KEY([INTIDCATEGORIA])
REFERENCES [dbo].[categoria] ([INTIDCATEGORIA])
GO
ALTER TABLE [dbo].[cartascategoria] CHECK CONSTRAINT [cartascategoria$fk_CATEGORIA_has_CARTAS_CATEGORIA1]
GO
ALTER TABLE [dbo].[categoriasdejugador]  WITH CHECK ADD  CONSTRAINT [categoriasdejugador$fk_CATEGORIA_has_JUGADOR_CATEGORIA1] FOREIGN KEY([INTIDCATEGORIA])
REFERENCES [dbo].[categoria] ([INTIDCATEGORIA])
GO
ALTER TABLE [dbo].[categoriasdejugador] CHECK CONSTRAINT [categoriasdejugador$fk_CATEGORIA_has_JUGADOR_CATEGORIA1]
GO
ALTER TABLE [dbo].[categoriasdejugador]  WITH CHECK ADD  CONSTRAINT [categoriasdejugador$fk_CATEGORIA_has_JUGADOR_JUGADOR1] FOREIGN KEY([INTCVEJUGADOR])
REFERENCES [dbo].[jugador] ([INTCVEJUGADOR])
GO
ALTER TABLE [dbo].[categoriasdejugador] CHECK CONSTRAINT [categoriasdejugador$fk_CATEGORIA_has_JUGADOR_JUGADOR1]
GO
ALTER TABLE [dbo].[detallejuego]  WITH CHECK ADD  CONSTRAINT [detallejuego$fk_DETALLECARTAJUEGO_CARTAS1] FOREIGN KEY([INTCVECARTA])
REFERENCES [dbo].[cartas] ([INTCVECARTA])
GO
ALTER TABLE [dbo].[detallejuego] CHECK CONSTRAINT [detallejuego$fk_DETALLECARTAJUEGO_CARTAS1]
GO
ALTER TABLE [dbo].[detallejuego]  WITH CHECK ADD  CONSTRAINT [detallejuego$fk_DETALLEJUEGO_HISTORIALRESULTADOS1] FOREIGN KEY([INTIDJUEGO])
REFERENCES [dbo].[historialresultados] ([INTIDJUEGO])
GO
ALTER TABLE [dbo].[detallejuego] CHECK CONSTRAINT [detallejuego$fk_DETALLEJUEGO_HISTORIALRESULTADOS1]
GO
ALTER TABLE [dbo].[historialresultados]  WITH CHECK ADD  CONSTRAINT [historialresultados$fk_HISTORIALRESULTADOS_JUGADOR1] FOREIGN KEY([INTCVEJUGADOR])
REFERENCES [dbo].[jugador] ([INTCVEJUGADOR])
GO
ALTER TABLE [dbo].[historialresultados] CHECK CONSTRAINT [historialresultados$fk_HISTORIALRESULTADOS_JUGADOR1]
GO
ALTER TABLE [dbo].[sesioncategorias]  WITH CHECK ADD  CONSTRAINT [sesioncategorias$fk_HISTORIALRESULTADOS_has_CATEGORIASDEJUGADOR_CATEGORIASDEJU1] FOREIGN KEY([INTIDCATEGORIA], [INTCVEJUGADOR])
REFERENCES [dbo].[categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR])
GO
ALTER TABLE [dbo].[sesioncategorias] CHECK CONSTRAINT [sesioncategorias$fk_HISTORIALRESULTADOS_has_CATEGORIASDEJUGADOR_CATEGORIASDEJU1]
GO
ALTER TABLE [dbo].[sesioncategorias]  WITH CHECK ADD  CONSTRAINT [sesioncategorias$fk_HISTORIALRESULTADOS_has_CATEGORIASDEJUGADOR_HISTORIALRESUL1] FOREIGN KEY([INTIDRESULTADOSESION])
REFERENCES [dbo].[historialresultados] ([INTIDJUEGO])
GO
ALTER TABLE [dbo].[sesioncategorias] CHECK CONSTRAINT [sesioncategorias$fk_HISTORIALRESULTADOS_has_CATEGORIASDEJUGADOR_HISTORIALRESUL1]
GO
/****** Object:  StoredProcedure [dbo].[sp_cartas_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartas_delete]  
   @IDCarta int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM cartas
      WHERE cartas.INTCVECARTA = @IDCarta

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartas_insert_or_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartas_insert_or_update]  
   @name nvarchar(45),
   @img_path nvarchar(45),
   @text nvarchar(45),
   @IDCarta int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      IF @IDCarta IS NULL
         INSERT cartas(cartas.VCHNOMBRE, cartas.RUTAIMAGEN, cartas.VCHTEXTO)
            VALUES (@name, @img_path, @text)
      ELSE 
         
       

         UPDATE cartas
            SET 
               VCHNOMBRE = @name, 
               rutaimagen = @img_path, 
               vchtexto = @text
         WHERE cartas.INTCVECARTA = @IDCarta        


         DECLARE
            @db_null_statement int

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartas_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartas_select]  
   @IDCarta int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT cartas.INTCVECARTA, cartas.VCHNOMBRE, cartas.RUTAIMAGEN, cartas.VCHTEXTO
      FROM cartas
      WHERE cartas.INTCVECARTA = @IDCarta

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartas_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartas_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT cartas.INTCVECARTA, cartas.VCHNOMBRE, cartas.RUTAIMAGEN, cartas.VCHTEXTO
      FROM cartas

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartascategoria_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartascategoria_delete]  
   @IDCategory int,
   @IDCarta int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM cartascategoria
      WHERE cartascategoria.INTIDCATEGORIA = @IDCategory AND cartascategoria.INTCVECARTA = @IDCarta

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartascategoria_insert]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartascategoria_insert]  
   @IDCategory int,
   @IDCarta int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      INSERT loteria.cartascategoria(loteria.cartascategoria.INTIDCATEGORIA, loteria.cartascategoria.INTCVECARTA)
         VALUES (@IDCategory, @IDCarta)

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_cartascategoria_select_cartas]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_cartascategoria_select_cartas]  
   @IDCategory int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT cartascategoria.INTCVECARTA, cartas.RUTAIMAGEN, cartas.VCHNOMBRE, cartas.VCHTEXTO
      FROM cartascategoria
	  JOIN cartas
	  ON cartas.INTCVECARTA = cartascategoria.INTCVECARTA
      WHERE cartascategoria.INTIDCATEGORIA = @IDCategory

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoria_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoria_delete]  
   @IDCategoria int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM cartascategoria
      WHERE cartascategoria.INTIDCATEGORIA = @IDCategoria

     
      DELETE 
      FROM categoria
      WHERE categoria.INTIDCATEGORIA = @IDCategoria     



   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoria_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoria_select]  
   @IDCategoria int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

     
      SELECT categoria.INTIDCATEGORIA, categoria.VCHNOMBRE, categoria.VCHDESCRIPCION
      FROM categoria
      WHERE categoria.INTIDCATEGORIA = @IDCategoria      



   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoria_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoria_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT categoria.INTIDCATEGORIA, categoria.VCHNOMBRE, categoria.VCHDESCRIPCION
      FROM categoria

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriasdejugador_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoriasdejugador_delete]  
   @IDCategoria int,
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM categoriasdejugador
      WHERE categoriasdejugador.INTCVEJUGADOR = @IDJugador AND categoriasdejugador.INTIDCATEGORIA = @IDCategoria

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriasdejugador_delete_all_per_jugador]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoriasdejugador_delete_all_per_jugador]  
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM categoriasdejugador
      WHERE categoriasdejugador.INTCVEJUGADOR = @IDJugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriasdejugador_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoriasdejugador_select]  
   @IDCategoria int,
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT categoriasdejugador.INTIDCATEGORIA, categoriasdejugador.INTCVEJUGADOR, categoriasdejugador.INTIDPESO, categoriasdejugador.BOOLACTIVO
      FROM categoriasdejugador
      WHERE categoriasdejugador.INTIDCATEGORIA = @IDCategoria AND categoriasdejugador.INTCVEJUGADOR = @IDJugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriasdejugador_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoriasdejugador_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT categoriasdejugador.INTIDCATEGORIA, categoriasdejugador.INTCVEJUGADOR, categoriasdejugador.INTIDPESO, categoriasdejugador.BOOLACTIVO
      FROM categoriasdejugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_categoriasdejugador_select_all_for_jugador]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_categoriasdejugador_select_all_for_jugador]  
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT categoriasdejugador.INTIDCATEGORIA, categoriasdejugador.INTCVEJUGADOR, categoriasdejugador.INTIDPESO, categoriasdejugador.BOOLACTIVO
      FROM categoriasdejugador
      WHERE categoriasdejugador.INTCVEJUGADOR = @IDJugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_detallejuego_insert_or_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_detallejuego_insert_or_update]  
   @IDCarta int,
   @IDJuego int,
   @usedSound smallint,
   @usedImage smallint,
   @guessedCorrectly smallint,
   @IDDetalle int = NULL
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      IF @IDDetalle IS NULL
         /*
         *   SSMA informational messages:
         *   M2SS0214: The Default Values for the Columns have been added in the Insert Statement based on Project setttings.
         */

         INSERT detallejuego(
            loteria.detallejuego.INTCVECARTA, 
            loteria.detallejuego.INTIDJUEGO, 
            loteria.detallejuego.USASONIDO, 
            loteria.detallejuego.USAIMAGEN, 
            loteria.detallejuego.CORRECTO)
            VALUES (
               @IDCarta, 
               @IDJuego, 
               @usedSound, 
               @usedImage, 
               @guessedCorrectly)
      ELSE 
         UPDATE detallejuego
            SET 
               INTCVECARTA = @IDCarta, 
               INTIDJUEGO = @IDJuego, 
               USASONIDO = @usedImage, 
               CORRECTO = @guessedCorrectly
         WHERE detallejuego.INTIDDETALLE = @IDDetalle

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_detallejuego_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_detallejuego_select]  
   @IDJuego int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

    
      SELECT 
         detallejuego.INTIDDETALLE, 
         detallejuego.INTCVECARTA, 
         intIDjuego, 
         detallejuego.USASONIDO, 
         detallejuego.USAIMAGEN, 
         detallejuego.CORRECTO
      FROM detallejuego
      WHERE detallejuego.INTIDDETALLE = @IDJuego      



   END
GO
/****** Object:  StoredProcedure [dbo].[sp_historialresultados_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_historialresultados_delete]  
   @IDJuego int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM detallejuego
      WHERE detallejuego.INTIDJUEGO = @IDJuego

   

      SELECT [@IDUsuario] = historialresultados.INTCVEJUGADOR
      FROM historialresultados
      WHERE historialresultados.INTIDJUEGO = @IDJuego      



      EXECUTE sp_sesioncategorias_delete @IDJuego, IDJugador      



      DELETE 
      FROM historialresultados
      WHERE historialresultados.INTIDJUEGO = @IDJuego

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_historialresultados_insert_or_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_historialresultados_insert_or_update]  
   @IDJuego int,
   @IDJugador int,
   @dateJuego datetime2(0),
   @correct int,
   @incorrect int,
   @grade int,
   @total_cards int,
   @playingInHard smallint,
   @sound_tries int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      IF @IDjuego IS NULL
         IF @IDJuego IS NULL OR @IDJuego = 0
            BEGIN
               /*
               *   SSMA informational messages:
               *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
               */

               INSERT historialresultados(
                  loteria.historialresultados.INTCVEJUGADOR, 
                  loteria.historialresultados.DATEFECHA, 
                  loteria.historialresultados.INTACIERTOS, 
                  loteria.historialresultados.INTERRORES, 
                  loteria.historialresultados.INTCALIFICACION, 
                  loteria.historialresultados.INTTOTALCARTAS, 
                  loteria.historialresultados.BOOLDIFICIL, 
                  loteria.historialresultados.INTSONIDO)
                  VALUES (
                     @IDJugador, 
                     isnull(@dateJuego, getdate()), 
                     @correct, 
                     @incorrect, 
                     @grade, 
                     @total_cards, 
                     @playingInHard, 
                     @sound_tries)
            END
         ELSE 
            BEGIN

               SET  IDENTITY_INSERT loteria.historialresultados  ON

               /*
               *   SSMA informational messages:
               *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
               */

               INSERT loteria.historialresultados(
                  loteria.historialresultados.INTIDJUEGO, 
                  loteria.historialresultados.INTCVEJUGADOR, 
                  loteria.historialresultados.DATEFECHA, 
                  loteria.historialresultados.INTACIERTOS, 
                  loteria.historialresultados.INTERRORES, 
                  loteria.historialresultados.INTCALIFICACION, 
                  loteria.historialresultados.INTTOTALCARTAS, 
                  loteria.historialresultados.BOOLDIFICIL, 
                  loteria.historialresultados.INTSONIDO)
                  VALUES (
                     @IDJuego, 
                     @IDJugador, 
                     isnull(@dateJuego, getdate()), 
                     @correct, 
                     @incorrect, 
                     @grade, 
                     @total_cards, 
                     @playingInHard, 
                     @sound_tries)

               SET  IDENTITY_INSERT loteria.historialresultados  OFF

            END
      ELSE 
         /*
         *   SSMA informational messages:
         *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
         */

         UPDATE loteria.historialresultados
            SET 
               INTCVEJUGADOR = @IDJugador, 
               DATEFECHA = isnull(@dateJuego, getdate()), 
               INTACIERTOS = @correct, 
               INTERRORES = @incorrect, 
               INTCALIFICACION = @grade, 
               INTTOTALCARTAS = @total_cards, 
               BOOLDIFICIL = @playingInHard, 
               INTSONIDO = @sound_tries
         WHERE historialresultados.INTIDJUEGO = @IDJuego

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_historialresultados_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_historialresultados_select]  
   @IDResultado int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         historialresultados.INTIDJUEGO, 
         historialresultados.INTCVEJUGADOR, 
         historialresultados.DATEFECHA, 
         historialresultados.INTACIERTOS, 
         historialresultados.INTERRORES, 
         historialresultados.INTCALIFICACION, 
         historialresultados.INTTOTALCARTAS, 
         historialresultados.BOOLDIFICIL, 
         historialresultados.INTSONIDO
      FROM historialresultados
      WHERE historialresultados.INTIDJUEGO = @IDResultado

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_historialresultados_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_historialresultados_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         historialresultados.INTIDJUEGO, 
         historialresultados.INTCVEJUGADOR, 
         historialresultados.DATEFECHA, 
         historialresultados.INTACIERTOS, 
         historialresultados.INTERRORES, 
         historialresultados.INTCALIFICACION, 
         historialresultados.INTTOTALCARTAS, 
         historialresultados.BOOLDIFICIL, 
         historialresultados.INTSONIDO
      FROM historialresultados

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_delete]  
   @IDjugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      EXECUTE sp_categoriasdejugador_delete_all_per_jugador @IDjugador

      DELETE 
      FROM jugador
      WHERE jugador.INTCVEJUGADOR = @IDjugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_insert]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_insert]  
   @IDusuario int,
   @name nvarchar(45),
   @gender nvarchar(1),
   @schoolgrade int,
   @birthday datetime2(0),
   @inscriptionDate datetime2(0)
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      
         INSERT jugador(
            loteria.jugador.INTCVEUSUARIO, 
            loteria.jugador.VCHNOMBRE, 
            loteria.jugador.GENERO, 
            loteria.jugador.GRADO, 
            loteria.jugador.FECHANACIMIENTO, 
            loteria.jugador.FECHAINSCRIPCION)
            VALUES (
               @IDusuario, 
               @name, 
               @gender, 
               @schoolgrade, 
               isnull(@birthday, getdate()), 
               isnull(@inscriptionDate, getdate()))
      
   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_insert_or_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_insert_or_update]  
   @IDusuario int,
   @name nvarchar(45),
   @gender nvarchar(1),
   @schoolgrade int,
   @birthday datetime2(0),
   @inscriptionDate datetime2(0),
   @IDjugador int =NULL
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      IF @IDjugador IS NULL
         /*
         *   SSMA informational messages:
         *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
         *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
         */

         INSERT jugador(
            loteria.jugador.INTCVEUSUARIO, 
            loteria.jugador.VCHNOMBRE, 
            loteria.jugador.GENERO, 
            loteria.jugador.GRADO, 
            loteria.jugador.FECHANACIMIENTO, 
            loteria.jugador.FECHAINSCRIPCION)
            VALUES (
               @IDusuario, 
               @name, 
               @gender, 
               @schoolgrade, 
               isnull(@birthday, getdate()), 
               isnull(@inscriptionDate, getdate()))
      ELSE 
         /*
         *   SSMA informational messages:
         *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
         *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
         */

         UPDATE jugador
            SET 
               INTCVEUSUARIO = @IDusuario, 
               VCHNOMBRE = @name, 
               GRADO = @schoolgrade, 
               FECHANACIMIENTO = isnull(@birthday, getdate()), 
               FECHAINSCRIPCION = isnull(@inscriptionDate, getdate())
         WHERE jugador.INTCVEJUGADOR = @IDjugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_select]  
   @IDjugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         jugador.INTCVEUSUARIO, 
         jugador.VCHNOMBRE, 
         jugador.GENERO, 
         jugador.GRADO, 
         jugador.FECHANACIMIENTO, 
         jugador.FECHAINSCRIPCION
      FROM jugador
      WHERE jugador.INTCVEJUGADOR = @IDjugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT 
         jugador.INTCVEJUGADOR, 
         jugador.INTCVEUSUARIO, 
         jugador.VCHNOMBRE, 
         jugador.GENERO, 
         jugador.GRADO, 
         jugador.FECHANACIMIENTO, 
         jugador.FECHAINSCRIPCION
      FROM jugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_jugador_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_jugador_update]  
	@IDjugador int,
   @IDusuario int,
   @name nvarchar(45),
   @gender nvarchar(1),
   @schoolgrade int,
   @birthday datetime2(0),
   @inscriptionDate datetime2(0)
   
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

    

        
         UPDATE jugador
            SET 
               INTCVEUSUARIO = @IDusuario, 
               VCHNOMBRE = @name, 
               GRADO = @schoolgrade, 
               FECHANACIMIENTO = isnull(@birthday, getdate()), 
               FECHAINSCRIPCION = isnull(@inscriptionDate, getdate())
         WHERE jugador.INTCVEJUGADOR = @IDjugador

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_sesioncategorias_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_sesioncategorias_delete]  
   @IDJuego int,
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM sesioncategorias
      WHERE intIDresultadosesion = @IDJuego AND intcvejugador = @IDJugador      



   END
GO
/****** Object:  StoredProcedure [dbo].[sp_sesioncategorias_insert]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_sesioncategorias_insert]  
   @IDJuego int,
   @IDCategoria int,
   @IDJugador int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      INSERT sesioncategorias(sesioncategorias.INTIDRESULTADOSESION, sesioncategorias.INTIDCATEGORIA, sesioncategorias.INTCVEJUGADOR)
         VALUES (@IDJuego, @IDCategoria, @IDJugador)

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_sesioncategorias_select_per_juego]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_sesioncategorias_select_per_juego]  
   @IDJuego int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT sesioncategorias.INTIDRESULTADOSESION, sesioncategorias.INTIDCATEGORIA, sesioncategorias.INTCVEJUGADOR
      FROM sesioncategorias
      WHERE sesioncategorias.INTIDRESULTADOSESION = @IDJuego

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_usuario_delete]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_usuario_delete]  
   @IDusuario int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      DELETE 
      FROM jugador
      WHERE jugador.INTCVEUSUARIO = @IDusuario

      DELETE 
      FROM usuario
      WHERE usuario.INTCVEUSUARIO = @IDusuario

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_usuario_insert_or_update]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_usuario_insert_or_update]  
   @username nvarchar(45),
   @pass nvarchar(45),
   @usertype nvarchar(1),
   @IDusuario int =null
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      IF @IDusuario IS NULL
         INSERT usuario(usuario.VCHUSUARIO, usuario.VCHPASSWORD, usuario.CHRTIPOUSUARIO)
            VALUES (@username, @pass, @usertype)
      ELSE 
         UPDATE usuario
            SET 
               VCHUSUARIO = @username, 
               VCHPASSWORD = @pass, 
               CHRTIPOUSUARIO = @usertype
         WHERE usuario.INTCVEUSUARIO = @IDusuario

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_usuario_select]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_usuario_select]  
   @IDusuario int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT usuario.INTCVEUSUARIO, usuario.VCHUSUARIO, usuario.VCHPASSWORD, usuario.CHRTIPOUSUARIO
      FROM usuario
      WHERE usuario.INTCVEUSUARIO = @IDusuario

   END
GO
/****** Object:  StoredProcedure [dbo].[sp_usuario_select_all]    Script Date: 20/02/2018 09:45:01 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [dbo].[sp_usuario_select_all]
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SELECT usuario.INTCVEUSUARIO, usuario.VCHUSUARIO, usuario.VCHPASSWORD, usuario.CHRTIPOUSUARIO
      FROM usuario

   END
GO
USE [master]
GO
ALTER DATABASE [loteria2] SET  READ_WRITE 
GO
