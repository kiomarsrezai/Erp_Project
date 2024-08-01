#sadegh 14030502
        
tblAmlakInfo ->add columns:
    CurrentStatus (varchar20) nullable
    Structure (varchar20) nullable
    Owner (varchar20) nullable
             
 TblContractAttachs -> add columns
    Title nvarchar(3000) nullable
        
update SP012_AmlakInfo_Search
update SP012_AmlakInfo_Update
update SP012_AmlakInfo_Read
update SP0_AmlakInfoFileDetail_Insert
update SP000_GetListContractAttachFiles

add [SP000_GetListAmlakInfoAttachFiles]
add [TblAmlakInfoAttachs]
add [SP0_ContractFileDetail_Insert]
edit [SP0_AmlakInfoFileDetail_Insert]
edit [SP012_ContractAmlak_Insert]
edit [SP012_ContractAmlak_Update]

    TblAmlakInfoAttachs -> add column 
        Type (nvarchar(20)) nullable

edit SP0_AmlakInfoFileDetail_Insert
edit SP000_GetListAmlakInfoAttachFiles