
CREATE TABLE [dbo].[TblAmlakagreementAttachs](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FileName] [nvarchar](3000) NULL,
    [AmlakInfoId] [int] NULL,
    [FileTitle] [nvarchar](250) NULL,
    [Type] [nvarchar](20) NULL
    ) ON [PRIMARY]
    GO



CREATE TABLE [dbo].[tblAmlakagreement](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [SdiId] [nvarchar](100) NULL,
    [IsSubmitted] [int] NULL,
    [Title] [nvarchar](50) NULL,
    [Date] [datetime] NULL,
    [ContractParty] [nvarchar](50) NULL,
    [AmountMunicipality] [nvarchar](50) NULL,
    [AmountContractParty] [nvarchar](50) NULL,
    [DateFrom] [datetime] NULL,
    [DateTo] [datetime] NULL,
    [Description] [nvarchar](500) NULL,
    [Coordinates] [varchar](500) NULL,
    [Address] [nvarchar](150) NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakagreement] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO




add OwnerId in tblAmlakInfo default 0
add Coordinates in tblAmlakInfo
remove lat , lng ,IsContracted in tblAmlakInfo
change owner to ownerType

