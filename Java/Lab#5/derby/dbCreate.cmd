@rem     *****************************************************************************
@rem     this script starts the Derby ij and creates the JavaTunes database
@rem     *****************************************************************************

@rem     change the following line to 'echo on' for debugging
@echo off

setlocal

@rem     call dbSetenv.cmd script to set up the Derby environment
call dbSetenv

title Create JavaTunesDB database

@rem     start ij, and run the the dbCreate.sql script, which connects 
@rem     to the JavaTunesDB database, as user/password guest/password,
@rem     creates the database if it doesn't exist,
@rem     and creates the JavaTunes schema and database tables
java -Dij.driver=org.apache.derby.jdbc.ClientDriver -Dij.database=%DB_NAME%;create=true -Dij.user=guest -Dij.password=password org.apache.derby.tools.ij dbCreate.sql

echo JavaTunesDB created.
pause

endlocal