USE [M037]
GO
/****** Object:  Table [dbo].[class]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[class](
	[class_id] [int] IDENTITY(1,1) NOT NULL,
	[course_id] [int] NULL,
	[class_name] [varchar](50) NULL,
 CONSTRAINT [PK_class] PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [varchar](50) NULL,
 CONSTRAINT [PK_course] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[dept_id] [int] IDENTITY(1,1) NOT NULL,
	[dept_name] [varchar](150) NULL,
 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED 
(
	[dept_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[desg_id] [int] IDENTITY(1,1) NOT NULL,
	[desg_name] [varchar](150) NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[desg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[emp]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emp](
	[eno] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[dob] [date] NULL,
	[designation] [int] NULL,
	[dept] [int] NULL,
	[salary] [numeric](18, 0) NULL,
	[cv] [varchar](150) NULL,
 CONSTRAINT [PK_emp] PRIMARY KEY CLUSTERED 
(
	[eno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reg]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[doj] [date] NULL,
	[desig] [varchar](50) NULL,
	[profile] [varchar](150) NULL,
	[role] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[refid] [int] NULL,
 CONSTRAINT [PK_reg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reg_tbl]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reg_tbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[password] [varchar](30) NULL,
	[age] [int] NULL,
	[contact] [varchar](15) NULL,
	[photo] [varchar](50) NULL,
 CONSTRAINT [PK_reg_tbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student]    Script Date: 16-11-2022 10:23:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[erno] [int] IDENTITY(1,1) NOT NULL,
	[rollno] [int] NULL,
	[name] [varchar](50) NULL,
	[class_id] [int] NULL,
	[course_id] [int] NULL,
	[email] [nvarchar](50) NULL,
	[mobile] [numeric](18, 0) NULL,
	[dob] [date] NULL,
 CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED 
(
	[erno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK_class_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK_class_course]
GO
