select 
    case
        when kount > 0
            then 'OK'
        else
              'FAIL: check building_historic_pub for errors'
    end as qacheck
    from
(select count(*) as kount from building_pub) a;
select 
    case
        when kount > 0
            then 'OK'
        else
              'FAIL: check building_historic_pub for errors'
    end as qacheck
    from
(select count(*) as kount from building_historic_pub) a;