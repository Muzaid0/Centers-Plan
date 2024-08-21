
insert into [Stop Light Report]
(provider_id,provider_status,first_name,middle_name,last_name,prac_address_status,prac1_primary_address_in,prac1_secondary_address_in,
prac1_city_in,prac1_state_in,prac1_zip_in,prac_phone1_in,prac_phone_status,prac_fax1_in,prac_fax_status,license_status,prac_state_license_exp,lic1_num_in,
aug_lic1_state,aug_lic1_num,aug_lic1_type,aug_lic1_status,aug_lic1_begin_date,aug_lic1_end_date,npi_status,npi_num,aug_npi_num,aug_npi_deact_date,taxonomy,taxonomy_correction,tin1)

select 
provider_id,provider_status,first_name,middle_name,last_name,prac_address_status,prac1_primary_address_in,prac1_secondary_address_in,
prac1_city_in,prac1_state_in,prac1_zip_in,prac_phone1_in,prac_phone_status,prac_fax1_in,prac_fax_status,license_status,prac_state_license_exp,lic1_num_in,
aug_lic1_state,aug_lic1_num,aug_lic1_type,aug_lic1_status,aug_lic1_begin_date,aug_lic1_end_date,npi_status,npi_num,aug_npi_num,aug_npi_deact_date,taxonomy,taxonomy_correction,tin1
from [Stop Light report data]

update [Stop Light Report] 
set
LN_summary = 'INACTIVE PRACTITIONER' where provider_status in ('D','U','U1')

update [Stop Light Report] 
set
LN_summary = 'INACTIVE PRACTITIONER' where npi_status in ('D2','F')

update [Stop Light Report] 
set
LN_summary = 'BAD PHONE' where prac_phone_status in ( 'B','E','J','M')

update [Stop Light Report] 
set
LN_summary = 'INACTIVE ADDRESS' where prac_address_status in ( 'GD','II', 'IR', 'I2','Z')

update [Stop Light Report] 
set
LN_summary = 'INACTIVE ADDRESS' where license_status = 'I'

update [Stop Light Report] 
set
LN_summary = 'INACTIVE OTHER' where provider_status in ('D','U', 'U1','R1')

update [Stop Light Report] 
set
LN_summary = 'INACTIVE OTHER' where license_status in ('B', 'K','R')

update [Stop Light Report] 
set
LN_summary = 'INACTIVE OTHER' where npi_status in ('D2','F')


update [Stop Light Report] 
set
LN_summary = 'MED CONF PRACTITIONER-LOCATION' where prac_address_status in ('V','C') and prac_phone_status in ( 'V', 'C', 'CH',null)

update [Stop Light Report] 
set
LN_summary = 'HIGH CONF PRACTITIONER-LOCATION' where prac_address_status = 'V' and prac_phone_status = 'V'

update [Stop Light Report]
set
_0_LN_color_status = 'Red' where LN_summary in ('INACTIVE PRACTITIONER','BAD PHONE','INACTIVE ADDRESS','INACTIVE OTHER')

update [Stop Light Report]
set
_0_LN_color_status = 'Green' where LN_summary in ('MED CONF PRACTITIONER-LOCATION','HIGH CONF PRACTITIONER-LOCATION')

update [Stop Light Report]
set
_0_LN_color_status = 'Yellow' where LN_summary is null

update [Stop Light Report]
set
LN_summary = 'OTHER RESEARCH' where _0_LN_color_status = 'Yellow'

UPDATE [Stop Light Report]
SET [Date Added] = GETDATE()
WHERE [Date Added] IS NULL;


update [Stop Light Report]
set [Phone Description] = 'input phone is invalid' where prac_phone_status in ('B','J')

update [Stop Light Report]
set [Phone Description] = 'input phone is phone verified inactive' where prac_phone_status in ('C','CH','E','G','I')

update [Stop Light Report]
set [Phone Description] = ' input is blank or missing on input' where prac_phone_status in ('M')

update [Stop Light Report]
set [Address Description] = 'input address is unverified' where prac_address_status in ('Z','X','S','P','N','IR','II','I2','1','2')

update [Stop Light Report]
set [Address Description] = 'input address has been phone verified as inactive for the provider' where prac_address_status in ('GD','GN')

update [Stop Light Report]
set [Address Description] = 'input address matches to a known prison address and may be high risk' where prac_address_status in ('H')

update [Stop Light Report]
set [Address Description] = 'input address missing/not populated' where prac_address_status in ('A')

update [Stop Light Report]
set [Address Description] = 'input fax is unverified' where prac_address_status in ('B','C','CH')

update [Stop Light Report]
set [Fax Description] = 'input fax is phone verified inactive' where prac_fax_status in ('G')

update [Stop Light Report]
set [Fax Description] = 'input fax is verified inactive for the input provider/location' where prac_fax_status in ('I')

update [Stop Light Report]
set [Fax Description] = 'input fax is blank or missing' where prac_fax_status in ('M')

update [Stop Light Report]
set [License Description] = 'input license is unverified' where license_status in ('G','I','K','L','Q','R','T')

update [Stop Light Report]
set [License Description] = 'input license is blank/missing' where license_status in ('M','W')

update [Stop Light Report]
set [License Description] = 'license number is missing' where license_status in ('A')

update [Stop Light Report]
set [License Description] = 'input license is verified as active but restricted by the issuing State' where license_status in ('B')

update [Stop Light Report]
set [License Description] = 'suspended license status found for the provider' where license_status in ('8')

update [Stop Light Report]
set [NPI Description] = 'input NPI number is unverified for the provider' where npi_status in ('L')

update [Stop Light Report]
set [NPI Description] = 'input NPI number found to belong to a different provider than fielded on input record' where npi_status in ('Q')

update [Stop Light Report]
set [Provider Description] = 'Verify provider status' where provider_status in ('D','U','U1','R1','R2')


select * from [Stop Light Report]