@echo off

@echo Launching script with this features:
@echo .
@echo Create a folder called c:\temp\test1
@echo .
@echo Use MONGOD executable from folder: c:\oss\mongod\bin\
@echo .
@echo Configure mongod instance in port 27055
@echo .
@echo StartMongoForUnitTest.cmd new-c:\temp\test1 mongoRoot-c:\oss\mongodb\bin\mongod port-27055
@echo .
@echo .
@echo .
@echo The execution of the script returns an errorlevel value which is the PID associated to the
@echo mongod process in memory. You can use that value to remove the mongod process from memory
@echo when the tests are finished.
@echo .
@echo call StartMongoForUnitTest.cmd new-c:\temp\test1 mongoRoot-c:\oss\mongodb\bin\mongod port-27055
@echo set taskexitcode=%errorlevel%
@echo @echo %taskexitcode%
@echo pause
@echo KillMongoDbInstance.cmd %taskexitcode%
@echo .
rem call StartMongoForUnitTest.cmd new-c:\temp\test1 mongoRoot-c:\oss\mongodb\bin\mongod port-27055
rem set taskexitcode=%errorlevel%
rem @echo %taskexitcode%
rem pause
rem KillMongoDbInstance.cmd %taskexitcode%
@echo .
@echo .
@echo As mentioned, the previous script will return the PID of the mongod processId
@echo .
@echo .
@echo .
@echo Script to kill launched instance in previous step, assuming the PID returned is 8420:
@echo .
@echo KillMongoDbInstance.cmd 8420

rem KillMongoDbInstance.cmd 8420

@echo .
@echo .
@echo EOF
