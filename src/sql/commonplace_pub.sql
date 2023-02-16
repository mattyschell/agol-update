-- run in cscl_pub
-- subtype domains decoded from
-- https://github.com/CityOfNewYork/nyc-geo-metadata/blob/master/Metadata/Metadata_PointsOfInterest.md
--
-- confronted with disbelievers who think the decoding is 
-- only valid at the source?  This returns no rows
--select a.objectid 
--      ,a.facility_domains
--      ,b.facility_domains
--      ,a.facility_type
--      ,b.facility_type
--      ,b.objectid
--      ,b.bin
--      ,b.created_date 
--from 
--    cscl.commonplace_evw a
--join
--    cscl_pub.commonplace b
--on  a.placeid = b.placeid
--where a.facility_domains <> b.facility_domains
--and a.facility_type <> b.facility_type
create or replace force view commonplace_pub (
     objectid
    ,segmentid
    ,complexid
    ,saftype
    ,saftype_value --
    ,sosindicator
    ,sosindicator_value --
    ,placeid
    ,facility_domains
    ,facility_domains_value
    ,bin -- diff order now?
    ,boroughcode
    ,boroughcode_value --
    ,sourceid
    ,created_by
    ,created_date
    ,modified_by
    ,modified_date
    ,facility_type
    ,facility_type_value
    ,source
    ,source_value --
    ,b7sc
    ,primaryaddresspointid
    ,feature_name -- diff order
    ,security_level
    ,security_level_resolved
    ,shape
)
as 
select
     a.objectid
    ,a.segmentid
    ,a.complexid
    ,a.saftype
    ,a.saftype_value
    ,a.sosindicator
    ,a.sosindicator_value
    ,a.placeid
    ,a.facility_domains
    ,case facility_domains
        when '1' then
            Decode(facility_type,  1, 'Gated Development'
                                 , 2, 'Public Elementary School'
                                 , 3, 'Center'
                                 , 4, 'Park'
                                 , 5, 'Residential Child Care'
                                 , 6, 'Bus Terminal'
                                 , 7, 'Center'
                                 , 8, 'Government Office'
                                 , 9, 'Church'
                                 ,10, 'Hospital'
                                 ,11, 'NYPD Precinct'
                                 ,12, 'Island'
                                 ,13, 'Official Landmark')
        when '2' then
            Decode(facility_type,  1, 'Private Development'
                                 , 2, 'Public Junior High-Intermediate-Middle'
                                 , 3, 'Library'
                                 , 4, 'Amusement Park'
                                 , 5, 'Day Care Center'
                                 , 6, 'Ferry landing/terminal'
                                 , 7, 'Business'
                                 , 8, 'Court of law'
                                 , 9, 'Synagogue'
                                 ,10, 'Inpatient care center'
                                 ,11, 'NYPD Checkpoint'
                                 ,12, 'River'
                                 ,13, 'Point of Interest')    
        when '3' then
            Decode(facility_type,  1, 'Public Housing Development'
                                 , 2, 'Public High School'
                                 , 3, 'Theater/Concert Hall'
                                 , 4, 'Golf Course'
                                 , 5, 'Adult Day Care'
                                 , 6, 'Transit/Maintenance Yard'
                                 , 7, 'Market'
                                 , 8, 'Post Office'
                                 , 9, 'Temple'
                                 ,10, 'Outpatient care center/Clinic'
                                 ,11, 'FDNY Ladder Company'
                                 ,12, 'Lake'
                                 ,13, 'Cemetery/Morgue') 
        when '4' then
            Decode(facility_type,  1, 'Constituent'
                                 , 2, 'Private/Parochial Elementary School'
                                 , 3, 'Museum'
                                 , 4, 'Beach'
                                 , 5, 'Nursing Home/Assisted Living Facility'
                                 , 6, 'Airport'
                                 , 7, 'Hotel/Motel'
                                 , 8, 'Consulate'
                                 , 9, 'Convent/Monastery'
                                 ,10, 'Other'
                                 ,11, 'FDNY Battalion'
                                 ,12, 'Stream'
                                 ,13, 'Other') 
        when '5' then
            Decode(facility_type,  1, 'Other'
                                 , 2, 'Private/Parochial Junior/Middle School'
                                 , 3, 'Other'
                                 , 4, 'Botanical Garden'
                                 , 5, 'Homeless shelter'
                                 , 6, 'Heliport'
                                 , 7, 'Restaurant'
                                 , 8, 'Embassy'
                                 , 9, 'Mosque'
                                 ,11, 'Correctional Facility'
                                 ,12, 'Other'
                                 ,13, 'Triangle/Square/Circle')  
        when '6' then
            Decode(facility_type,  2, 'Private/Parochial High School'
                                 , 4, 'Zoo'
                                 , 5, 'Other'
                                 , 6, 'Marina'
                                 , 7, 'Other'
                                 , 8, 'Military'
                                 , 9, 'Other'
                                 ,11, 'FDNY Engine Company'
                                 ,12, 'Pond') 
        when '7' then
            Decode(facility_type,  2, 'Post Secondary Degree Granting Institution'
                                 , 4, 'Recreational Center'
                                 , 6, 'Pier'
                                 , 8, 'Other'
                                 ,11, 'FDNY Special Unit')
        when '8' then
            Decode(facility_type,  2, 'Other'
                                 , 4, 'Sports'
                                 , 6, 'Bridge'
                                 ,11, 'FDNY Division') 
        when '9' then
            Decode(facility_type,  2, 'Public Early Childhood'
                                 , 4, 'Playground'
                                 , 6, 'Tunnel'
                                 ,11, 'FDNY Squad') 
        when '10' then
            Decode(facility_type,  2, 'Public K-8'
                                 , 4, 'Other'
                                 , 6, 'Exit/Entrance'
                                 ,11, 'NYPD Other') 
        when '11' then
            Decode(facility_type,  2, 'Public K-12 all grades'
                                 , 4, 'Pool'
                                 , 6, 'Water Navigation'
                                 ,11, 'Other') 
        when '12' then
            Decode(facility_type,  2, 'Public Secondary School'
                                 , 4, 'Garden'
                                 , 6, 'Other'
                                 ,11, 'FDNY Other') 
        when '13' then
            Decode(facility_type, 2, 'Public School Building') 
        when '14' then
            Decode(facility_type, 2, 'Public School Annex') 
        when '15' then
            Decode(facility_type, 2, 'Private/Parochial Early Childhood') 
        when '16' then
            Decode(facility_type, 2, 'Private/Parochial K-8') 
        when '17' then
            Decode(facility_type, 2, 'Private/Parochial K-12 all grades') 
        when '18' then
            Decode(facility_type, 2, 'Private/Parochial Secondary School') 
      end facility_value    
    ,a.bin
    ,a.boroughcode
    ,a.boroughcode_value
    ,a.sourceid
    ,a.created_by
    ,a.created_date
    ,a.modified_by
    ,a.modified_date
    ,a.facility_type
    ,case facility_type
        when 1 then
            'Residential'
        when 2 then
            'Education Facility'
        when 3 then
            'Cultural Facility'
        when 4 then
            'Recreational Facility'
        when 5 then
            'Social Services'
        when 6 then
            'Transportation Facility'
        when 7 then
            'Commercial'
        when 8 then
            'Government Facility (non public safety)'
        when 9 then
            'Religious Institution'
        when 10 then
            'Health Services'
        when 11 then
            'Public Safety'
        when 12 then
            'Water'
        when 13 then
            'Miscellaneous'
      end facility_type_value
    ,a.source
    ,a.source_value
    ,a.b7sc
    ,a.primaryaddresspointid
    ,a.feature_name
    ,a.security_level
    ,a.shape
from cscl_pub.commonplace a;
grant select on commonplace_pub to "PUBLIC";