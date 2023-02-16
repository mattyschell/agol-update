declare
    psql    varchar2(4000);
    type    stringarray is table of varchar2(4000) index by pls_integer;
    tabz    stringarray;
    colz    stringarray;
    kount   pls_integer;
    replacecol  varchar2(54);
begin
    psql := 'select table_name from user_tables where table_name like :p1';
    execute immediate psql bulk collect into tabz using '%RESOLVED';
    for i in 1 .. tabz.COUNT
    loop
        psql := 'select column_name from user_tab_cols '
             || 'where table_name = :p1 '
             || 'and column_name like :p2 ';
        execute immediate psql bulk collect into colz using tabz(i),
                                                            '%RESOLVED';
        for ii in 1 .. colz.count
        loop
            psql := 'select count(*) from ' || tabz(i) || ' a '
                 || 'where ' || colz(ii) || ' is null '
                 || 'and ' || replace(colz(ii), '_RESOLVED', '') || ' is not null ';
            execute immediate psql into kount;
            if kount > 0
            then
                dbms_output.put_line('I see an issue in ' || tabz(i));
                dbms_output.put_line('Check column ' || colz(ii));
            end if;            
        end loop;          
    end loop;
end;
