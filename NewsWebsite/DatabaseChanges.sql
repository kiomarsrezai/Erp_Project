add table tblAmlakPrivateDocHistory

add ownerId col int  to tblAmlakPrivateNew   =0
add DocumentType col int  to tblAmlakPrivateNew   =0
change masahat col to int in  tblAmlakPrivateNew
add SajamCode col to varchar in  tblAmlakPrivateNew
add SdiId col to tblAmlakArchive
change all cols to nvarchar in tblAmlakArchive
delete latitude longitude in tblAmlakArchive
add IsSubmitted col int in        tblAmlakArchive  =0
change Owner to ownerId int in tblAmlakArchive=0
change areaCode to areaId int in tblAmlakArchive=0
delete jamCode int tblAmlakArchive
change AreaId to OwnerId in  tblContractAmlakInfo
       
add CreatedAt,UpdatedAt DateTime in tblAmlakArchive
add CreatedAt,UpdatedAt DateTime in tblAmlakCompliant
add CreatedAt,UpdatedAt DateTime in tblAmlakInfo
add CreatedAt,UpdatedAt DateTime in tblAmlakParcel
add CreatedAt,UpdatedAt DateTime in tblAmlakPrivateNew
add CreatedAt,UpdatedAt DateTime in tblContractAmlakInfo
       

       
       
       
       USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblAmlakPrivateDocHistory]    Script Date: 9/29/2024 2:19:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAmlakPrivateDocHistory](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AmlakPrivateId] [int] NULL,
    [Status] [nvarchar](50) NULL,
    [Desc] [nvarchar](1000) NULL,
    [Date] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakPrivateDocHistory] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO


