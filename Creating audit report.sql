--  **********************************************
-- this query created to run a audit report to randomly picking 80 providers in a monthly basis. Normally at lease 2 providers from UDC. 
-- All of the data are extracted from select * from [NetworkData].[dbo].[Directory for provider]
-- this table is a dynamic view of the provider directory with flags to it.
-- all of the results are append to 

/* 
1.	Network Data Management (“NDM”) will generate a list of 80 directory providers at random consisting of at least two from each delegated arrangement per month, 
including but not limited to the following specialties: Primary Care Physician (“PCP”), Cardiologist, Oncologist, Ophthalmologist 
a.	The same provider may not be chosen twice within a twelve (12) month period unless they are from a Delegate or group with less than 24 providers
b.	In any rolling three (3) month period, at least one of the following specialties must be present: PCP, Cardiologist, Oncologist, Ophthalmologist 

*/

-- this query is separated into two parts for "Not VSP, DQ and not the 4 specialties" and "Not VSP, DQ and the 4 specialties" because of the sub specialty is populated and is null for sub specialty
-- this query also separated MEDX because MEDX has less than 24 providers
-- since DentaQuest and VSP are separated into 2 different rosters, 'VSPR','VSPD','DQMR','DQMC', they are also got their query




INSERT INTO [NetworkData].[dbo].[Z_Provider Audit Report] (
	[UDC], [Provider Last Name],[Provider First Name],[Provider Full Name], [Provider's NPI],[Provider Specialty], [Provider Sub Specialty], [Phone Number]
	, [Street Address], [Street Address 2], [City], [State], [ZipCode], [County Name], [Site Nam/Group Name], [Accepting New Patients],
	[ProviderID], [LocationID],[Created Date], [Roster Name])

	select 
	cr.[UDC], cr.[LNAME],cr.[FNAME], cr.[PROVIDER FULL NAME], cr.[NPI], cr.[Specialty], cr.[Sub Specialty], cr.[Phone Number], 
	cr.[STREET ADDRESS], cr.[Address 2], cr.City, cr.[State], cr.[Zip code], cr.County, cr.[Site Name], cr.[Accepting New Patients],
	cr.ProviderId,cr.[LocationId], '6/28/2023' as [Created Date], 'All Lob Roster' as [Roster Name]
	/*DENSE_RANK() OVER (
    PARTITION BY cr.[UDC]--, [specialty], [sub specialty]
    ORDER BY cr.[ProviderId] ASC) AS rank */
	
	from (

	/*********************/
	-- Not VSP, DQ and not the 4 specialties: 'Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical' and specialist
	/*********************/

	select distinct '1' as rank , * 
    from (
		select [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where
		/*(Specialty not in ('Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical')
		and [Sub Specialty] not in ('Micrographic Surgery and Dermatologic Oncology', 'Oncology - Gynecologic','Oncology - Hematology','Oncology - Medical','Oncology - Urologic'))  and Category='Specialist' 
		 and */ [UDC] not in ('VSPR','VSPD','DQMR','DQMC','HPX','MEDX','ESSN') 
		 and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- ********* this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
	 union
		select [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where
		/*(Specialty not in ('Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical')
		and [Sub Specialty] is null)  and Category='Specialist' 
		and */ UDC not in ('VSPR','VSPD','DQMR','DQMC','HPX','MEDX','ESSN')
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- ********** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
	) as ord 
	where ord.ProviderId in 

	/***************

		this part is to make sure that the query is picking random providers monthly

		*****************/
						(
							select distinct pr.[ProviderId] from [NetworkData].[dbo].[Directory for provider] as pr
							inner join
							(select distinct [ProviderId],[UDC], row_number() OVER (
							PARTITION BY [UDC]
							ORDER BY NEWID()) AS denserank from [NetworkData].[dbo].[Directory for provider] where UDC not in ('VSPR','VSPD','DQMR','DQMC','HPX','MEDX','ESSN')) as rankedpid
							on pr.[ProviderId]=rankedpid.ProviderId
							where rankedpid.denserank<=2 
						)

	 union
	
	/*****************************
		For MEDX
	************************/

	select '1', [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
	where
	UDC in ('MEDX') and [ProviderId] in (select top 2 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('MEDX') order by NEWID()) 

	union

	/*****************************
		For ESSEN
	************************/

	select * from (
		select DENSE_RANK() OVER (
		PARTITION BY [PROVIDERID]--, [specialty], [sub specialty]
		 ORDER BY [Locationid] ASC)  as ranks, [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where [ProviderId] in (select top 2 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('essn') order by NEWID()) 
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) and UDC='ESSN'
		-- *********** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
		) as ESSEN
	where ESSEN.ranks=1

	union

	/*********************/
	-- Not VSP, DQ and the 4 specialties: 'Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical' and PCP
	/*********************/

		select distinct '1' as rank, * 
		
		from (
			select [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
			[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
			[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
			where 
				(Specialty in ('Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical')
					or [Sub Specialty] in ('Micrographic Surgery and Dermatologic Oncology', 'Oncology - Gynecologic','Oncology - Hematology','Oncology - Medical','Oncology - Urologic') or Category='PCP' ) 
					 and UDC not in ('VSPR','VSPD','DQMR','DQMC','HPX','ESSN') 
					 and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- ************* this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
		 union
			select 
			[UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
			[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
			[ProviderId],[LocationId]
			from [NetworkData].[dbo].[Directory for provider]
			where 
				(Specialty in ('Ophthalmology', 'Cardiovascular Disease', 'Oncology - Radiation','Oncology - Surgical')
				or [Sub Specialty] in ('Micrographic Surgery and Dermatologic Oncology', 'Oncology - Gynecologic','Oncology - Hematology','Oncology - Medical','Oncology - Urologic') or Category='PCP' ) 
				 and UDC not in ('VSPR','VSPD','DQMR','DQMC','HPX','ESSN') 
				 and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- **************** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
		) as ord
		where ord.ProviderId in 
		/***************

		this part is to make sure that the query is picking random providers monthly

		*****************/
						(
							select distinct pr.[ProviderId] from [NetworkData].[dbo].[Directory for provider] as pr
							inner join
							(select distinct [ProviderId],[UDC], row_number() OVER (
							PARTITION BY [UDC]
							ORDER BY NEWID()) AS denserank from [NetworkData].[dbo].[Directory for provider] where UDC not in ('VSPR','VSPD','DQMR','DQMC','HPX','MEDX','ESSN')) as rankedpid
							on pr.[ProviderId]=rankedpid.ProviderId
							where rankedpid.denserank<=2 
						)

	/*********************/
	-- DQ
	/*********************/

	union

	select distinct '1' as rank, [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where [ProviderId] in (select top 2 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('DQMR','DQMC') order by NEWID()) 
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- *********** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
	
	/*********************/
	-- VSP
	/*********************/

	union
	select distinct '1' as rank, [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where [ProviderId] in (select top 1 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('VSPR','VSPD') and Specialty='Ophthalmology' order by NEWID()) and Specialty='Ophthalmology'
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- ********** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
	union
	select distinct '1' as rank, [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where [ProviderId] in (select top 1 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('VSPR','VSPD') and Specialty='Optometry' order by NEWID()) and Specialty='Optometry'
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) -- ********* this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
) as cr -- as combinedroster
--where cr.rank<3
order by UDC asc






		select * from (
		select DENSE_RANK() OVER (
		PARTITION BY [PROVIDERID]--, [specialty], [sub specialty]
		 ORDER BY [Locationid] ASC)  as ranks, [UDC], [LNAME],[FNAME], [PROVIDER FULL NAME], [NPI], [Specialty], [Sub Specialty], [Phone Number], 
		[STREET ADDRESS], [Address 2], [City], [State], [Zip code], [County], [Site Name], [Accepting New Patients],
		[ProviderId],[LocationId] from [NetworkData].[dbo].[Directory for provider]
		where [ProviderId] in (select top 2 [ProviderId] from [NetworkData].[dbo].[Directory for provider] where UDC in ('essn') order by NEWID()) 
		and [ProviderId] not in (select distinct [ProviderID] from [NetworkData].[dbo].[Z_Provider Audit Report] where [Created Date]>=DATEADD(month,-12,getdate())) and UDC='ESSN'
		-- *********** this is to make sure provider is not being selected for in the past 12 months for any UDC with more than 24 providers
		) as ESSEN
		where ESSEN.ranks=1







