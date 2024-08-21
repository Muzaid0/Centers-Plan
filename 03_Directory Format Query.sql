
/* -------------------------------

-- Create table to store global variable
-- ##GlobalVariable is the table to store global value - [GV_Date] and [GV_RosterID]
-- [GV_Date] is global value of date
-- [GV_RosterID] is global value of roster ID

*/

CREATE TABLE ##GlobalVariable (GV_RosterID varchar(255), GV_Date varchar(255), GV_UDC varchar(255))  
INSERT INTO ##GlobalVariable VALUES ('R-2716', '8/15/2024','BRUI') -- enter Roster tracking ID, Date, UDC here at this line.
select * from ##GlobalVariable



/*
select * from networkdata.dbo.[Directory Roster Template]
where [Roster ID] in ('R-2649')

delete from networkdata.dbo.[Directory Roster Template]
where [Roster ID] in ('R-2649')
*/

UPDATE networkdata.dbo.[Directory Roster Template]
SET [Zip_code] = LEFT([Zip_code],5)

---------Combines Providers first,middle, & last name formatted correctly
Update networkdata.dbo.[Directory Roster Template]
set [Fax_Number] = null
where [Fax_Number] in ('nan','(nan)  - ')

-- clean up degree	
update networkdata.dbo.[Directory Roster Template]
set [Degree]=
ltrim(rtrim([Degree]))

UPDATE networkdata.dbo.[Directory Roster Template]
set 
PROVIDER_FULL_NAME = 
CASE WHEN [MNAME] IS not NULL THEN REPLACE(CONCAT_WS(' ',FNAME,MNAME,LNAME),'  ',' ')
	WHEN [MNAME] IS NULL THEN REPLACE(CONCAT_WS(' ',FNAME,LNAME),'  ',' ')
	END
---------Cleans gender column

Update networkdata.dbo.[Directory Roster Template]
set
Gender = 'M' where Gender = 'Male'

Update networkdata.dbo.[Directory Roster Template]
set
Gender = 'F' where Gender = 'Female'

UPDATE networkdata.dbo.[Directory Roster Template]
SET License = NULL
WHERE License IN ('Pending')

UPDATE networkdata.dbo.[Directory Roster Template]
SET License = REPLACE([License],'F','')

UPDATE networkdata.dbo.[Directory Roster Template]
SET License = REPLACE([License],'N','')



----------Gets rid of 'Pending' & 'N/A' from Medicaid & Medicare column


Update networkdata.dbo.[Directory Roster Template]
set
[MEDICAID_ID] = Null where [MEDICAID_ID] in ('Pending', 'App Sent')

Update networkdata.dbo.[Directory Roster Template]
set
[Medicare_ID] = Null where [Medicare_ID] in ('Pending', 'App Sent')

Update networkdata.dbo.[Directory Roster Template]
set
[MEDICAID_ID] = Null where [MEDICAID_ID] = 'In processing'

Update networkdata.dbo.[Directory Roster Template]
set
[Medicare_ID] = Null where [Medicare_ID] = 'In Process'

Update networkdata.dbo.[Directory Roster Template]
set
[Medicare_ID] = Null where [Medicare_ID] = 'In processing'

Update networkdata.dbo.[Directory Roster Template]
set
[MEDICAID_ID] = Null where [MEDICAID_ID] = 'In Process'


Update networkdata.dbo.[Directory Roster Template]
set
[MEDICAID_ID] = Null where [MEDICAID_ID] = 'N/A'

Update networkdata.dbo.[Directory Roster Template]
set
[Medicare_ID] = Null where [Medicare_ID] = 'N/A'

-----------Cleans number format

