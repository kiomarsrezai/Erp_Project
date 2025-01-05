USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblAmlakTicket]    Script Date: 1/5/2025 5:11:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAmlakTicket](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [UUID] [nvarchar](50) NULL,
    [Title] [nvarchar](500) NOT NULL,
    [AdminId] [int] NOT NULL,
    [LastAdminId] [int] NOT NULL,
    [Status] [int] NOT NULL,
    [UpdatedAt] [datetime] NULL,
    [CreatedAt] [datetime] NULL,
    [Links] [nvarchar](max) NULL,
    CONSTRAINT [PK__tblAmlak__3214EC076E3A2022] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO


    USE [ProgramBudDB]
    GO

/****** Object:  Table [dbo].[tblAmlakTicketAdmin]    Script Date: 1/5/2025 5:11:34 PM ******/
    SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

CREATE TABLE [dbo].[tblAmlakTicketAdmin](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [TicketId] [int] NOT NULL,
    [AdminId] [int] NOT NULL,
    [Type] [int] NOT NULL,
    PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO


    USE [ProgramBudDB]
    GO

/****** Object:  Table [dbo].[tblAmlakTicketMessage]    Script Date: 1/5/2025 5:11:43 PM ******/
    SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

CREATE TABLE [dbo].[tblAmlakTicketMessage](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [TicketId] [int] NOT NULL,
    [FromId] [int] NOT NULL,
    [ToId] [int] NOT NULL,
    [Message] [text] NOT NULL,
    [CreatedAt] [datetime] NULL,
    PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO



