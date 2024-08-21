INSERT INTO [CCM Directory Roster Template] (Print_in_Directory,NPI,STREET_ADDRESS,Address_2,City,State,Zip_code,Accepting_New_Patients,County,Phone_Number,Fax_Number,TIN,Effective_Date,PROVIDER_FULL_NAME,Extended_Zip)
SELECT b.PRINT_IN_DIRECTORY,PROVIDER_NPI_NUMBER,ADDRESS,ROOM_OR_SUITE,b.CITY,b.STATE,ZIP,ACCEPTS_NEW_PATIENTS,b.County,b.Phone_Number,b.Fax_Number,TAX_ID,b.Effective_Date,PROVIDER_NAME,SUBSTRING(ZIP,7,4) FROM [CCM REPORT] as b
LEFT JOIN [CCM Directory Roster Template] ON [CCM Directory Roster Template].NPI = b.PROVIDER_NPI_NUMBER
WHERE PROVIDER_TYPE = '1' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress','Primary Address')

UPDATE [CCM Directory Roster Template]
SET [CCM Directory Roster Template].MLTC = [CCM REPORT].MLTC,
[CCM Directory Roster Template].MAPD = [CCM REPORT].MAPD,
[CCM Directory Roster Template].FIDA = [CCM REPORT].FIDA,
[CCM Directory Roster Template].MAP = [CCM REPORT].MAP,
[CCM Directory Roster Template].ISNP = [CCM REPORT].I_SNP,
[CCM Directory Roster Template].DSNP = [CCM REPORT].D_SNP
FROM [CCM REPORT] 
LEFT JOIN [CCM Directory Roster Template] ON
[CCM Directory Roster Template].NPI = [CCM REPORT].PROVIDER_NPI_NUMBER
WHERE PROVIDER_TYPE = '1' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress')

UPDATE [CCM Directory Roster Template]
SET [CCM Directory Roster Template].Contract_MLTC = [CCM REPORT].MLTC,
[CCM Directory Roster Template].Contract_MAPD = [CCM REPORT].MAPD,
[CCM Directory Roster Template].Contract_FIDA = [CCM REPORT].FIDA,
[CCM Directory Roster Template].Contract_MAP = [CCM REPORT].MAP,
[CCM Directory Roster Template].Contract_ISNP = [CCM REPORT].I_SNP,
[CCM Directory Roster Template].Contract_DSNP = [CCM REPORT].D_SNP
FROM [CCM REPORT] 
LEFT JOIN [CCM Directory Roster Template] ON
[CCM Directory Roster Template].NPI = [CCM REPORT].PROVIDER_NPI_NUMBER
WHERE PROVIDER_TYPE = '1' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress')

UPDATE [CCM Directory Roster Template]
SET [CCM Directory Roster Template].License = [CCM REPORT_INFORMATION NEEDED].LICENSE_NUMBER,
[CCM Directory Roster Template].Specialty = [CCM REPORT_INFORMATION NEEDED].PROVIDER_SPECIALTIES_DESCRIPTION,
[CCM Directory Roster Template].Board_Certified_Primary_Specialty = [CCM REPORT_INFORMATION NEEDED].BOARD_STATUS,
[CCM Directory Roster Template].Gender = [CCM REPORT_INFORMATION NEEDED].PROVIDERS_GENDER,
[CCM Directory Roster Template].Degree = [CCM REPORT_INFORMATION NEEDED].PROVIDERS_DEGREE_S_DISPLAY_ONLY,
[CCM Directory Roster Template].FNAME = [CCM REPORT_INFORMATION NEEDED].PROVIDERS_FIRST_NAME,
[CCM Directory Roster Template].LNAME = [CCM REPORT_INFORMATION NEEDED].PROVIDERS_LAST_NAME
FROM [CCM REPORT_INFORMATION NEEDED] 
LEFT JOIN [CCM Directory Roster Template] ON
[CCM Directory Roster Template].NPI = [CCM REPORT_INFORMATION NEEDED].PROVIDERS_NPI

UPDATE [CCM Directory Roster Template]
SET STREET_ADDRESS = [CCM Report].ADDRESS,
PROVIDER_FULL_NAME = [CCM Report].Provider_Name,
Address_2 = [CCM Report].ROOM_OR_SUITE,
City = [CCM Report].CITY,
State = [CCM Report].STATE,
Zip_code = [CCM Report].ZIP,
NPI = [CCM Report].PROVIDER_NPI_NUMBER,
Extended_Zip = SUBSTRING([CCM Report].ZIP,7,4)
FROM [CCM Report] 
LEFT JOIN [CCM Directory Roster Template] ON
TIN = [CCM Report].TAX_ID
WHERE PROVIDER_ADDRESS_TYPE = 'BILLING ADDRESS'