update networkdata.dbo.[Directory Roster Template]
set [Phone_Number] = 
replace(replace(replace(replace([Phone_Number], '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[Directory Roster Template]
set [Fax_Number] = 
replace(replace(replace(replace([Fax_Number], '(',''), ' ',''),'-',''),')','')

update networkdata.dbo.[Directory Roster Template]
set [Phone_Number] = replace([Phone_Number], '.','')
update networkdata.dbo.[Directory Roster Template]
set [Fax_Number] = replace([Fax_Number], '','')

-----------Gets rid of dashes from TIN

update networkdata.dbo.[Directory Roster Template]
set TIN = replace(TIN,'-','')
where TIN like '%-%'

update networkdata.dbo.[Directory Roster Template]
set [DEA_Number] = replace([DEA_Number],'-','')
where [DEA_Number] like ('nan')

update networkdata.dbo.[Directory Roster Template]
set  [Board_Certified_Primary_Specialty] = 'N'
where [Board_Certified_Primary_Specialty] is null or [Board_Certified_Primary_Specialty] in ('nan')

update networkdata.dbo.[Directory Roster Template]
set [Extended_Zip] = null
where Extended_Zip in ('nan')

update networkdata.dbo.[Directory Roster Template]
set [TTYDisable_Svcs] = null
where [TTYDisable_Svcs] in ('nan')

Update networkdata.dbo.[Directory Roster Template]
set
MEDICAID_ID = Null where MEDICAID_ID = 'pending'

Update networkdata.dbo.[Directory Roster Template]
set
MEDICAID_ID = Null where MEDICAID_ID like ('%ENT%')


/*
	----------------------
	Updating Contracted LOB for each UDC in directory template
	------------------------
	*/


update dir
set dir.[Contract_MLTC]=LOB.[Contract MLTC],
	dir.[Contract_MAPD]=LOB.[Contract MAPD],
	dir.[Contract_FIDA]='N',
	dir.[contract_MAP]=LOB.[Contract MAP],
	dir.[contract_ISNP]=LOB.[Contract ISNP],
	dir.[contract_DSNP]=LOB.[Contract DSNP]

	from networkdata.dbo.[Directory Roster Template] as dir
		inner join networkdata.[dbo].[Z_Lines of business_UDC] as LOB
		on dir.UDC=LOB.[UDC]
	where dir.[Contract_MLTC] is null


---------------- Update zip code and county 

update networkdata.dbo.[Directory Roster Template]
	set County = zct.[county]
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join
	NetworkData.[dbo].[Zip_County table] as zct
	on dir.Zip_code=zct.[zip code]
	where dir.County is null or dir.County in ('nan','85','81','59', '081','061','005','047','085', 'nan', '081','061','005','047','085',  '81','61','5','47','85')


-------------Cleans and formats Office Hours


UPDATE t1
  SET t1.[Monday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Monday] = t2.Office_Hours

UPDATE t1
  SET t1.[Tuesday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Tuesday] = t2.Office_Hours

UPDATE t1
  SET t1.[Wednesday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Wednesday] = t2.Office_Hours

UPDATE t1
  SET t1.[Thursday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Thursday] = t2.Office_Hours

UPDATE t1
  SET t1.[Friday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Friday] = t2.Office_Hours

UPDATE t1
  SET t1.[Saturday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Saturday] = t2.Office_Hours


UPDATE t1
  SET t1.[Sunday] = t2.Cleaned_Office_Hours
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_officehours AS t2
  ON t1.[Sunday] = t2.Office_Hours

update networkdata.dbo.[Directory Roster Template]
set
Office_Hours = CONCAT('Monday ',[Monday],',','Tuesday ',[Tuesday],',','Wednesday ',[Wednesday],',','Thursday ',[Thursday],',','Friday ',[Friday],','
,'Saturday ',[Saturday],',','Sunday ',[Sunday])
FROM networkdata.dbo.[Directory Roster Template] as roster

update networkdata.dbo.[Directory Roster Template]
set Office_Hours =
replace(replace(replace(replace(replace(replace(replace(Office_Hours,'Monday ,',''), 'Tuesday ,',''), 'Wednesday ,',''), 'Thursday ,',''), 'Friday ,',''), 'Saturday ,',''), 'Sunday','')
from networkdata.dbo.[Directory Roster Template]

UPDATE networkdata.dbo.[Directory Roster Template]
set Office_Hours =
CONCAT([Office_Hours],',,') 

UPDATE networkdata.dbo.[Directory Roster Template]
set Office_Hours =
REPLACE(REPLACE([Office_Hours],', ,,',''),',,','')

UPDATE networkdata.dbo.[Directory Roster Template]
set Office_Hours = null
where Office_Hours in ('Monday -,Tuesday -,Wednesday -,Thursday -,Friday -,Saturday -')

update networkdata.dbo.[Directory Roster Template]
set Office_Hours = 'Inpatient Only'
where (Office_Hours like '%Inpatient%' or Office_Hours like '%Emergency%') 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)

update networkdata.dbo.[Directory Roster Template]
set Office_Hours = 'Suppress from directory'
where Office_Hours like '%Suppress%' 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)

update networkdata.dbo.[Directory Roster Template]
set Office_Hours = 'Appointment Only'
where Office_Hours like '%Appointment%' 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)

update networkdata.dbo.[Directory Roster Template]
set Office_Hours = 'Covering Only'
where Office_Hours like '%Covering%' 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)

-----------------------Cleans speciallty names

