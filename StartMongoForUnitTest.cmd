@echo off
setLocal
FOR %%A IN (%*) DO (
   FOR /f "tokens=1,2 delims=-" %%G IN ("%%A") DO set %%G=%%H
)

  @echo .
  @echo .
  @echo .
  @echo #                      H E L P                                         #
  @echo ========================================================================
  @echo =                                                                      =
  @echo =    help-y                       Shows this help                      =
  @echo =    new-root                     Creates new structure for database   =
  @echo =                                   starting in root folder            =
  @echo =    mongoRoot-root               Tells the script where is the        =
  @echo =                                 MongoDB bin folder                   =
  @echo =    port-portNumber              Port number where to start MongoDB   =
  @echo ========================================================================

:CreateNewStructureFolder
@echo Creating folder structure
mkdir %new%

:NoStructure
rem cls
@echo Launching mongoDb instance

@echo Creating MongoD process

for /f "tokens=2 delims==; " %%A in (
  'wmic process call create '%mongoRoot% --dbpath %new% --port %port%' ^| find "ProcessId"'
) do set "PID=%%A"
echo MongoDB instance launched on PID#: %PID%

GOTO Exit

:NoMongoRoot
cls
@echo ======= E R R O R =========
@echo Missing MongoRoot parameter
GOTO ShowHelp

:Exit
@echo Script finished

EXIT /B %PID%
