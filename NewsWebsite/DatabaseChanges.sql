USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblAmlakAdmin]    Script Date: 10/24/2024 10:18:00 AM ******/
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
    [AmlakLisence] [nvarchar](MAX) NULL,
    [Password] [nvarchar](500) NULL,
    [Token] [nvarchar](100) NULL,
    [TokenExpireDate] [datetime] NULL,
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

    USE [ProgramBudDB]
    GO

/****** Object:  Table [dbo].[tblContractAmlakInfoChecks]    Script Date: 10/24/2024 10:52:06 AM ******/
    SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

CREATE TABLE [dbo].[tblContractAmlakInfoChecks](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AmlakInfoContractId] [int] NULL,
    [Number] [nvarchar](50) NULL,
    [Date] [datetime] NULL,
    [Amount] [nvarchar](50) NULL,
    [Description] [nvarchar](100) NULL,
    [IsPassed] [int] NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblContractAmlakInfoChecks] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO



    ----------------------------------------------------------------
----------------------------------------------------------------
    USE [ProgramBudDB]
    GO

/****** Object:  Table [dbo].[tblAmlakPrivateGenerating]    Script Date: 10/24/2024 10:51:27 AM ******/
    SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

CREATE TABLE [dbo].[tblAmlakPrivateGenerating](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AmlakPrivateId] [int] NULL,
    [MunicipalityActionRequired] [nvarchar](100) NULL,
    [MunicipalityAction] [nvarchar](100) NULL,
    [MunicipalityActionLetterNumber] [nvarchar](100) NULL,
    [LegalActionRequired] [nvarchar](100) NULL,
    [LegalAction] [nvarchar](100) NULL,
    [LegalActionLetterNumber] [nvarchar](100) NULL,
    [UrbanPlanningPermitRequired] [nvarchar](100) NULL,
    [UrbanPlanningPermitNumber] [nvarchar](100) NULL,
    [UrbanPlanningPermitDate] [nvarchar](100) NULL,
    [DocumentImage] [nvarchar](100) NULL,
    [ArchitecturalMapImage] [nvarchar](100) NULL,
    [SurveyMapImage] [nvarchar](100) NULL,
    [PermitImage] [nvarchar](100) NULL,
    [MoldReportImage] [nvarchar](100) NULL,
    [ActionHistory] [nvarchar](100) NULL,
    [FollowUpSentTo1] [nvarchar](100) NULL,
    [LetterNumber1] [nvarchar](100) NULL,
    [LetterDate1] [datetime] NULL,
    [FollowUpSentTo2] [nvarchar](100) NULL,
    [LetterNumber2] [nvarchar](100) NULL,
    [LetterDate2] [datetime] NULL,
    [FollowUpSentTo3] [nvarchar](100) NULL,
    [LetterNumber3] [nvarchar](100) NULL,
    [LetterDate3] [datetime] NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakPrivateGenerating] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO



    ----------------------------------------------------------------
----------------------------------------------------------------


add ZemanatEndDate (datetime) to tblContractAmlakInfo
