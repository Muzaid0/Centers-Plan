

/* -------------------------------

-- Create table to store global variable
-- ##GlobalVariable is the table to store global value - [GV_Date] and [GV_RosterID]
-- [GV_Date] is global value of date
-- [GV_RosterID] is global value of roster ID

*/

CREATE TABLE ##GlobalVariable (GV_RosterID varchar(255), GV_Date varchar(255), GV_UDC varchar(255))  
INSERT INTO ##GlobalVariable VALUES ('R-2649', '7/18/2024','NWEL')  -- enter Roster tracking ID, Date, UDC here at this line.
select * from ##GlobalVariable

/*
select * from networkdata.dbo.[Nwel Roster] where [Roster_ID] in ('R-2649')
select * from networkdata.dbo.[Bulk Terms Template] where rosterid in ('R-2649')
select * from networkdata.dbo.[PDM ADDS TEMPLATE] where rosterid in ('R-2649')
select * from networkdata.dbo.[Directory Roster Template] where [Roster ID] in ('R-2649')
Drop Table ##GlobalVariable
*/
/*
--------------------------------------
*/

-------Gets rid of 'NAN'

update networkdata.dbo.[Nwel Roster]
set Effective_Date = null
where Effective_Date = 'nan'

update networkdata.dbo.[Nwel Roster]
set Termination_Date = null
where Termination_Date = 'nan'

update networkdata.dbo.[Nwel Roster]
set Provider_Type_PCP_Specialist_Both = null
where Provider_Type_PCP_Specialist_Both = 'nan'

update networkdata.dbo.[Nwel Roster]
set NPI = null
where NPI = 'nan'

update networkdata.dbo.[Nwel Roster]
set Middle_Initial = null
where Middle_Initial = 'nan'

update networkdata.dbo.[Nwel Roster]
set Secondary_Specialty = null
where Secondary_Specialty = 'nan'

update networkdata.dbo.[Nwel Roster]
set Board_Certified_Y_N_2 = null
where Board_Certified_Y_N_2 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Specialty_3 = null
where Specialty_3 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Specialty_4 = null
where Specialty_4 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_1 = ltrim(rtrim([Language_1]))

update networkdata.dbo.[Nwel Roster]
set Language_2 = ltrim(rtrim([Language_2]))

update networkdata.dbo.[Nwel Roster]
set Language_3 = ltrim(rtrim([Language_3]))

update networkdata.dbo.[Nwel Roster]
set Language_4 = ltrim(rtrim([Language_4]))

update networkdata.dbo.[Nwel Roster]
set Language_5 = ltrim(rtrim([Language_5]))

update networkdata.dbo.[Nwel Roster]
set Language_1 = null
where Language_1 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_2 = null
where Language_2 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_3 = null
where Language_3 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_4 = null
where Language_4 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_5 = null
where Language_5 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_1 = null
where Language_1 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_2 = null
where Language_2 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_3 = null
where Language_3 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_4 = null
where Language_4 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_5 = null
where Language_5 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Language_1 = null
where Language_1 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_2 = null
where Language_2 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_3 = null
where Language_3 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_4 = null
where Language_4 = 'English'

update networkdata.dbo.[Nwel Roster]
set Language_5 = null
where Language_5 = 'English'

