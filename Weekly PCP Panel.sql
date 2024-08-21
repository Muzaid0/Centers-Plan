Select * from NetworkData.dbo.[Weekly PCP Panel]
where [Current Flag] = 'Y'

-----------------------------Updates UDC & Roster Address------------------------------------------------------

UPDATE t1
  SET t1.[Roster Address] = t2.Roster_Directory_Address_Format
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.[PCP Address Line 1] = t2.Original_Address
    where [Current Flag] = 'Y'


UPDATE t1
  SET t1.[Roster Room or Suite] = t2.Roster_Directory_Address_2_Format
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN networkdata.dbo.xref_address AS t2
  ON t1.[PCP Address Line 1] = t2.Original_Address
  where [Current Flag] = 'Y'

 UPDATE t1
  SET t1.[Roster Address] = t2.[STREET ADDRESS]
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN ProviderData.dbo.[Complete Provider Roster] AS t2
  ON t1.[PCP NPI] = t2.NPI and 
  t1.[PCP Zip] = t2.[Zip code] and
  LEFT(t1.[PCP Address Line 1],3) = LEFT(t2.[STREET ADDRESS],3)
    where [Current Flag] = 'Y'

    UPDATE t1
  SET t1.[Roster Room or Suite] = t2.[Address 2]
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN ProviderData.dbo.[Complete Provider Roster] AS t2
  ON t1.[PCP NPI] = t2.NPI and 
  t1.[PCP Zip] = t2.[Zip code] and
  LEFT(t1.[PCP Address Line 1],3) = LEFT(t2.[STREET ADDRESS],3)
    where [Current Flag] = 'Y'

	  UPDATE networkdata.dbo.[Weekly PCP Panel]
  SET [Roster City] = [PCP City]
  where [Current Flag] = 'Y'

  UPDATE networkdata.dbo.[Weekly PCP Panel]
  SET [Roster State] = [PCP State]
  where [Current Flag] = 'Y'

  UPDATE networkdata.dbo.[Weekly PCP Panel]
  SET [Roster Zip Code] = [PCP Zip]
  where [Current Flag] = 'Y'


UPDATE t1
  SET t1.[UDC(s)] = t2.UDC
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN ProviderData.dbo.[Complete Provider Roster] AS t2
  ON t1.[PCP NPI] = t2.NPI and 
  t1.[PCP Zip] = t2.[Zip code] and
  LEFT(t1.[PCP Address Line 1],3) = LEFT(t2.[STREET ADDRESS],3)
    where [Current Flag] = 'Y' and t2.[Term Date] is null 

UPDATE t1
  SET t1.[UDC(s)] = t2.UDC
  FROM networkdata.dbo.[Weekly PCP Panel] AS t1
  INNER JOIN [Pure_Complete MGNA Roster] AS t2
  ON t1.[PCP NPI] = t2.NPI and 
  t1.[PCP Zip] = t2.[Zip Code] and
  LEFT(t1.[PCP Address Line 1],3) = LEFT(t2.[Street Address],3)
    where [Current Flag] = 'Y' and [UDC(s)] is null and [Term Date] is null and [Terminate Date] is null


		select * from [Weekly PCP Panel]
	where [Current Flag] = 'Y'