UPDATE t1
  SET t1.Specialty = t2.[Directory Specialty],
	  t1.Sub_Specialty=t2.[Directory sub Specialty]
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.[Old_Specialty] = t2.[Primary Specialty] and t1.Degree = t2.Degree	
  where [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)

UPDATE t1
  SET t1.[Old_Specialty] = t2.[Roster Specialty]
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.[Old_Specialty] = t2.[Primary Specialty] and t1.Degree = t2.Degree	
  where [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)


-- Populate Category to directory format

update dir
	set dir.Category = zdis.Category
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Old_Specialty=zdis.[Old Specialty]
	where dir.[Category] is null  and zdis.Category not in ('PCP')
	and
	zdis.[Old Specialty] not in 
	('Geriatric Medicine', 
					'Internal Medicine', 
					'Family Medicine', 
					'Adult Health - Nurse Practitioner', 
					'Family Health - Nurse Practitioner', 
					'General Practice',
					'Gerontology - Nurse Practitioner','Family Practice') 
	and 
	dir.[Old_Specialty] not in 
	('Geriatric Medicine', 
					'Internal Medicine', 
					'Family Medicine', 
					'Adult Health - Nurse Practitioner', 
					'Family Health - Nurse Practitioner', 
					'General Practice',
					'Gerontology - Nurse Practitioner','Family Practice') 
		and
	zdis.[Specialty] not in 
	('Geriatric Medicine', 
					'Internal Medicine', 
					'Family Medicine', 
					'Adult Health - Nurse Practitioner', 
					'Family Health - Nurse Practitioner', 
					'General Practice',
					'Gerontology - Nurse Practitioner','Family Practice') 
	and 
	dir.[Specialty] not in 
	('Geriatric Medicine', 
					'Internal Medicine', 
					'Family Medicine', 
					'Adult Health - Nurse Practitioner', 
					'Family Health - Nurse Practitioner', 
					'General Practice',
					'Gerontology - Nurse Practitioner','Family Practice') 
	and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)


-- this query to to update any UDC designated PCP, but does not have PCP specialty to Specialist in directory format.

update networkdata.dbo.[Directory Roster Template]
	set Category='Specialist'
	where [Old_Specialty] not in ('Geriatric Medicine', 
					'Internal Medicine', 
					'Family Medicine', 
					'Adult Health - Nurse Practitioner', 
					'Family Health - Nurse Practitioner', 
					'General Practice',
					'Gerontology - Nurse Practitioner','Family Practice', 'Internal Medicine')  and
		  [Old_Specialty] not like ('%Adult%') and [Old_Specialty] not like ('%Family%')
		  and [Old_Specialty] not like ('%Gerontology%') and [Old_Specialty] not like ('%Geriatric%') 
		  and Category in ('PCP','Both','Dual', 'PCP and Specialist')  and  [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)


	-- Language 
update networkdata.dbo.[Directory Roster Template]
set [Language]=replace([Language],',,',',')
where [Language] like ('%,,%')

