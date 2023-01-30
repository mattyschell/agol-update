set SCHEMA=XXXXX
set DATABASE=XXXXX
set SCHEMAPASS="iluvesri247"
CALL sqlplus %SCHEMA%/%SCHEMAPASS%@%DATABASE% @src\sql\deploy-bldg.sql && (
  echo created building publishing views in %SCHEMA% on %DATABASE% on %date% at %time% 
) || ( echo failed to create building publishinng views in %SCHEMA% on %DATABASE% && EXIT /B 1 )  