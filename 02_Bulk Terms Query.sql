


CREATE TABLE ##GlobalVariable (GV_RosterID varchar(255), GV_Date varchar(255), GV_UDC varchar(255))  
INSERT INTO ##GlobalVariable VALUES ('R-2647', '7/12/2024','SUDS')  -- enter Roster tracking ID, Date, UDC here at this line.
select * from ##GlobalVariable


/*
select * from networkdata.dbo.[Bulk Terms Template]
where rosterid in ('R-2643')

update networkdata.dbo.[Bulk Terms Template]
set
NetworkCode = 'NWEL' where Created_Date is null

UPDATE networkdata.dbo.[Bulk Terms Template]
SET Created_Date = GETDATE()
WHERE Created_Date IS NULL;
*/

UPDATE t1
  SET t1.SpecialtyName = t2.[Cleaned Specialty Name]
  FROM networkdata.dbo.[Bulk Terms Template] AS t1
  INNER JOIN networkdata.dbo.xref_specialties AS t2
  ON t1.SpecialtyName = t2.[Primary Specialty Name]

  UPDATE t1
  SET t1.Address1 = t2.Roster_Directory_Address_Format
  FROM networkdata.dbo.[Bulk Terms Template] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.Address1 = t2.Original_Address


update networkdata.dbo.[Bulk Terms Template]
set TIN = replace(TIN,'-','')
where TIN like '%-%'

/*
Update networkdata.dbo.[Bulk Terms Template]
set [rosterid] = 'R-2611'
where [rosterid] is null
[Date Processed] in (select distinct [GV_Date] from ##GlobalVariable) 
and [Roster ID] in (select distinct [GV_RosterID] from ##GlobalVariable)  -- enter Roster tracking ID and date here for this line.


*/

Update networkdata.dbo.[Bulk Terms Template]
set [Current] = case
                  when [rosterid] in (select distinct [GV_RosterID] from ##GlobalVariable) then 'Y'
                  else null end

/* ------------------
	Exporting Bulk Term file with Bulk term header 
	----------------------
	*/

  select case when [TermType] in ('Term Location', 'Terminate Location') then 'Location'
			  when [TermType] in ('Term Provider', 'Terminate Provider', 'Term', 'Term provider from TIN', 'Terminate Provider') then 'Provider' 
			  else [TermType]
			  end as [TermType],
	[TermDate],[NPI], [TIN], [Billing_NPI] as [BillingNPI], [Networkcode], [Address1],[SpecialtyName],[SubSpecialtyName], [Created_Date] as [Created Date]
  from networkdata.dbo.[Bulk Terms Template]
  where rosterid in (select distinct [GV_RosterID] from ##GlobalVariable) 
--  and [NetworkCode] in (select distinct [GV_UDC] from ##GlobalVariable) 


  /* ---------------
	Drop global here

	--------------- */

Drop Table ##GlobalVariable

