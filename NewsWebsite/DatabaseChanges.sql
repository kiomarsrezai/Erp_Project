privateDocHistory add LetterNumber  nvarchar(50)
privateDocHistory add LetterNumber  datetime

amlakPRivateNew delete column typeUsing                  
amlakPRivateNew delete column entryDate                  
amlakPRivateNew add column DocumentDate after InternalDate

tblAmlakPrivateDocHistory add column Type nvarchar(50)
update tblAmlakPrivateDocHistory set Type='general'

tblAmlakArchive change plaque1 to MainPlateNumber
tblAmlakArchive change plaque2 to SubPlateNumber