UPDATE [CCM Directory Roster Template]
SET Zip_code = LEFT(Zip_code, CHARINDEX('-', Zip_code) - 1)
WHERE CHARINDEX('-', Zip_code) > 0

UPDATE [CCM Directory Roster Template]
SET Billing_Zip = LEFT(Billing_Zip, CHARINDEX('-', Billing_Zip) - 1)
WHERE CHARINDEX('-', Billing_Zip) > 0

UPDATE [CCM Directory Roster Template]
SET PROVIDER_FULL_NAME = LEFT(PROVIDER_FULL_NAME, CHARINDEX(',', PROVIDER_FULL_NAME) - 1)
WHERE CHARINDEX(',', PROVIDER_FULL_NAME) > 0

UPDATE
    [CCM Directory Roster Template]
SET 
  Print_in_Directory = CASE WHEN Print_in_Directory = 'TRUE' THEN 'Y' 
  WHEN Print_in_Directory = 'PRINT IN DIRECTORY' THEN 'PRINT IN DIRECTORY'
  ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
  Accepting_New_Patients = CASE WHEN Accepting_New_Patients = 'TRUE' THEN 'Y' 
  WHEN Accepting_New_Patients = 'ACCEPTING NEW PATIENTS' THEN 'ACCEPTING NEW PATIENTS'
  ELSE 'N' END

UPDATE 
[CCM Directory Roster Template]
SET
Board_Certified_Primary_Specialty = CASE WHEN Board_Certified_Primary_Specialty = 'BOARD CERTIFIED' THEN 'Y' 
  WHEN Board_Certified_Primary_Specialty = '%ACTIVE%' THEN 'Y'
  WHEN Board_Certified_Primary_Specialty = 'BOARD CERTIFIED PRIMARY SPECIALTY' THEN 'BOARD CERTIFIED PRIMARY SPECIALTY'
  ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
TIN = REPLACE(TIN, '-','')  

UPDATE
    [CCM Directory Roster Template]
