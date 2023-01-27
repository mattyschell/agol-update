-- from building_readonly

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

create or replace force view building_pub (
    objectid 
   ,bin
   ,base_bbl
   ,construction_year
   ,last_status_type
   ,doitt_id
   ,height_roof
   ,feature_code
   ,status
   ,ground_elevation
   ,created_date
   ,last_edited_date
   ,mappluto_bbl
   ,shape
)
as 
select
    objectid
   ,bin
   ,base_bbl
   ,construction_year
   ,last_status_type
   ,doitt_id
   ,height_roof
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
   ,status
   ,ground_elevation
   ,created_date
   ,last_edited_date
   ,mappluto_bbl
   ,shape
from  
    bldg.building_evw;

grant select on building_pub to "PUBLIC";

   
   
    

