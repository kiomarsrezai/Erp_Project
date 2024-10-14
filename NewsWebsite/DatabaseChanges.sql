
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



add Title to amlakArchive nvarchar(250)
    
add OwnerId in tblAmlakInfo default 0
add Coordinates in tblAmlakInfo
remove lat , lng ,IsContracted in tblAmlakInfo
change owner to ownerType

change SajamCode to JamCode in tblAmlakPrivateNew




ALTER TABLE tblAmlakPrivateNew
    ADD
        MainPlateNumber NVARCHAR(50),
    SubPlateNumber NVARCHAR(50),
    Section NVARCHAR(50),
    Address NVARCHAR(50),
    UsageOnDocument NVARCHAR(50),
    PropertyType NVARCHAR(50),
    OwnershipType NVARCHAR(50),
    OwnershipPercentage NVARCHAR(50),
    TransferredFrom NVARCHAR(50),
    InPossessionOf NVARCHAR(50),
    UsageUrban NVARCHAR(50),
    BlockedStatusSimakUnitWindow NVARCHAR(50),
    Status NVARCHAR(50),
    Notes NVARCHAR(50),
    ArchiveLocation NVARCHAR(50),
    DocumentSerial NVARCHAR(50),
    DocumentSeries NVARCHAR(50),
    DocumentAlphabet NVARCHAR(50),
    PropertyCode NVARCHAR(50),
    Year NVARCHAR(50),
    EntryDate NVARCHAR(50),
    InternalDate NVARCHAR(50),
    ProductiveAssetStrategies NVARCHAR(50),
    SimakCode NVARCHAR(50);


add SdiPlateNumber to tblAmlakPrivateNew  NVARCHAR(50)
change type of  Masahat to float  NVARCHAR(50)

update tblAmlakPrivateNew
set SdiPlateNumber=SadaCode

update tblAmlakPrivateNew
set SadaCode=''