update networkdata.dbo.[Nwel Roster]
set
[Language_1] = CONCAT(Language_1,', ',Language_2,', ', Language_3,', ', Language_4,', ', Language_5) 
FROM networkdata.dbo.[Nwel Roster]
where [Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)    -- Roster tracking ID a
and [Date] in (select distinct [GV_Date] from ##GlobalVariable)         -- Date for roster

update networkdata.dbo.[Nwel Roster]
set [Language_1]=
replace(ltrim(rtrim(replace(replace(replace(replace([Language_1], ',', '><'), '<>', ''), '><', ','), ',', ' '))), ' ', ',')


update networkdata.dbo.[Nwel Roster]
set Room_or_Suite = null
where Room_or_Suite = 'nan'

update networkdata.dbo.[Nwel Roster]
set Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers = null
where Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers = 'nan'

update networkdata.dbo.[Nwel Roster]
set Tuesday_Provider_Office_Hours_00_00am_00_00pm = null
where Tuesday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Wednesday_Provider_Office_Hours_00_00am_00_00pm = null
where Wednesday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Thursday_Provider_Office_Hours_00_00am_00_00pm = null
where Thursday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Friday_Provider_Office_Hours_00_00am_00_00pm = null
where Friday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Saturday_Provider_Office_Hours_00_00am_00_00pm = null
where Saturday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Sunday_Provider_Office_Hours_00_00am_00_00pm = null
where Sunday_Provider_Office_Hours_00_00am_00_00pm = 'nan'

update networkdata.dbo.[Nwel Roster]
set Billing_Room_or_Suite = null
where Billing_Room_or_Suite = 'nan'

update networkdata.dbo.[Nwel Roster]
set Board_Expiration_Date2 = null
where Board_Expiration_Date2 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Board_Certified_Y_N_3 = null
where Board_Certified_Y_N_3 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Board_Expiration_Date3 = null
where Board_Expiration_Date3 = 'nan'

update networkdata.dbo.[Nwel Roster]
set Board_Certified_Y_N_4 = null
where Board_Certified_Y_N_4 = 'nan'


update networkdata.dbo.[Nwel Roster]
set Board_Expiration_Date4 = null
where Board_Expiration_Date4 = 'nan'

update networkdata.dbo.[Nwel Roster]
set E_mail_Address = null
where E_mail_Address = 'nan'

update networkdata.dbo.[Nwel Roster]
set Billing_County = null
where Billing_County = 'nan'

update networkdata.dbo.[Nwel Roster]
set Billing_E_mail_Address = null
where Billing_E_mail_Address = 'nan'

update networkdata.dbo.[Nwel Roster]
set Accepting_New_Patients_Y_N = null
where Accepting_New_Patients_Y_N = 'nan'

update networkdata.dbo.[Nwel Roster]
set Medicaid_ID = null
where Medicaid_ID in ( 'nan', 'N/A')

update networkdata.dbo.[Nwel Roster]
set Medicare_ID = null
where Medicare_ID in ( 'nan', 'N/A')

----------------PDM Adds

insert into networkdata.dbo.[PDM ADDS TEMPLATE]
(lastname,FirstName,MiddleInitial,Degree,Gender,NPI,MedicaidID,MedicareID,Address1,Address2,
City,[State],ZipCode,ZipCodeExtended,County,PrintInDirectory,AcceptingNewPatients,PrimarySpecialty,
SecondarySpecialty,TertiarySpecialty,QuaternarySpecialty,OfficePhone,OfficeFax,EmailAddress,
BillingNPI,BillingTIN,BillingName,BillingAddress1,BillingAddress2,BillingCity,BillingState,BillingZipCode,BillingZipCodeExtended,
BillingPhone,BillingFax,BillingEmail,EffectiveDate, [AffiliationAttribute], -- UDC
[rosterid], -- Roster ID
[ParIndicator], -- Par Ind
[Date Processed] -- Date
, [PrimaryLanguage] -- Language
, [PCPFlag]
)

select Last_Name,First_Name,Middle_Initial,Degree,Gender,NPI,Medicaid_ID,Medicare_ID,Street_Address,Room_or_Suite,City,[state],
Zip_Code,Zip_Code_Extended,County,Print_In_Directory_Y_N,Accepting_New_Patients_Y_N,Primary_Specialty,Secondary_Specialty,Specialty_3,Specialty_4,
Phone_Number,Fax_Number,E_mail_Address,Billing_NPI,TIN,Site_Name,Billing_Street_Address,Billing_Room_or_Suite,Billing_City,Billing_State,Billing_Zip_Code,Billing_Zip_Code_Extended,Billing_Phone_Number,
Billing_Fax_Number,Billing_E_mail_Address,Effective_Date,
'NWEL' as UDC, --UDC
[Roster_ID],
'Y' as [ParIndicator], -- 
(select distinct [GV_Date] from ##GlobalVariable) as [Date],
[Language_1],
case when [Provider_Type_PCP_Specialist_Both] in ('PCP','Both') then 'Y'
	when [Provider_Type_PCP_Specialist_Both] in ('Specialist') then null
	end as [Category]
from networkdata.dbo.[NWEL Roster] 
where (Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%new%') or 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%add%'))
and 
[Date] in (select distinct [GV_Date] from ##GlobalVariable) and         -- Date for roster
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)    -- Roster tracking ID 

----------------Bulk Terms

insert into networkdata.dbo.[Bulk Terms Template]
(TermType,TermDate,NPI,TIN,Billing_NPI,Address1,SpecialtyName, rosterid, NetworkCode, Created_Date)

select 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location,Termination_Date,NPI,TIN,Billing_NPI,Street_Address,Primary_Specialty, [Roster_ID], 'NWEL' as UDC, [Date]
from networkdata.dbo.[NWEL Roster]
where Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%term%') and
[Date] in (select distinct [GV_Date] from ##GlobalVariable) and           -- Date for roster
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)    -- Roster tracking ID a


-----------------Directory Format

insert into networkdata.dbo.[Directory Roster Template]
(print_in_directory,Specialty,County,NPI,FNAME,MNAME,LNAME,STREET_ADDRESS,Address_2,City,
[state],Zip_code,Extended_Zip,Phone_Number,Fax_Number,TTYDisable_Svcs,Site_Name,Accepting_New_Patients
,Accesibility,Board_Certified_Primary_Specialty,License,MEDICAID_ID,Gender,Degree,TIN,Medicare_ID,
Billing_NPI,Group_Name,Billing_Address,Billing_Address_2,Billing_City,Billing_State,Billing_Zip,
Billing_Zip_Extension,Effective_Date,Term_Date,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,Category, [Old_Specialty], [Roster ID], [Date Processed], [UDC], [Language])

select 
Print_In_Directory_Y_N,Primary_Specialty,County,NPI,First_Name,Middle_Initial,Last_Name,Street_Address,Room_or_Suite,
City,[state],Zip_Code,Zip_Code_Extended,Phone_Number,Fax_Number,TTY_Disable_Services_Y_N,Site_Name,Accepting_New_Patients_Y_N,
Wheelchair_Accessbility_Y_N,Board_Certified_Y_N,License_Number,Medicaid_ID,Gender,Degree,TIN,Medicare_ID,Billing_NPI,
Billing_Name,Billing_Street_Address,Billing_Room_or_Suite,Billing_City,Billing_State,Billing_Zip_Code,Billing_Zip_Code_Extended,Effective_Date,Termination_Date,Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers,
Tuesday_Provider_Office_Hours_00_00am_00_00pm,Wednesday_Provider_Office_Hours_00_00am_00_00pm,Thursday_Provider_Office_Hours_00_00am_00_00pm,Friday_Provider_Office_Hours_00_00am_00_00pm,Saturday_Provider_Office_Hours_00_00am_00_00pm,
Sunday_Provider_Office_Hours_00_00am_00_00pm,Provider_Type_PCP_Specialist_Both, [Primary_Specialty] as [Old_Specialty], [Roster_ID], [Date], 'NWEL' as [UDC], [Language_1]
from networkdata.dbo.[NWEL Roster]
where 
(Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%new%') or 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%add%')) and 
[Date] in (select distinct [GV_Date] from ##GlobalVariable)  and 
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.

union 

select 
Print_In_Directory_Y_N,[Secondary_Specialty],County,NPI,First_Name,Middle_Initial,Last_Name,Street_Address,Room_or_Suite,
City,[state],Zip_Code,Zip_Code_Extended,Phone_Number,Fax_Number,TTY_Disable_Services_Y_N,Site_Name,Accepting_New_Patients_Y_N,
Wheelchair_Accessbility_Y_N,Board_Certified_Y_N_2,License_Number,Medicaid_ID,Gender,Degree,TIN,Medicare_ID,Billing_NPI,
Billing_Name,Billing_Street_Address,Billing_Room_or_Suite,Billing_City,Billing_State,Billing_Zip_Code,Billing_Zip_Code_Extended,Effective_Date,Termination_Date,Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers,
Tuesday_Provider_Office_Hours_00_00am_00_00pm,Wednesday_Provider_Office_Hours_00_00am_00_00pm,Thursday_Provider_Office_Hours_00_00am_00_00pm,Friday_Provider_Office_Hours_00_00am_00_00pm,Saturday_Provider_Office_Hours_00_00am_00_00pm,
Sunday_Provider_Office_Hours_00_00am_00_00pm,Provider_Type_PCP_Specialist_Both, [Secondary_Specialty] as [Old_Specialty], [Roster_ID], [Date], 'NWEL' as [UDC], [Language_1]

from networkdata.dbo.[NWEL Roster]
where [Secondary_Specialty] is not null and
(Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%new%') or 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%add%')) and 
[Date] in (select distinct [GV_Date] from ##GlobalVariable)  and 
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.

union

select 
Print_In_Directory_Y_N,[Specialty_3],County,NPI,First_Name,Middle_Initial,Last_Name,Street_Address,Room_or_Suite,
City,[state],Zip_Code,Zip_Code_Extended,Phone_Number,Fax_Number,TTY_Disable_Services_Y_N,Site_Name,Accepting_New_Patients_Y_N,
Wheelchair_Accessbility_Y_N,Board_Certified_Y_N_3,License_Number,Medicaid_ID,Gender,Degree,TIN,Medicare_ID,Billing_NPI,
Billing_Name,Billing_Street_Address,Billing_Room_or_Suite,Billing_City,Billing_State,Billing_Zip_Code,Billing_Zip_Code_Extended,Effective_Date,Termination_Date,Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers,
Tuesday_Provider_Office_Hours_00_00am_00_00pm,Wednesday_Provider_Office_Hours_00_00am_00_00pm,Thursday_Provider_Office_Hours_00_00am_00_00pm,Friday_Provider_Office_Hours_00_00am_00_00pm,Saturday_Provider_Office_Hours_00_00am_00_00pm,
Sunday_Provider_Office_Hours_00_00am_00_00pm,Provider_Type_PCP_Specialist_Both, [Specialty_3] as [Old_Specialty], [Roster_ID], [Date], 'NWEL' as [UDC], [Language_1]
from networkdata.dbo.[NWEL Roster]
where [Specialty_3] is not null and
(Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%new%') or 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%add%')) and 
[Date] in (select distinct [GV_Date] from ##GlobalVariable)  and  
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.

union

select 
Print_In_Directory_Y_N,[Specialty_4],County,NPI,First_Name,Middle_Initial,Last_Name,Street_Address,Room_or_Suite,
City,[state],Zip_Code,Zip_Code_Extended,Phone_Number,Fax_Number,TTY_Disable_Services_Y_N,Site_Name,Accepting_New_Patients_Y_N,
Wheelchair_Accessbility_Y_N,Board_Certified_Y_N_4,License_Number,Medicaid_ID,Gender,Degree,TIN,Medicare_ID,Billing_NPI,
Billing_Name,Billing_Street_Address,Billing_Room_or_Suite,Billing_City,Billing_State,Billing_Zip_Code,Billing_Zip_Code_Extended,Effective_Date,Termination_Date,Monday_Provider_Office_Hours_00_00am_00_00pm_State_Covering_for_any_covering_providers,
Tuesday_Provider_Office_Hours_00_00am_00_00pm,Wednesday_Provider_Office_Hours_00_00am_00_00pm,Thursday_Provider_Office_Hours_00_00am_00_00pm,Friday_Provider_Office_Hours_00_00am_00_00pm,Saturday_Provider_Office_Hours_00_00am_00_00pm,
Sunday_Provider_Office_Hours_00_00am_00_00pm,Provider_Type_PCP_Specialist_Both, [Specialty_4] as [Old_Specialty], [Roster_ID], [Date], 'NWEL' as [UDC], [Language_1]
from networkdata.dbo.[NWEL Roster]
where [Specialty_4] is not null and
(Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%new%') or 
Addition_Termination_new_provider_new_location_terminate_provider_terminate_location like ('%add%')) and 
[Date] in (select distinct [GV_Date] from ##GlobalVariable)  and 
[Roster_ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.


/* ---------------
	Drop global here

	--------------- */

Drop Table ##GlobalVariable

/*
select * from networkdata.dbo.[Bulk Terms Template] where rosterid in ('R-2649')
select * from networkdata.dbo.[PDM ADDS TEMPLATE] where rosterid in ('R-2649')
select * from networkdata.dbo.[Directory Roster Template] where [Roster ID] in ('R-2649')
*/