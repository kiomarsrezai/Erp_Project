add UrbanPlanningPermitLetterDate to tblAmlakPrivateGenerating after UrbanPlanningPermitDate

add PersonType to tblAmlakPrivateDocHistory
add PersonName to tblAmlakPrivateDocHistory

add IsTransfered int to tblAmlakPrivateNew   default 0

UsageOnDocument  in tblAmlakPrivateNew => varchar(100) 
UsageOnDocument  in tblAmlakPrivateNew => varchar(100) 


USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblAmlakPrivateTransfer]    Script Date: 12/16/2024 3:35:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAmlakPrivateTransfer](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AmlakPrivateId] [int] NULL,
    [RecipientType] [int] NULL,
    [RecipientName] [nvarchar](50) NULL,
    [NationalCode] [nvarchar](50) NULL,
    [Representative] [nvarchar](50) NULL,
    [RecipientPhone] [nvarchar](50) NULL,
    [MunicipalityRepName] [nvarchar](50) NULL,
    [LetterDate] [datetime] NULL,
    [LetterNumber] [nvarchar](50) NULL,
    [NotaryOfficeNumber] [nvarchar](50) NULL,
    [NotaryOfficeLocation] [nvarchar](200) NULL,
    [ExitDate] [datetime] NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakPrivateTransfer] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO