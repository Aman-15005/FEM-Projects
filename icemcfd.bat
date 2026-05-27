@echo off

set sub=\bin\
set full=%~dp0
call set work=%%full:%sub%=%%
set ICEM_ACN=%work%

set aie_mode=1

set ICEM_AI_ENVIRONMENT=
set AI_ENV_CFD=
set AI_ENV_CFD_ONLY=
set AI_ENV_CFX=
set AI_NO_BLOCKING=
set AI_NO_POST=
set AI_ENV_CART3D=
set AI_ENV_LSTC=
set AI_ENV_ANSYS_SOLVERS=

if not exist "%AWP_ROOT%" set AWP_ROOT=%ICEM_ACN%\..\..
set V=000
set relinfo="%AWP_ROOT%\commonfiles\globalsettings\relinfo.txt"
if exist %relinfo% (
    set /p V= < %relinfo%
) else (
    echo Can't identify the version number!
)
if not exist "%%ANSYS%V%_DIR%%" set ANSYS%V%_DIR=%AWP_ROOT%\ANSYS

set PRINT_MESSAGE=
if "%ANS_FLEXLM_DEBUG%"=="1" set PRINT_MESSAGE=1
if "%ANS_FLEXLM_DEBUG%"=="2" set PRINT_MESSAGE=1

set VAR1=
set FLAVOR=
set AI_ENV_TEST_LICENSING=

set VAR1=%~1
if "%PRINT_MESSAGE%"=="1" echo VAR1 is %VAR1%

if "%VAR1%" == "-4" goto top
if "%VAR1%" == "-ai" goto top
if "%VAR1%" == "-cfd" goto top
if "%VAR1%" == "-cfx" goto top
if "%VAR1%" == "-ansys" goto top
if "%VAR1%" == "-fsi" goto top
if "%VAR1%" == "-lstc" goto top
if "%VAR1%" == "-autohex" goto top
if "%VAR1%" == "-batchsurf" goto top

:top
if "%~1"=="" goto bot

if "%~1"=="-4" (
    set aie_mode=0
    set AI_ENV_PRODUCT=cfd
    shift
    goto top
)
if "%~1"=="-cfd" (
    set FLAVOR=-cfd
    if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~4"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    if "%~4"=="-no_post" set AI_NO_POST=1
    if "%~2"=="-cart3d" set AI_ENV_CART3D=1
    if "%~3"=="-cart3d" set AI_ENV_CART3D=1
    if "%~4"=="-cart3d" set AI_ENV_CART3D=1
    set AI_ENV_PRODUCT=cfd
    shift
    goto top
)
if "%~1"=="-cfx" (
    set FLAVOR=-cfx
    if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    set AI_ENV_PRODUCT=cfx
    shift
    goto top
)
if "%~1"=="-ansys" (
    set FLAVOR=-ansys
    if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    set AI_ENV_PRODUCT=cfx
    shift
    goto top
)
if "%~1"=="-ai" (
    set FLAVOR=-ai
    if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    set AI_ENV_PRODUCT=fea2.0
    shift
    goto top
)
if "%~1"=="-fsi" (
    set FLAVOR=-fsi
    if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~4"=="-no_hexa" set AI_NO_BLOCKING=1
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    if "%~4"=="-no_post" set AI_NO_POST=1
    if "%~2"=="-cart3d" set AI_ENV_CART3D=1
    if "%~3"=="-cart3d" set AI_ENV_CART3D=1
    if "%~4"=="-cart3d" set AI_ENV_CART3D=1
    set AI_ENV_PRODUCT=fsi
    shift
    goto top
)
if "%~1"=="-lstc" (
    set FLAVOR=-lstc
    if "%~2"=="-no_post" set AI_NO_POST=1
    if "%~3"=="-no_post" set AI_NO_POST=1
    set AI_ENV_PRODUCT=lstc
    shift
    goto top
)

if "%~1" == "-autohex" goto AUTOHEXA

if "%~1" == "-batchsurf" goto BATCHSURF

if "%~1" == "-h" goto UsageCFD
if "%~1" == "-help" goto UsageCFD
if "%~1" == "/?" goto UsageCFD

:bot

if "%PRINT_MESSAGE%"=="1" echo FLAVOR is %FLAVOR%

if "%~1"=="-no_hexa" set AI_NO_BLOCKING=1
if "%~2"=="-no_hexa" set AI_NO_BLOCKING=1
if "%~3"=="-no_hexa" set AI_NO_BLOCKING=1
if "%~1"=="-no_post" set AI_NO_POST=1
if "%~2"=="-no_post" set AI_NO_POST=1
if "%~3"=="-no_post" set AI_NO_POST=1
if "%~1"=="-cart3d" set AI_ENV_CART3D=1
if "%~2"=="-cart3d" set AI_ENV_CART3D=1
if "%~3"=="-cart3d" set AI_ENV_CART3D=1

if "%FLAVOR%"=="-cfd" (
    set AI_ENV_PRODUCT=cfd
    goto bot1
)
if "%FLAVOR%"=="-cfx" (
    set AI_NO_POST=1
    set AI_ENV_ANSYS_SOLVERS=1
    set AI_ENV_PRODUCT=cfx
    goto bot1
)
if "%FLAVOR%"=="-ansys" (
    set AI_NO_POST=1
    set AI_ENV_ANSYS_SOLVERS=1
    set AI_ENV_PRODUCT=ansys
    goto bot1
)
if "%FLAVOR%"=="-ai" (
    set AI_ENV_PRODUCT=fea2.0
    goto bot1
)
if "%FLAVOR%"=="-fsi" (
    set AI_ENV_PRODUCT=fsi
    goto bot1
)
if "%FLAVOR%"=="-lstc" (
    set AI_ENV_PRODUCT=lstc
    goto bot1
)

:bot1

if "%AI_NO_BLOCKING%"=="0" set AI_NO_BLOCKING=
if "%AI_NO_POST%"=="0" set AI_NO_POST=
if "%AI_ENV_CART3D%"=="0" set AI_ENV_CART3D=

if "%PRINT_MESSAGE%"=="1" echo AI_NO_BLOCKING is %AI_NO_BLOCKING%
if "%PRINT_MESSAGE%"=="1" echo AI_NO_POST is %AI_NO_POST%
if "%PRINT_MESSAGE%"=="1" echo AI_ENV_CART3D is %AI_ENV_CART3D%

if "%aie_mode%"=="1" (
    set ICEM_AI_ENVIRONMENT=1
    if "%AI_ENV_PRODUCT%"=="fea2.0" (
        set AI_ENV_ANSYS=1
        set AI_ENV_LSDYNA=1
        set AI_ENV_ABAQUS=1
        set AI_ENV_AUTODYN=1
    )
    if "%AI_ENV_PRODUCT%"=="cfd" (
        set AI_ENV_CFD=1
        set AI_ENV_CFD_ONLY=1
    )
    if "%AI_ENV_PRODUCT%"=="cfx" (
        set AI_ENV_CFD=1
        set AI_ENV_CFD_ONLY=1
        set AI_ENV_CFX=1
        set AI_ENV_PRODUCT=cfd
    )
    if "%AI_ENV_PRODUCT%"=="ansys" (
        set AI_ENV_CFD=1
        set AI_ENV_PRODUCT=fea2.0
        set AI_ENV_ANSYS=1
        set AI_ENV_LSDYNA=1
        set AI_ENV_AUTODYN=1
    )
    if "%AI_ENV_PRODUCT%"=="fsi" (
        set AI_ENV_CFD=1
        set AI_ENV_PRODUCT=fea2.0
        set AI_ENV_ANSYS=1
        set AI_ENV_LSDYNA=1
        set AI_ENV_ABAQUS=1
        set AI_ENV_AUTODYN=1
    )
    if "%AI_ENV_PRODUCT%"=="commonstruct" (
        set AI_ENV_ANSYS=1
        set AI_ENV_LSDYNA=1
        set AI_ENV_ABAQUS=1
        set AI_ENV_AUTODYN=1
    )  
    if "%AI_ENV_PRODUCT%"=="lstc" (
        set AI_ENV_CFD=1
        set AI_ENV_CFD_ONLY=1
        set AI_ENV_LSTC=1
        set AI_ENV_PRODUCT=cfd
    )
)