SET 
MLTC = CASE WHEN MLTC = 'MLTC' THEN 'MLTC'
WHEN MLTC IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
MAPD = CASE WHEN MAPD = 'MAPD' THEN 'MAPD'
WHEN MAPD IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
FIDA = CASE WHEN FIDA = 'FIDA' THEN 'FIDA'
WHEN FIDA IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
MAP = CASE WHEN MAP = 'MAP' THEN 'MAP'
WHEN MAP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
ISNP = CASE WHEN ISNP = 'ISNP' THEN 'ISNP'
WHEN ISNP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
DSNP = CASE WHEN DSNP = 'DSNP' THEN 'DSNP'
WHEN DSNP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_MLTC = CASE WHEN Contract_MLTC = 'MLTC' THEN 'MLTC'
WHEN Contract_MLTC IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_MAPD = CASE WHEN Contract_MAPD = 'MAPD' THEN 'MAPD'
WHEN Contract_MAPD IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_FIDA = CASE WHEN Contract_FIDA = 'FIDA' THEN 'FIDA'
WHEN Contract_FIDA IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_MAP = CASE WHEN Contract_MAP = 'MAP' THEN 'MAP'
WHEN Contract_MAP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_ISNP = CASE WHEN Contract_ISNP = 'ISNP' THEN 'ISNP'
WHEN Contract_ISNP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Directory Roster Template]
SET 
Contract_DSNP = CASE WHEN Contract_DSNP = 'DSNP' THEN 'DSNP'
WHEN Contract_DSNP IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE t1
  SET t1.Specialty = t2.[Primary Specialty]
  FROM [CCM Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.Specialty = t2.[Directory Specialty]

UPDATE t1

  SET t1.Specialty = t2.[Primary Specialty]
  FROM [CCM Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.Sub_Specialty = t2.[Directory sub Specialty]

/* For Facilities Only */

insert into [CCM Facility Directory Roster Template]
(NPI,STREET_ADDRESS,Address_2,City,State,Zip_code,Accepting_New_Patients,County,PhoneNumber,FaxNumber,TIN,Effective_Date,PROVIDER_FULL_NAME,Plus_4,Site_Name)
SELECT PROVIDER_NPI_NUMBER,ADDRESS,ROOM_OR_SUITE,b.City,b.State,ZIP,ACCEPTS_NEW_PATIENTS,b.County,PHONE_NUMBER,FAX_NUMBER,TAX_ID,b.Effective_Date,PROVIDER_NAME,SUBSTRING(ZIP,7,4),Provider_Name FROM [CCM Report] as b
LEFT JOIN [CCM Facility Directory Roster Template] ON [CCM Facility Directory Roster Template].NPI = b.Provider_NPI_Number
WHERE PROVIDER_TYPE = '2' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress')
 
UPDATE [CCM Facility Directory Roster Template]
SET STREET_ADDRESS = [CCM Report].ADDRESS,
PROVIDER_FULL_NAME = [CCM Report].Provider_Name,
Address_2 = [CCM Report].ROOM_OR_SUITE,
City = [CCM Report].CITY,
State = [CCM Report].STATE,
Zip_code = [CCM Report].ZIP,
NPI = [CCM Report].PROVIDER_NPI_NUMBER,
PhoneNumber = [CCM Report].Phone_Number,
FaxNumber = [CCM Report].Fax_Number,
Billing_Zip_Extension = SUBSTRING([CCM Report].ZIP,7,4)
FROM [CCM Report] 
LEFT JOIN [CCM Facility Directory Roster Template] ON
TIN = [CCM Report].TAX_ID
WHERE PROVIDER_ADDRESS_TYPE = 'BILLING ADDRESS'
 
UPDATE [CCM Facility Directory Roster Template]
SET MLTC_Contract = [CCM Report].MLTC,
MAPD_Contract = [CCM Report].MAPD,
FIDA_Contract = [CCM Report].FIDA,
MAP_Contract = [CCM Report].MAP,
ISNP_Contract = [CCM Report].I_SNP,
DSNP_Contract = [CCM Report].D_SNP
FROM [CCM Report] 
LEFT JOIN [CCM Facility Directory Roster Template] ON
[CCM Facility Directory Roster Template].NPI = [CCM Report].PROVIDER_NPI_NUMBER
WHERE PROVIDER_TYPE = '2' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress')

UPDATE [CCM Facility Directory Roster Template]
SET MLTC_Directory = [CCM Report].MLTC,
MAPD_Directory = [CCM Report].MAPD,
FIDA_Directory = [CCM Report].FIDA,
MAP_Directory = [CCM Report].MAP,
ISNP_Directory = [CCM Report].I_SNP,
DSNP_Directory = [CCM Report].D_SNP
FROM [CCM Report] 
LEFT JOIN [CCM Facility Directory Roster Template] ON
[CCM Facility Directory Roster Template].NPI = [CCM Report].PROVIDER_NPI_NUMBER
WHERE PROVIDER_TYPE = '2' AND PROVIDER_ADDRESS_TYPE IN ('Primary Practice Location','ADDITIONAL PRACTICE LOCATION','Affiliated IPA -Primary Address','Affiliated IPA-AdditionalAddress')
 
UPDATE [CCM Facility Directory Roster Template]
SET Board_Certified_Primary_Specialty = [CCM report_Information Needed].Board_Status,
FNAME = [CCM report_Information Needed].Providers_First_Name,
LNAME = [CCM report_Information Needed].Providers_Last_Name,
License = [CCM report_Information Needed].License_Number
FROM [CCM report_Information Needed] 
LEFT JOIN [CCM Facility Directory Roster Template] ON
[CCM Facility Directory Roster Template].NPI = [CCM report_Information Needed].Providers_NPI
 
 UPDATE [CCM Facility Directory Roster Template]
SET Specialty = [CCM Report].Specialties
from [CCM Report]
LEFT JOIN [CCM Facility Directory Roster Template] ON
[CCM Facility Directory Roster Template].NPI = [CCM Report].Provider_NPI_Number

 
UPDATE [CCM Facility Directory Roster Template]
SET Zip_code = LEFT(Zip_code, CHARINDEX('-', Zip_code) - 1)
WHERE CHARINDEX('-', Zip_code) > 0
 
UPDATE [CCM Facility Directory Roster Template]
SET Billing_Zip = LEFT(Billing_Zip, CHARINDEX('-', Billing_Zip) - 1)
WHERE CHARINDEX('-', Billing_Zip) > 0
 
UPDATE [CCM Facility Directory Roster Template]
SET PROVIDER_FULL_NAME = LEFT(PROVIDER_FULL_NAME, CHARINDEX(',', PROVIDER_FULL_NAME) - 1)
WHERE CHARINDEX(',', PROVIDER_FULL_NAME) > 0
 
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
  Accepting_New_Patients = CASE WHEN Accepting_New_Patients = 'TRUE' THEN 'Y' 
  WHEN Accepting_New_Patients = 'ACCEPTING NEW PATIENTS' THEN 'ACCEPTING NEW PATIENTS'
  ELSE 'N' END
 
UPDATE 
[CCM Facility Directory Roster Template]
SET
Board_Certified_Primary_Specialty = CASE WHEN Board_Certified_Primary_Specialty = 'BOARD CERTIFIED' THEN 'Y' 
  WHEN Board_Certified_Primary_Specialty like ('%ACTIVE%') THEN 'Y'
  WHEN Board_Certified_Primary_Specialty like ('Board Certified') THEN 'Y'
  WHEN Board_Certified_Primary_Specialty is null THEN ' '
  WHEN Board_Certified_Primary_Specialty = 'BOARD CERTIFIED PRIMARY SPECIALTY' THEN 'BOARD CERTIFIED PRIMARY SPECIALTY'
  ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
TIN = REPLACE(TIN, '-','')  
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MLTC_Contract = CASE WHEN MLTC_Contract = 'MLTC - Contract' THEN 'MLTC - Contract'
WHEN MLTC_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAPD_Contract = CASE WHEN MAPD_Contract = 'MAPD - Contract' THEN 'MAPD - Contract'
WHEN MAPD_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
FIDA_Contract = CASE WHEN FIDA_Contract = 'FIDA - Contract' THEN 'FIDA - Contract'
WHEN FIDA_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAP_Contract = CASE WHEN MAP_Contract = 'MAP - Contract' THEN 'MAP - Contract'
WHEN MAP_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
ISNP_Contract = CASE WHEN ISNP_Contract = 'ISNP - Contract' THEN 'ISNP - Contract'
WHEN ISNP_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
DSNP_Contract = CASE WHEN DSNP_Contract = 'DSNP - Contract' THEN 'DSNP - Contract'
WHEN DSNP_Contract IS NOT NULL THEN 'Y'
ELSE 'N' END

UPDATE
    [CCM Facility Directory Roster Template]
SET 
MLTC_Directory = CASE WHEN MLTC_Directory = 'MLTC - Contract' THEN 'MLTC - Contract'
WHEN MLTC_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAPD_Directory = CASE WHEN MAPD_Directory = 'MAPD - Contract' THEN 'MAPD - Contract'
WHEN MAPD_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
FIDA_Directory = CASE WHEN FIDA_Directory = 'FIDA - Contract' THEN 'FIDA - Contract'
WHEN FIDA_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAP_Directory = CASE WHEN MAP_Directory = 'MAP - Contract' THEN 'MAP - Contract'
WHEN MAP_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
ISNP_Directory = CASE WHEN ISNP_Directory = 'ISNP - Contract' THEN 'ISNP - Contract'
WHEN ISNP_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
DSNP_Directory = CASE WHEN DSNP_Directory = 'DSNP - Contract' THEN 'DSNP - Contract'
WHEN DSNP_Directory IS NOT NULL THEN 'Y'
ELSE 'N' END


UPDATE
    [CCM Facility Directory Roster Template]
SET 
MLTC_Servicing_Counties = CASE WHEN MLTC_Contract = 'MLTC - Contract' THEN 'MLTC - Contract'
WHEN MLTC_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAPD_Servicing_Counties = CASE WHEN MAP_Contract = 'MAPD - Contract' THEN 'MAPD - Contract'
WHEN MAP_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END
 
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
FIDA_Servicing_Counties = CASE WHEN FIDA_Contract = 'FIDA - Contract' THEN 'FIDA - Contract'
WHEN FIDA_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END
 
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
MAP_Servicing_Counties = CASE WHEN MAP_Contract = 'MAP - Contract' THEN 'MAP - Contract'
WHEN MAP_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
ISNP_Servicing_Counties = CASE WHEN ISNP_Contract = 'ISNP - Contract' THEN 'ISNP - Contract'
WHEN ISNP_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END
 
UPDATE
    [CCM Facility Directory Roster Template]
SET 
DSNP_Servicing_Counties = CASE WHEN DSNP_Contract = 'DSNP - Contract' THEN 'DSNP - Contract'
WHEN DSNP_Contract = 'Y' THEN 'Bronx, Erie, Kings, Nassau, New York, Niagara, Queens, Richmond, Rockland, Suffolk, Westchester'
ELSE null END


UPDATE t1
  SET t1.Specialty = t2.[Primary Specialty]
  FROM [CCM Facility Directory Roster Template] AS t1
  INNER JOIN networkdata.dbo.[Roster Directory Specialty Clean up] AS t2
  ON t1.Specialty = t2.[Directory Specialty]



  select * from [CCM Directory Roster Template]
  select * from [CCM Facility Directory Roster Template]

