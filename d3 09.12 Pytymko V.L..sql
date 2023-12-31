USE [Library]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[pages] [int] NOT NULL,
	[year_press] [int] NOT NULL,
	[id_theme] [int] NOT NULL,
	[id_category] [int] NOT NULL,
	[id_author] [int] NOT NULL,
	[id_publishment] [int] NOT NULL,
	[comment] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK__Books__3213E83F47B37243] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Cards]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Cards](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_teacher] [int] NULL,
	[id_book] [int] NULL,
	[date_out] [nvarchar](50) NULL,
	[date_in] [nvarchar](50) NULL,
	[id_librarian] [int] NULL,
 CONSTRAINT [PK__T_Cards__3213E83F4446C1D5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[id_department] [int] NULL,
 CONSTRAINT [PK__Teachers__3213E83F986F87EF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TEACHER_BOOK]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TEACHER_BOOK] AS   
SELECT T.first_name + ' ' + T.last_name  [ВИКЛАДАЧ] , B.name  [ НАЗВА КНИГИ НА РУКАХ]
FROM Teacher T, Book B, T_Cards TC
WHERE T.id=TC.id_teacher AND  TC.id_book=B.id
GO
/****** Object:  Table [dbo].[S_Cards]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[S_Cards](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_student] [int] NOT NULL,
	[id_book] [int] NOT NULL,
	[date_out] [nvarchar](50) NULL,
	[date_in] [nvarchar](50) NULL,
	[id_librarian] [int] NOT NULL,
 CONSTRAINT [PK__S_Cards__3213E83F7E21590D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[id_group] [int] NOT NULL,
	[term] [int] NULL,
 CONSTRAINT [PK__Students__3213E83FE3F27931] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[СТУДЕНТИ З КНИГАМИ НА РУКАХ]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[СТУДЕНТИ З КНИГАМИ НА РУКАХ] AS
SELECT S.first_name+' '+S.last_name [СТУДЕНТИ З КНИГАМИ НА РУКАХ]
FROM Student S, S_Cards SC
WHERE S.id=SC.id_student AND SC.date_in IS NULL
GO
/****** Object:  View [dbo].[СТУДЕНТИ, ЩО НІКОЛИ НЕ БРАЛИ КНИГ]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[СТУДЕНТИ, ЩО НІКОЛИ НЕ БРАЛИ КНИГ] AS
SELECT S.first_name +' ' + S.last_name [СТУДЕНТИ, ЩО НІКОЛИ НЕ БРАЛИ КНИГ]
FROM Student S
LEFT JOIN S_Cards SC ON S.id=SC.id_student
WHERE SC.id_student IS NULL;
GO
/****** Object:  Table [dbo].[Librarian]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Librarian](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Libs__3213E83F3EB3017D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[САМИЙ АКТИВНИЙ БІБЛІОТЕКАР]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[САМИЙ АКТИВНИЙ БІБЛІОТЕКАР] AS

SELECT TOP 1
LibrarianName,COUNT(*) AS TotalBooksIssued
FROM (
SELECT 
L.id AS LibrarianID,
L.first_name+' '+L.last_name AS LibrarianName,
TC.id AS CardId
FROM T_Cards TC
JOIN Librarian L ON TC.id_librarian = L.id

UNION ALL 

SELECT L.id AS LibrarianID,
L.first_name+' '+L.last_name AS LibrarianName,
SC.id AS CardId
FROM S_Cards SC 
JOIN Librarian L ON SC.id_librarian=L.id) AS CombinedData
GROUP BY LibrarianID,LibrarianName
ORDER BY TotalBooksIssued DESC 




GO
/****** Object:  View [dbo].[САМИЙ ВІДПОВІДАЛЬНИЙ БІБЛІОТЕКАР]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[САМИЙ ВІДПОВІДАЛЬНИЙ БІБЛІОТЕКАР] AS

SELECT TOP 1
LibrarianName,COUNT(*) AS TotalBooksReturned
FROM (
SELECT 
L.id AS LibrarianID,
L.first_name+' '+L.last_name AS LibrarianName,
TC.id AS CardId
FROM T_Cards TC
JOIN Librarian L ON TC.id_librarian = L.id
WHERE TC.date_in IS NOT NULL
UNION ALL 

SELECT L.id AS LibrarianID,
L.first_name+' '+L.last_name AS LibrarianName,
SC.id AS CardId
FROM S_Cards SC 
JOIN Librarian L ON SC.id_librarian=L.id
WHERE SC.date_in IS NOT NULL) AS CombinedData
GROUP BY LibrarianID,LibrarianName
ORDER BY TotalBooksReturned DESC 




GO
/****** Object:  Table [dbo].[Author]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Authors__3213E83FB050A18E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Categori__3213E83F6CB94F4A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Departme__3213E83F71C95102] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[id_department] [int] NOT NULL,
 CONSTRAINT [PK__Groups__3213E83FD538E9C2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishment]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Press__3213E83F769C9C60] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK__Themes__3213E83FDD8BA9E4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ВИКЛАДАЧ]    Script Date: 16.12.2023 22:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ВИКЛАДАЧ](
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Author] ADD  CONSTRAINT [DF__Authors__first_n__108B795B]  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dbo].[Author] ADD  CONSTRAINT [DF__Authors__last_na__117F9D94]  DEFAULT (NULL) FOR [last_name]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__name__145C0A3F]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__pages__15502E78]  DEFAULT (NULL) FOR [pages]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__year_pres__164452B1]  DEFAULT (NULL) FOR [year_press]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__id_themes__173876EA]  DEFAULT (NULL) FOR [id_theme]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__id_catego__182C9B23]  DEFAULT (NULL) FOR [id_category]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__id_author__1920BF5C]  DEFAULT (NULL) FOR [id_author]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__id_press__1A14E395]  DEFAULT (NULL) FOR [id_publishment]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__comment__1B0907CE]  DEFAULT (NULL) FOR [comment]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF__Books__quantity__1BFD2C07]  DEFAULT (NULL) FOR [quantity]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF__Categories__name__1ED998B2]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [DF__Department__name__21B6055D]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[Group] ADD  CONSTRAINT [DF__Groups__name__276EDEB3]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[Group] ADD  CONSTRAINT [DF__Groups__id_facul__286302EC]  DEFAULT (NULL) FOR [id_department]
GO
ALTER TABLE [dbo].[Librarian] ADD  CONSTRAINT [DF__Libs__first_name__2B3F6F97]  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dbo].[Librarian] ADD  CONSTRAINT [DF__Libs__last_name__2C3393D0]  DEFAULT (NULL) FOR [last_name]
GO
ALTER TABLE [dbo].[Publishment] ADD  CONSTRAINT [DF__Press__name__2F10007B]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[S_Cards] ADD  CONSTRAINT [DF__S_Cards__id_stud__31EC6D26]  DEFAULT (NULL) FOR [id_student]
GO
ALTER TABLE [dbo].[S_Cards] ADD  CONSTRAINT [DF__S_Cards__id_book__32E0915F]  DEFAULT (NULL) FOR [id_book]
GO
ALTER TABLE [dbo].[S_Cards] ADD  CONSTRAINT [DF__S_Cards__date_ou__33D4B598]  DEFAULT (NULL) FOR [date_out]
GO
ALTER TABLE [dbo].[S_Cards] ADD  CONSTRAINT [DF__S_Cards__date_in__34C8D9D1]  DEFAULT (NULL) FOR [date_in]
GO
ALTER TABLE [dbo].[S_Cards] ADD  CONSTRAINT [DF__S_Cards__id_lib__35BCFE0A]  DEFAULT (NULL) FOR [id_librarian]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF__Students__first___398D8EEE]  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF__Students__last_n__3A81B327]  DEFAULT (NULL) FOR [last_name]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF__Students__id_gro__3B75D760]  DEFAULT (NULL) FOR [id_group]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF__Students__term__3C69FB99]  DEFAULT (NULL) FOR [term]
GO
ALTER TABLE [dbo].[T_Cards] ADD  CONSTRAINT [DF__T_Cards__id_Teac__3F466844]  DEFAULT (NULL) FOR [id_teacher]
GO
ALTER TABLE [dbo].[T_Cards] ADD  CONSTRAINT [DF__T_Cards__id_Book__403A8C7D]  DEFAULT (NULL) FOR [id_book]
GO
ALTER TABLE [dbo].[T_Cards] ADD  CONSTRAINT [DF__T_Cards__date_ou__412EB0B6]  DEFAULT (NULL) FOR [date_out]
GO
ALTER TABLE [dbo].[T_Cards] ADD  CONSTRAINT [DF__T_Cards__date_in__4222D4EF]  DEFAULT (NULL) FOR [date_in]
GO
ALTER TABLE [dbo].[T_Cards] ADD  CONSTRAINT [DF__T_Cards__id_lib__4316F928]  DEFAULT (NULL) FOR [id_librarian]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF__Teachers__first___45F365D3]  DEFAULT (NULL) FOR [first_name]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF__Teachers__last_n__46E78A0C]  DEFAULT (NULL) FOR [last_name]
GO
ALTER TABLE [dbo].[Teacher] ADD  CONSTRAINT [DF__Teachers__id_dep__47DBAE45]  DEFAULT (NULL) FOR [id_department]
GO
ALTER TABLE [dbo].[Theme] ADD  CONSTRAINT [DF__Themes__name__4AB81AF0]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Books_Authors] FOREIGN KEY([id_author])
REFERENCES [dbo].[Author] ([id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Books_Authors]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Books_Categories] FOREIGN KEY([id_category])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Books_Categories]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Books_Press] FOREIGN KEY([id_publishment])
REFERENCES [dbo].[Publishment] ([id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Books_Press]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Books_Themes] FOREIGN KEY([id_theme])
REFERENCES [dbo].[Theme] ([id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Books_Themes]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Departments] FOREIGN KEY([id_department])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Groups_Departments]
GO
ALTER TABLE [dbo].[S_Cards]  WITH CHECK ADD  CONSTRAINT [FK_S_Cards_Books] FOREIGN KEY([id_book])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[S_Cards] CHECK CONSTRAINT [FK_S_Cards_Books]
GO
ALTER TABLE [dbo].[S_Cards]  WITH CHECK ADD  CONSTRAINT [FK_S_Cards_Libs] FOREIGN KEY([id_librarian])
REFERENCES [dbo].[Librarian] ([id])
GO
ALTER TABLE [dbo].[S_Cards] CHECK CONSTRAINT [FK_S_Cards_Libs]
GO
ALTER TABLE [dbo].[S_Cards]  WITH CHECK ADD  CONSTRAINT [FK_S_Cards_Students] FOREIGN KEY([id_student])
REFERENCES [dbo].[Student] ([id])
GO
ALTER TABLE [dbo].[S_Cards] CHECK CONSTRAINT [FK_S_Cards_Students]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Students_Groups] FOREIGN KEY([id_group])
REFERENCES [dbo].[Group] ([id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Students_Groups]
GO
ALTER TABLE [dbo].[T_Cards]  WITH CHECK ADD  CONSTRAINT [FK_T_Cards_Books] FOREIGN KEY([id_book])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[T_Cards] CHECK CONSTRAINT [FK_T_Cards_Books]
GO
ALTER TABLE [dbo].[T_Cards]  WITH CHECK ADD  CONSTRAINT [FK_T_Cards_Libs] FOREIGN KEY([id_librarian])
REFERENCES [dbo].[Librarian] ([id])
GO
ALTER TABLE [dbo].[T_Cards] CHECK CONSTRAINT [FK_T_Cards_Libs]
GO
ALTER TABLE [dbo].[T_Cards]  WITH CHECK ADD  CONSTRAINT [FK_T_Cards_Teachers] FOREIGN KEY([id_teacher])
REFERENCES [dbo].[Teacher] ([id])
GO
ALTER TABLE [dbo].[T_Cards] CHECK CONSTRAINT [FK_T_Cards_Teachers]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teachers_Departments] FOREIGN KEY([id_department])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teachers_Departments]
GO
