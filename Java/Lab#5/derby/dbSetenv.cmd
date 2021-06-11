@rem     *************************************************
@rem     this script sets up the environment for Derby
@rem     *************************************************

@echo off

@rem This environment variable names the databse
set DB_NAME=jdbc:derby://localhost:1527/JavaTunesDB

@rem This environment variable points to the Derby install directory
set DERBY_INSTALL=lib

set CLASSPATH=.;%DERBY_INSTALL%\derby.jar;%DERBY_INSTALL%\derbytools.jar;%DERBY_INSTALL%\derbynet.jar;%DERBY_INSTALL%\derbyclient.jar;%CLASSPATH%