if "%PRINT_MESSAGE%"=="1" echo AI_ENV_PRODUCT is %AI_ENV_PRODUCT%

if not exist Uninst.isu goto StartCFD
if exist icemcfd.bat goto WrongDir

:StartCFD
if not exist "%ICEM_ACN%\bin\med.exe" goto NoInstall

set KEEP_PATH=%PATH%
call set AWP=%%AWP_ROOT%V%%%
set PATH=%ICEM_ACN%\bin;%ICEM_ACN%\lib;%PATH%;%ICEM_ACN%\toolswin32
if exist "%AWP%\aisol\bin\winx64" set PATH=%PATH%;%AWP%\aisol\bin\winx64
if exist "%AWP%\tp\IntelCompiler\2023.1.0\winx64" set PATH=%AWP%\tp\IntelCompiler\2023.1.0\winx64;%PATH%
if exist "%AWP%\tp\hdf5\1.12.2\winx64" set PATH=%AWP%\tp\hdf5\1.12.2\winx64;%PATH%
if exist "%AWP%\Framework\bin\Win64" set PATH=%PATH%;%AWP%\Framework\bin\Win64
if exist "%AWP%\tp\IntelMKL\2020.0.166\winx64" set PATH=%PATH%;%AWP%\tp\IntelMKL\2020.0.166\winx64
if exist "%AWP%\tp\openjre\1.8.0\bin\server" set PATH=%PATH%;%AWP%\tp\openjre\1.8.0\bin\server
if exist "%AWP%\tp\qt_fw\5.5.1\Win64\bin" set  PATH=%PATH%;%AWP%\tp\qt_fw\5.5.1\Win64\bin
if exist "%AWP%\commonfiles\fluids\lib\winx64" set PATH=%PATH%;%AWP%\commonfiles\fluids\lib\winx64

set wb2=0
if "%~1" == "-batch" (
    if "%~2" == "-wb2" (
        if "%~3" == "-wb_command" (
            set wb2=1
        )
    )
    goto StartBatch
)

start /wait med.exe %*
goto StartFinish

:AUTOHEXA
set AUTOHEX_ROOT=%ICEM_ACN%
if not exist "%AUTOHEX_ROOT%\bin\autohex.exe" (
    echo Note that the executable "autohex.exe" needs to be obtained from an old installation and copied to "%AUTOHEX_ROOT%\bin".
    goto NoInstall
)
set KEEP_PATH=%PATH%
set PATH=%ICEM_ACN%\bin;%ICEM_ACN%\lib;%PATH%;%ICEM_ACN%\toolswin32
"%AUTOHEX_ROOT%\bin\autohex.exe"
goto StartFinish

:BATCHSURF
set ICEM_AI_ENVIRONMENT=1
set AI_ENV_ANSYS=1
set AI_ENV_LSDYNA=1
set AI_ENV_ABAQUS=1
set AI_ENV_AUTODYN=1
set AI_ENV_PRODUCT=fea2.0
set ICEM_SCRIB=%ICEM_ACN%\lib\scrib
set TCL_LIBRARY=%ICEM_ACN%\lib\tcl8.3.3
set TK_LIBRARY=%ICEM_ACN%\lib\tk8.3.3
if not exist "%ICEM_ACN%\bin\wish.exe" goto NoInstall
set KEEP_PATH=%PATH%
set PATH=%ICEM_ACN%\bin;%ICEM_ACN%\lib;%PATH%;%ICEM_ACN%\toolswin32
"%ICEM_ACN%\bin\wish.exe" "%ICEM_SCRIB%\app\main.tcl" app_bsm_generic"
goto StartFinish

:StartBatch
start /b /wait med_batch.exe %*

:StartFinish
set PATH=%KEEP_PATH%
goto ExitCFD

:WrongDir
echo Can't run ICEM CFD in the Installation Directory!
pause
goto ExitCFD

:NoInstall
echo Can't find the Installation Directory!
pause
goto ExitCFD

:UsageCFD
echo Usage: icemcfd.bat [-script ScriptName] [-4] [-app APP] [-cfd] [-batch] [projectfile]
pause

:ExitCFD
if %WB2% NEQ 0 (
    echo ICEM CFD's return status was %ERRORLEVEL%.
    exit %ERRORLEVEL%
)
