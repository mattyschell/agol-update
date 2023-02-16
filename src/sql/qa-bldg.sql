select 
    case
        when kount > 0
            then 'OK'
        else
              'FAIL: check building for errors'
    end as qa_building_pub
    from
(select count(*) as kount from building) a;
select 
    case
        when kount > 0
            then 'OK'
        else
              'FAIL: check building_historic for errors'
    end as qa_building_historic_pub
    from
(select count(*) as kount from building_historic) a;