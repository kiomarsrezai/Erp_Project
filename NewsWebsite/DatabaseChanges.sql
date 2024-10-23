USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblAmlakAdmin]    Script Date: 10/23/2024 4:45:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAmlakAdmin](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](100) NULL,
    [LastName] [nvarchar](100) NULL,
    [UserName] [nvarchar](100) NULL,
    [PhoneNumber] [nvarchar](100) NULL,
    [Bio] [nvarchar](100) NULL,
    [AmlakLisence] [nvarchar](2000) NULL,
    [Password] [nvarchar](500) NULL,
    [Token] [nvarchar](100) NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakAdmin] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO


----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------