------------------- clean street address --------

   UPDATE t1
  SET t1.Address_2 = t2.Roster_Directory_Address_2_Format
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.STREET_ADDRESS = t2.Original_Address
  where t1.Address_2 is null

  UPDATE t1
  SET t1.STREET_ADDRESS = t2.Roster_Directory_Address_Format
  FROM networkdata.dbo.[Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.STREET_ADDRESS = t2.Original_Address

  Update networkdata.dbo.[Directory Roster Template] 
  set Accesibility = 'Y' where Accesibility = 'Yes'

  Update networkdata.dbo.[Directory Roster Template] 
  set Accesibility = 'N' where Accesibility = 'No'

  Update networkdata.dbo.[Directory Roster Template] 
  set Accepting_New_Patients = 'Y' where Accepting_New_Patients in  ('Yes','Open')

  Update networkdata.dbo.[Directory Roster Template] 
  set Accepting_New_Patients = 'N' where Accepting_New_Patients in ('No','Close')
 
  Update networkdata.dbo.[Directory Roster Template] 
  set [Board_Certified_Primary_Specialty] = 'Y' where [Board_Certified_Primary_Specialty] in ('Certified', 'Board Certified','Y','Yes','Boarded')

  Update networkdata.dbo.[Directory Roster Template] 
  set [Board_Certified_Primary_Specialty] = 'N' where [Board_Certified_Primary_Specialty] in ('Eligible', 'Board Eligible', 'Not Board Certified','E','N','No','Not Applicable','Qualified', 'In Process' )

  Update networkdata.dbo.[Directory Roster Template] 
  set Print_in_Directory = 'Y' where Print_in_Directory = 'Yes'

  Update networkdata.dbo.[Directory Roster Template] 
  set Accepting_New_Patients = 'N' where Print_in_Directory = 'No'

  update NetworkData.dbo.[Directory Roster Template]
  set [Accesibility] = null
  where [Accesibility] = 'nan'

UPDATE networkdata.dbo.[Directory Roster Template]
SET [Billing_Zip] = LEFT([Billing_Zip],5)

UPDATE networkdata.dbo.[Directory Roster Template]
SET [Billing_Zip_Extension] = NULL
WHERE [Billing_Zip_Extension] IN ('nan')


  update networkdata.dbo.[Directory Roster Template]
  set [TTYDisable_Svcs] = 'Y'
  where [TTYDisable_Svcs] = 'Yes'


  UPDATE networkdata.dbo.[Directory Roster Template]
SET [DEA_Number] = NULL
WHERE [DEA_Number] IN ('Waiver','NAN','nan','TEMP','TEMPORARY')

UPDATE networkdata.dbo.[Directory Roster Template]
SET [Print_in_Directory] = 'N'
WHERE [Print_in_Directory] IN ('No')

UPDATE networkdata.dbo.[Directory Roster Template]
SET [Print_in_Directory] = 'Y'
WHERE [Print_in_Directory] IN ('Yes')

  -------------- update directory flags BY  Print_in_Directory, PHONE NUMBER and Office Hours

update networkdata.dbo.[Directory Roster Template] 
	set MLTC='N', 
		MAPD='N',
		FIDA='N',
		MAP='N',
		ISNP='N',
		DSNP='N'
	WHERE Print_in_Directory IN ('N') or Phone_Number is null or Office_Hours like ('%Covering%') or Office_Hours like ('%Appointment%')

			or Office_Hours like ('%Inpatient%') or Office_Hours like ('%Suppress%') or Office_Hours like ('%Emergency%')

-- directory flag by LOB

update networkdata.dbo.[Directory Roster Template] 
	set MLTC='N'
	where Contract_MLTC in ('N') and MLTC is null

update networkdata.dbo.[Directory Roster Template] 
	set MAP='N'
	where Contract_MAP in ('N') and MAP is null

update networkdata.dbo.[Directory Roster Template] 
	set MAPD='N'
	where Contract_MAPD in ('N') and MAPD IS NULL

update networkdata.dbo.[Directory Roster Template] 
	set ISNP='N'
	where Contract_ISNP in ('N') AND ISNP IS NULL

update networkdata.dbo.[Directory Roster Template] 
	set DSNP='N'
	where Contract_DSNP in ('N') AND DSNP IS NULL

-- directory flag by LOB

update networkdata.dbo.[Directory Roster Template] 
	set MLTC='N'
	where County not in ('Kings', 'Queens','Richmond','New York','Bronx','Nassau','Suffolk','Westchester','Rockland','Niagara','Erie') and MLTC is null

update networkdata.dbo.[Directory Roster Template] 
	set MAP='N'
	where County not in ('Kings', 'Queens','Richmond','New York','Bronx','Nassau','Rockland') and MAP is null

update networkdata.dbo.[Directory Roster Template] 
	set MAPD='N'
	where County not in ('Kings', 'Queens','Richmond','New York','Bronx','Nassau','Rockland','Niagara','Erie') and MAPD is null

update networkdata.dbo.[Directory Roster Template] 
	set ISNP='N'
	where County not in ('Kings', 'Queens','Richmond','New York','Bronx','Nassau','Suffolk','Westchester','Rockland','Niagara','Erie') and ISNP is null

update networkdata.dbo.[Directory Roster Template] 
	set DSNP='N'
	where County not in ('Kings', 'Queens','Richmond','New York','Bronx') and DSNP IS NULL

-- directory flag: Suppress by service county

update networkdata.dbo.[Directory Roster Template] 
	set MLTC='N'
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join  networkdata.[dbo].[Z_Directory_indicator_County] as zdic
	on dir.County=zdic.County
	where zdic.MLTC in ('N') and dir.MLTC is null

update networkdata.dbo.[Directory Roster Template] 
	set MAPD='N'
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join  networkdata.[dbo].[Z_Directory_indicator_County] as zdic
	on dir.County=zdic.County
	where zdic.MAPD in ('N') and dir.MAPD is null

update networkdata.dbo.[Directory Roster Template] 
	set MAP='N'
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join  networkdata.[dbo].[Z_Directory_indicator_County] as zdic
	on dir.County=zdic.County
	where zdic.MAP in ('N') and dir.MAP is null

update networkdata.dbo.[Directory Roster Template] 
	set DSNP='N'
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join  networkdata.[dbo].[Z_Directory_indicator_County] as zdic
	on dir.County=zdic.County
	where zdic.DSNP in ('N') and dir.DSNP is null

update networkdata.dbo.[Directory Roster Template] 
	set ISNP='N'
	from networkdata.dbo.[Directory Roster Template] as dir
	inner join  networkdata.[dbo].[Z_Directory_indicator_County] as zdic
	on dir.County=zdic.County
	where zdic.ISNP in ('N') and dir.ISNP is null

-- Suppress FIDA directory flag

update networkdata.dbo.[Directory Roster Template] 
	set FIDA='N'

/* 
	---------------
	The queries below is to update directory flags by Specialty for Specialist only
	and some PCPs, these PCP must be categorized by each UDC on monthly roster submission,
	for any UDC that does not categoried provider type, we will have to update it manually before assigning directory flag by specialty
	-----

	*/


-- Update directory flag by Specialty _ Specialist Only

update networkdata.dbo.[Directory Roster Template] 
	set MLTC=zdis.[Medicaid Print in directory]
	from networkdata.dbo.[Directory Roster Template]  as dir
		inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Category=zdis.Category and dir.Old_Specialty=zdis.[Old Specialty] and dir.[Specialty] = zdis.[Specialty]
	where dir.MLTC is null

update networkdata.dbo.[Directory Roster Template] 
	set MAPD=zdis.[Print in Direcoty_Medicare]
	from networkdata.dbo.[Directory Roster Template]  as dir
		inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Category=zdis.Category and dir.Old_Specialty=zdis.[Old Specialty] and dir.[Specialty] = zdis.[Specialty]
	where dir.MAPD is null

update networkdata.dbo.[Directory Roster Template] 
	set MAP=zdis.[Print in Direcoty_Medicare]
	from networkdata.dbo.[Directory Roster Template]  as dir
		inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Category=zdis.Category and dir.Old_Specialty=zdis.[Old Specialty] and dir.[Specialty] = zdis.[Specialty]
	where dir.MAP is null

update networkdata.dbo.[Directory Roster Template] 
	set ISNP=zdis.[Print in Direcoty_Medicare]
	from networkdata.dbo.[Directory Roster Template]  as dir
		inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Category=zdis.Category and dir.Old_Specialty=zdis.[Old Specialty] and dir.[Specialty] = zdis.[Specialty]
	where dir.ISNP is null

update networkdata.dbo.[Directory Roster Template] 
	set DSNP=zdis.[Print in Direcoty_Medicare]
	from networkdata.dbo.[Directory Roster Template]  as dir
		inner join networkdata.[dbo].[Z_Directory Indicator Specialty] as zdis
	on dir.Category=zdis.Category and dir.Old_Specialty=zdis.[Old Specialty] and dir.[Specialty] = zdis.[Specialty]
	where dir.DSNP is null

  -------------- update directory flags BY  billing NPI for BXCA providers

update networkdata.dbo.[Directory Roster Template] 
	set MLTC='N', 
		MAPD='N',
		MAP='N',
		ISNP='N',
		DSNP='N'
	WHERE UDC IN ('BXCA') and Billing_NPI not in ('1548310758') and TIN in ('131974191')
		and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line

/* -------------
		Updating phone number and fax number 
		to (000) 000 - 0000
		-----------------------*/

  UPDATE networkdata.dbo.[Directory Roster Template]
	SET [phone_Number] =  '(' +  
						SUBSTRING([phone_Number], 1, 3) 
						+ ') ' 
						 +
						SUBSTRING([phone_Number], 4, 3) 
						+ ' - ' +
						SUBSTRING([phone_Number], 7, 4)
		where [phone_Number] is not null

 UPDATE networkdata.dbo.[Directory Roster Template]
	SET [Fax_Number] =  '(' +  
						SUBSTRING([Fax_Number], 1, 3) 
						+ ') ' 
						 +
						SUBSTRING([Fax_Number], 4, 3) 
						+ ' - ' +
						SUBSTRING([Fax_Number], 7, 4)
		where [Fax_Number] is not null

update  networkdata.dbo.[Directory Roster Template]
set Site_Name = null
where Site_Name in ('nan')

select * from networkdata.dbo.[Directory Roster Template]
where [Date Processed] in (select distinct [GV_Date] from ##GlobalVariable) 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.

/*
  delete from networkdata.dbo.[Directory Roster Template]
  where [Date Processed] in (select distinct [GV_Date] from ##GlobalVariable) 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.
*/

/* ---------------
	Drop global here

	--------------- */

Drop Table ##GlobalVariable



