


CREATE TABLE ##GlobalVariable (GV_RosterID varchar(255), GV_Date varchar(255), GV_UDC varchar(255))  
INSERT INTO ##GlobalVariable VALUES  ('R-2717', '8/15/2024','MSYS')  -- enter Roster tracking ID, Date, UDC here at this line.
select * from ##GlobalVariable



-- clean up language

update networkdata.dbo.[PDM ADDS TEMPLATE]
set [PrimaryLanguage] = REPLACE([PrimaryLanguage],',,',',')
where [PrimaryLanguage] like ('%,,%')

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET [Zipcode] = LEFT([Zipcode],5)
where [Zipcode] like ('%-%')

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET [MiddleInitial] = LEFT([MiddleInitial],1)
where [MiddleInitial] is not null

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET [BillingZipCode] = LEFT([BillingZipCode],5)
where [BillingZipCode] like ('%-%')

-- clean up degree	
update networkdata.dbo.[PDM ADDS TEMPLATE]
set [Degree]=
ltrim(rtrim([Degree]))

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET ZipCodeExtended = NULL
WHERE ZipCodeExtended IN ('nan')

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET BillingZipCodeExtended = NULL
WHERE BillingZipCodeExtended IN ('nan')

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET [MedicaidID] = NULL
WHERE [MedicaidID] IN ('nan')

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET BillingZipCode = LEFT([BillingZipCode],5)
WHERE BillingZipCode like ('%BillingZipCode%')

---------Cleans gender column

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
Gender = 'M' where Gender = 'Male'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
Gender = 'F' where Gender = 'Female'

----------Gets rid of 'Pending' & 'N/A' from Medicaid & Medicare column

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicaidID = Null where MedicaidID = 'Pending'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicareID = Null where MedicareID = 'Pending'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicaidID = Null where MedicaidID = 'In processing'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicareID = Null where MedicareID = 'In Process'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicareID = Null where MedicareID = 'In processing'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicaidID = Null where MedicaidID = 'In Process'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicaidID = Null where MedicaidID = 'pending'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
set
MedicaidID = Null where MedicaidID like ('%ENT%')

---------------- Update zip code and county 

update networkdata.dbo.[PDM ADDS TEMPLATE]
	set County = zct.[county]
	from networkdata.dbo.[PDM ADDS TEMPLATE] as dir
	inner join
	NetworkData.[dbo].[Zip_County table] as zct
	on dir.Zipcode=zct.[zip code]
	where dir.County is null or dir.County in ('nan', '081','061','005','047','085',  '81','61','5','47','85')

-----------Cleans number format

