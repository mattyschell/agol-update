-- do not  include
-- name
-- geom_source
-- created_user
-- last_edited_user
-- addressable
-- condo_flags
-- alteration_year
-- se_anno_cad_data
-- sde_state_id
--
-- AGOL currently publishes
-- Name
-- geom_source
create or replace force view building_historic_pub (
     objectid
    ,bin
    ,base_bbl
    ,height_roof
    ,last_status_type
    ,doitt_id
    ,construction_year
    ,demolition_year
    ,created_date
    ,last_edited_date
    ,addressable
    ,ground_elevation
    ,status
    ,feature_code
    ,mappluto_bbl
)
as 
select
     objectid
    ,bin
    ,base_bbl
    ,height_roof
    ,last_status_type
    ,doitt_id
    ,construction_year
    ,demolition_year
    ,created_date
    ,last_edited_date
    ,addressable
    ,ground_elevation
    ,status
    ,case feature_code 
        when 2100 
            then 'Building'
        when 5100
            then 'Building Under Construction'
        when 5110 
            then 'Garage'
        when 2110
            then 'Skybridge'
        when 1000
            then 'Parking'
        when 1001
            then 'Gas Station Canopy'
        when 1002
            then 'Storage Tank'
        when 1003
            then 'Placeholder'
        when 1004
            then 'Auxiliary Structure'
        when 1005
            then 'Temporary Structure'
        when 1006
            then 'Cantilevered Building'        
     end feature_code 
    ,mappluto_bbl
from  
    bldg.building_historic_evw;
--grant select on building_historic_evw to "BLDG_READONLY" with grant option;
grant select on building_historic_pub to "PUBLIC";
