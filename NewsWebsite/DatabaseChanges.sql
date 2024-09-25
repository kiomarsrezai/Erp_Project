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
       