update networkdata.dbo.[PDM ADDS TEMPLATE]
set BillingPhone = 
replace(replace(replace(replace(BillingPhone, '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set BillingFax = 
replace(replace(replace(replace(BillingFax, '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set OfficePhone = 
replace(replace(replace(replace(OfficePhone, '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set OfficeFax = 
replace(replace(replace(replace(OfficeFax, '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set [OfficePhone] = replace([OfficePhone], '.','')
update networkdata.dbo.[PDM ADDS TEMPLATE]
set [OfficeFax] = replace([OfficeFax], '','')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set BillingFax =null
where BillingFax in ('nan')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set OfficeFax =null
where OfficeFax in ('nan')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set OfficePhone = null 
where OfficePhone in ('nan')

-----------Gets rid of dashes from TIN

update networkdata.dbo.[PDM ADDS TEMPLATE]
set BillingTIN = replace(BillingTIN,'-','')
where BillingTIN like '%-%'

update networkdata.dbo.[PDM ADDS TEMPLATE]
set [BillingPhone] = null 
where [BillingPhone] in ('nan')

-------------Cleans and formats languages

--update networkdata.dbo.[PDM ADDS TEMPLATE]
--set
--PrimaryLanguage = CONCAT(_1_Foreign_Language,',',_2_Foreign_Language,',',_3_Foreign_Language) 
--FROM networkdata.dbo.[NWEL Roster] 
--left join networkdata.dbo.[PDM ADDS TEMPLATE] on
--networkdata.dbo.[PDM ADDS TEMPLATE].NPI = networkdata.dbo.[NWEL Roster].NPI
--where [NWEL Roster].RosterID = 'R-2629' and AffiliationAttribute = 'NWEL'

--update networkdata.dbo.[PDM ADDS TEMPLATE]
--set PrimaryLanguage=
--replace(ltrim(rtrim(replace(replace(replace(replace([primarylanguage], ',', '><'), '<>', ''), '><', ','), ',', ' '))), ' ', ',')

------------Cleans speciallty names

UPDATE t1
  SET t1.PrimarySpecialty = t2.[Roster Specialty]
  FROM networkdata.dbo.[PDM ADDS TEMPLATE] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.PrimarySpecialty = t2.[Primary Specialty] and t1.Degree = t2.Degree	

  UPDATE t1
  SET t1.SecondarySpecialty = t2.[Roster Specialty]
  FROM networkdata.dbo.[PDM ADDS TEMPLATE] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.SecondarySpecialty = t2.[Primary Specialty]  and t1.Degree = t2.Degree	

    UPDATE t1
  SET t1.Degree = t2.[Cleaned Degree]
  FROM networkdata.dbo.[PDM ADDS TEMPLATE] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.Degree = t2.Degree	


/*
--------- Updates Par Indicator Column

update networkdata.dbo.[PDM ADDS TEMPLATE]
set ParIndicator = 'Y'

-------------Adds todays date to Date column

UPDATE networkdata.dbo.[PDM ADDS TEMPLATE]
SET [date processed] = GETDATE()
WHERE [date processed] IS NULL;
*/

------------Cleans and formats correct address

 UPDATE t1
  SET t1.Address2 = t2.Roster_Directory_Address_2_Format
  FROM networkdata.dbo.[PDM ADDS TEMPLATE] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.Address1 = t2.Original_Address

UPDATE t1
  SET t1.Address1 = t2.Roster_Directory_Address_Format
  FROM networkdata.dbo.[PDM ADDS TEMPLATE] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.Address1 = t2.Original_Address

Update networkdata.dbo.[PDM ADDS TEMPLATE]
SET PrintInDirectory = 'Y'
WHERE PrintInDirectory = 'Yes'

Update networkdata.dbo.[PDM ADDS TEMPLATE]
SET PrintInDirectory = 'N'
WHERE PrintInDirectory = 'No'

update networkdata.dbo.[PDM ADDS TEMPLATE]
set PROVCOD = pnwel.[Note]
from networkdata.dbo.[PDM ADDS TEMPLATE] as padd
inner join
NetworkData.dbo.[Z_NWEL_Pediatrics_PDM] as pnwel
on padd.PrimarySpecialty = pnwel.[PrimarySpecialty]
where rosterid in (select distinct [GV_RosterID] from ##GlobalVariable) 
and AffiliationAttribute in (select distinct [GV_UDC] from ##GlobalVariable)  and AffiliationAttribute in ('NWEL')

update networkdata.dbo.[PDM ADDS TEMPLATE]
set PROVCOD = 'Not Loaded - Specialty'
WHERE (PrimarySpecialty LIKE ('%Child%') or PrimarySpecialty LIKE ('%Pediatrics%') or PrimarySpecialty LIKE ('%Adolescent%') or PrimarySpecialty LIKE ('%Neonatal%'))
	and rosterid in (select distinct [GV_RosterID] from ##GlobalVariable)

select distinct [PROVCOD] as [PRV#]
      ,[LastName]
      ,[FirstName]
      ,[MiddleInitial]
      ,[Degree]
      ,[Gender]
      ,[NPI]
      ,[MedicaidID]
      ,[MedicareID]
      ,[Address1]
      ,[Address2]
      ,[City]
      ,[State]
      ,[ZipCode]
      ,[ZipCodeExtended]
      ,[County]
      ,[CountyServed]
      ,[PrimaryLanguage]
      ,[SecondaryLanguage]
      ,[PrintInDirectory]
      ,[AcceptingNewPatients]
      ,[PrimarySpecialty]
      ,[SecondarySpecialty]
      ,[TertiarySpecialty]
      ,[QuaternarySpecialty]
      ,[OfficePhone]
      ,[OfficeFax]
      ,[EmailAddress]
      ,[BillingNPI]
      ,[BillingTIN]
      ,[BillingName]
      ,[BillingAddress1]
      ,[BillingAddress2]
      ,[BillingCity]
      ,[BillingState]
      ,[BillingZipCode]
      ,[BillingZipCodeExtended]
      ,[BillingCounty]
      ,[BillingPhone]
      ,[BillingFax]
      ,[BillingEmail]
      ,[IsPrimaryAddress]
      ,[LOB]
      ,[EffectiveDate]
      ,[PCPFlag]
      ,[ContractCode]
      ,[PROVCOD]
      ,[AffiliationAttribute]
      ,[ParIndicator]

from networkdata.dbo.[PDM ADDS TEMPLATE]
where rosterid
in (select distinct [GV_RosterID] from ##GlobalVariable)    -- Roster tracking ID a 
and AffiliationAttribute in (select distinct [GV_UDC] from ##GlobalVariable) 


/* ---------------
	Drop global here

	--------------- */

Drop Table ##GlobalVariable



