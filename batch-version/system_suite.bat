@echo off
REM Windows System Utility Suite
REM Author: Sammy Alawar
REM Description: Interactive Windows admin toolkit 
:Start
cls
echo Choose From Menu: 
echo _____________________________________________________________________________________________
echo:
echo 1. System Information
echo:
echo 2. File Operations
echo:
echo 3. Network Tools
echo:
echo 4. Process Management
echo:
echo 5. Data Analysis
echo:
echo 6. Exit
echo:
set /p choice=Enter your Choice(1-6): 
:Input
if "%choice%" == "1" goto :SysInfo
if "%choice%" == "2" goto :FileOps
if "%choice%" == "3" goto :NetTools
if "%choice%" == "4" goto :Process
if "%choice%" == "5" goto :Data
if "%choice%" == "6" goto :Exit 
echo Please input a number between 1 and 6 according to your needs & pause & goto :Start

:SysInfo
cls
echo System Information Submenu 
echo _____________________________________________________________________________________________
echo:
echo 1. Display detailed configuration information about the computer and its operating system.
echo:
echo 2. Get basic information about the computer caption, codeset, buildnumber.
echo:
echo 3. Get information about the processor.
echo:
echo 4. Get information about the installed memory.
echo: 
echo 5. Get information about disk drives.
echo: 
echo 6. Display the host name portion of the full computer name.
echo:
echo 7. Display TCP/IP network configuration information.
echo:
echo 8. Display the current date.
echo:
echo 9. Display the current time.
echo:
echo 10. Exit System Information Submenu
echo:
set /p choice=Enter Choice(1-10): 

if "%choice%" == "1" cls & echo Configuration information of Computer and Operating System: & systeminfo & pause & goto :SysInfo

if "%choice%" == "2" cls & echo Computer Caption, codeset, and buildnumber: & wmic os get Caption,CodeSet,BuildNumber & pause & goto :SysInfo

if "%choice%" == "3" cls & echo CPU Information: & wmic cpu get Name,Manufacturer,MaxClockSpeed,NumberOfCores,NumberOfLogicalProcessors & pause & goto :SysInfo

if "%choice%" == "4" cls & echo RAM Infromation: & wmic memorychip get Capacity,Manufacturer,Speed,DeviceLocator,DataWidth,Description & pause & goto :SysInfo

if "%choice%" == "5" cls & echo Disk Drive Information: & wmic DISKDRIVE GET Size,Name,Model,InterfaceType,Description & pause & goto :SysInfo

if "%choice%" == "6" cls & echo Hostname: & hostname & pause & goto :SysInfo

if "%choice%" == "7" cls & echo Network Configuration: & ipconfig /all & pause & goto :SysInfo

if "%choice%" == "8" cls & echo Date: %date% & pause & goto :SysInfo

if "%choice%" == "9" cls & echo Time: %time% & pause & goto :SysInfo

if "%choice%" == "10" goto :Start
::Sammy Alawar
echo Please input a number between 1 and 10 according to your needs & pause & goto :SysInfo


rem ---------------------------------------------------------------------------------------------------------------------------------------------------------

:FileOps
cls
echo File Operations Submenu 
echo _____________________________________________________________________________________________
echo:
echo 1. Display or change file attributes.
echo:
echo 2. Display the name of or change the current directory.
echo:
echo 3. Copy one or more files to another location.
echo:
echo 4. Delete one or more files
echo: 
echo 5. Display a list of files and subdirectories in a directory.
echo:
echo 6. Create a directory.
echo:
echo 7. Move one or more files from one directory to another directory.
echo:
echo 8. Remove a directory.
echo:
echo 9. Rename a file.
echo:
echo 10. Save the current directory then change it.
echo:
echo 11. Replace a file.
echo:
echo 12. Graphically display the directory structure of a drive or path.
echo:
echo 13. Copies files and directory trees.
echo:
echo 14. Back

set /p choice=Enter Choice(1-14): 

if "%choice%" == "1" cls & goto :FileOps1

if "%choice%" == "2" cls & goto :FileOps2

if "%choice%" == "3" cls & goto :FileOps3

if "%choice%" == "4" cls & goto :FileOps4

if "%choice%" == "5" cls & goto :FileOps5

if "%choice%" == "6" cls & goto :FileOps6

if "%choice%" == "7" cls & goto :FileOps7

if "%choice%" == "8" cls & goto :FileOps8

if "%choice%" == "9" cls & goto :FileOps9

if "%choice%" == "10" cls & goto :FileOps10

if "%choice%" == "11" cls & goto :FileOps11

if "%choice%" == "12" cls & goto :FileOps12

if "%choice%" == "13" cls & goto :FileOps13

if "%choice%" == "14" goto :Start

echo Please input a number between 1 and 14 according to your needs & pause & goto :FileOps



:FileOps1
cls
echo 1. Display File Attributes
echo 2. Change File Attributes 
echo 3. Back
set /p choice=Enter Choice (1-3): 
set "filePath="
setlocal enabledelayedexpansion
if "%choice%"=="1" (
    cls

    set /p "filePath=Enter File path to check Attributes: "
    if exist "!filePath!" (
        cls

        echo Permissions for "!filePath!":
        icacls "!filePath!"
        endlocal
    ) else (
        echo File path is not valid.
        pause
        set "filePath="
        endlocal
        goto :FileOps1
    )
    pause
    goto :FileOps1
)

if "%choice%"=="2" (
    cls

    set /p filePath=Enter File path to change Attributes: 
    if exist "!filePath!" (
        goto :PermissionMenu
    ) else (
        echo File path is not valid.
        pause
        endlocal
        goto :FileOps1
    )
)

if "%choice%"=="3" goto :FileOps
echo Please input a valid option (1-3).
pause
goto :FileOps1

:PermissionMenu
cls
echo Choose the type of permission to grant:
echo _____________________________________________________________________________________________
echo:
echo 1. Full Control
echo:
echo 2. Modify
echo:
echo 3. Read and Execute
echo:
echo 4. Read
echo:
echo 5. Write
echo:
echo 6. Remove All Permissions
echo:
echo 7. Back
echo:

set /p permChoice=Enter your choice (1-7): 

if "%permChoice%"=="1" set permission=F & goto :setPerm
if "%permChoice%"=="2" set permission=M & goto :setPerm
if "%permChoice%"=="3" set permission=RX & goto :setPerm
if "%permChoice%"=="4" set permission=R & goto :setPerm
if "%permChoice%"=="5" set permission=W & goto :setPerm
if "%permChoice%"=="6" goto :removePerm
if "%permChoice%"=="7" goto :FileOps1

echo Please input a number between 1 and 7 according to your needs.
pause
goto :FileOps1

:setPerm
cls
set /p username=Enter the username or group: 
:: Check if the username is valid
if "!username!"=="" (
    echo Invalid username entered. Please try again.
    pause
    set /p username=""
    goto :PermissionMenu
)

:: Apply the permissions
icacls "!filePath!" /grant "!username!":!permission!

:: Check the result
if !errorlevel!==0 (
    echo Permissions updated successfully for "!filePath!".
    icacls "!filePath!"
) else (
    echo Failed to update permissions. Please check the input and try again.
)
pause
goto :FileOps1

:removePerm
cls
set /p username=Enter the username or group to remove permissions: 
if "!username!"=="" (
    echo Invalid username entered. Please try again.
    pause
    goto :FileOps1
)

:: Remove permissions
icacls "!filePath!" /remove !username!

:: Check the result
if !errorlevel!==0 (
    echo Permissions removed successfully for "!filePath!".
    icacls "!filePath!"
) else (
    echo Failed to remove permissions. Please check the input and try again.
)

pause
endlocal
goto :FileOps1





:FileOps2
cls
echo 1. Display Current Directory Name 
echo 2. Change Directory 
echo 3. Back
set /p choice=Enter Choice (1-3): 

if "%choice%" == "1" (
    cls

    echo Current Directory: 
    cd
    pause
    goto :FileOps2
) 
if "%choice%" == "2" (
    cls

    goto :changeDir
) 
if "%choice%" == "3" (
    cls

    goto :FileOps
)

echo Please input a number between 1 and 3 according to your needs.
pause
cls
goto :FileOps2

:changeDir
set /p newDir=Enter path of Directory: 

if exist "%newDir%\" (
    cd "%newDir%"
    echo Changed directory to: 
    cd
    pause
    goto :FileOps2
) else (
    echo The directory does not exist.
    pause
    goto :FileOps2
)



:FileOps3
cls
set validFiles=
set invalidFiles=
:: Prompt user for file paths
set /p files=Enter the file paths to copy (separate by spaces): 
:: Enable delayed expansion for loop handling
setlocal enabledelayedexpansion
for %%A in (%files%) do (
    if exist "%%A" (
        set "validFiles=!validFiles! %%A"
    ) else (
        set "invalidFiles=!invalidFiles! %%A"
    )
)
endlocal & set validFiles=%validFiles% & set invalidFiles=%invalidFiles%
:: Check for invalid files
if not "%invalidFiles%"=="" (
    setlocal enabledelayedexpansion
    set "str=These file(s) don't exist:"
    for %%i in (%invalidFiles%) do (
        set "str=!str! %%i"
    )
    echo !str!
    endlocal 	
    pause
    goto :FileOps
)

:: Print valid files
echo Valid files: %validFiles%

:: Get destination folder
:destination
set /p destination=Enter the destination folder:

:: Check if the destination is valid
if exist "%destination%\" (
    echo Destination is valid.
) else (
    echo Invalid destination. Please enter a valid directory destination.
    goto :FileOps
)

:: Copy the files
:copyFiles
for %%A in (%validFiles%) do (
    echo Copying "%%A" to "%destination%"...
    copy "%%A" "%destination%" >nul
)

echo Files copied successfully.
pause
goto :FileOps


:FileOps4
cls
set files=
set /p files=Enter Files you want to Delete: 
set validFiles=
set invalidFiles=
setlocal enabledelayedexpansion
for %%A in (%files%) do (
    if exist "%%A" (
        set "validFiles=!validFiles! %%A"
    ) else (
        set "invalidFiles=!invalidFiles! %%A"
    )
)
endlocal & set validFiles=%validFiles% & set invalidFiles=%invalidFiles%
if not "%invalidFiles%"=="" (
    setlocal enabledelayedexpansion
    set "str=These file(s) don't exist:"
    for %%i in (%invalidFiles%) do (
        set "str=!str! %%i"
    )
    echo !str!
    endlocal 
	
    pause
    goto FileOps
)

echo Valid files: %validFiles%
for %%A in (%validFiles%) do (
    del "%%A"
)
echo Deleted Files Successfully.
pause
goto :FileOps


:FileOps5
cls
set /p directory=Enter Directory you want to list: 
if exist "%directory%\" (
    dir "%directory%"
    pause
    goto :FileOps
) else (
    echo The directory "%directory%" does not exist. Please enter a valid directory.
    pause
    goto :FileOps
)


:FileOps6
cls
set "userPath="
set /p userPath=Enter name of the Directory you want to create: 

REM Extract everything before the last '\'
for %%A in ("%userPath%") do set parentDir=%%~dpA

REM Check if the extracted parent directory exists
if exist "%parentDir%" (
    md "%userPath%"
    echo Directory %userPath% has been created successfully.
    pause
    goto :FileOps
) else (
    echo The parent directory "%parentDir%" does not exist. Please enter a valid path.
    pause
    goto :FileOps
)

:FileOps7
cls
set /p files=Enter the file paths to move (separate by spaces): 
set validFiles=
set invalidFiles=
setlocal enabledelayedexpansion
for %%A in (%files%) do (
    if exist "%%A" (
        set "validFiles=!validFiles! %%A"
    ) else (
        set "invalidFiles=!invalidFiles! %%A"
    )
)
endlocal & set validFiles=%validFiles% & set invalidFiles=%invalidFiles%

if not "%invalidFiles%"=="" (
    echo These file^(s^) do not exist:%invalidFiles%
    pause
    goto :FileOps
)

echo Valid files: %validFiles%

:destination1
set /p destination=Enter the destination folder: 

if exist "%destination%\" (
    echo Destination is valid.
) else (
    echo Invalid destination. Please enter a valid directory.
    pause
    goto :FileOps
)

:moveFiles
for %%A in (%validFiles%) do (
    echo Moving %%A to %destination%...
    move "%%A" "%destination%"
)
echo Files moved Successfully.
pause
goto :FileOps


:FileOps8
cls
set /p directory=Enter Path of Directory you want to delete: 
if exist "%directory%\" (
    echo Destination is valid.
    rmdir /s /q "%directory%"
    echo Directory %directory% has been successfully deleted.
    pause
    goto :FileOps
) else (
    echo Invalid destination. Please enter a valid directory.
    pause
    goto :FileOps
)


:FileOps9
cls 
set /p file=Enter File you want to rename: 
set newFile=
setlocal enabledelayedexpansion
if exist "%file%" (
    set /p newFile=New File Name: 
    move "%file%" "!newFile!"
    echo File successfully renamed to "!newFile!".
    pause
    goto :FileOps
) else (
    echo File %file% doesn't exist.
    pause    
    goto :FileOps
)
endlocal


:FileOps10
cls
set currentDir=%cd%
set /p newDir=Enter path of Directory: 
if exist "%newDir%\" (
    cd "%newDir%"
    echo Changed directory to: & cd
    pause
    goto :FileOps
) else (
    echo The directory does not exist.
    pause
    goto :FileOps
)


:FileOps11
cls 
set /p file=Enter name of the file being replaced: 
set /p replace=Enter name of the file that is doing the replacing: 

if exist "%file%" (
    if exist "%replace%" (
        echo Replacing content of "%file%" with content of "%replace%"...
        copy /Y "%replace%" "%file%" >nul
        echo Replacement complete!
        pause
        goto :FileOps
    ) else (
        echo The replacing file "%replace%" does not exist.
        pause
        goto :FileOps
    )
) else (
    echo The file to be replaced "%file%" does not exist.
    pause
    goto :FileOps
)



:FileOps12
cls
set /p pathh=Enter Root directory: 
if exist "%pathh%\" (
    tree "%pathh%"
    pause
    goto FileOps

) else (
    echo Directory doesn't exist
    pause
    goto :FileOps
)

:FileOps13
cls
set /p directory=Enter Directory you want to copy: 
set /p destination=Enter Destination: 

if exist "%directory%\" (
    if exist "%destination%" (
        echo copying "%directory%" into "%destination%"...
        xcopy  /Y "%directory%" "%destination%" /E /H /C /I >nul
        echo Copy complete.
        pause
        goto :FileOps
    ) else (
        echo The destination directory "%destination%" does not exist.
        pause
        goto :FileOps
    )
) else (
    echo The source directory "%directory%" does not exist.
    pause
    goto :FileOps
)



:NetTools
cls
echo Network Tools Submenu 
echo _____________________________________________________________________________________________
echo:
echo 1. View the current password ^& ^logon restrictions for the computer
echo:
echo 2. Display current server or workgroup settings
echo:
echo 3. View the details of a particular user account
echo: 
echo 4. Stop and start a particular service
echo:
echo 5. Display network statistics of the workstation or server
echo:
echo 6. Display information about your connections
echo:
echo 7. Back
echo: 
set /p choice=Enter Choice(1-7): 
if "%choice%"=="1" goto :NetTools1
if "%choice%"=="2" goto :NetTools2
if "%choice%"=="3" goto :NetTools3
if "%choice%"=="4" goto :NetTools4
if "%choice%"=="5" goto :NetTools5
if "%choice%"=="6" goto :NetTools6
if "%choice%"=="7" goto :Start
echo Please input a number between 1 and 7 according to your needs & pause & goto :NetTools

:NetTools1
cls
net accounts
pause
goto :NetTools

:NetTools2
cls
net config workstation
pause
goto :NetTools


:NetTools3
cls
echo View Details of a Particular User Account
echo:
set /p username=Enter the username to view details: 

:: Check if the user exists
net user "%username%" >nul 2>&1
if %errorlevel%==0 (
    echo Displaying details for user: %username%
    net user "%username%"
    pause
    goto :NetTools
) else (
    echo User "%username%" does not exist. Please try again.
    pause
    goto :NetTools
)

:NetTools4
cls
set /p serviceName=Enter the name of the service: 
sc query "%serviceName%" | find /i "STATE" >nul 2>&1
if not %errorlevel%==0 (
    echo The service "%serviceName%" does not exist or is invalid.
    pause
    goto :NetTools
)

echo The service "%serviceName%" is valid.
setlocal enabledelayedexpansion
if %errorlevel%==0 (
    echo What do you want to ^do with the service?
    echo 1. Stop the service
    echo 2. Start the service
    echo 3. Restart the service
    set /p action=Enter your choice ^(1-3^)^: 

    if "!action!"=="1" (
        echo Stopping the service...
        net stop "%serviceName%"
        pause
        goto :NetTools
    ) else if "!action!"=="2" (
        echo Starting the service...
        net start "%serviceName%"
        pause
        goto :NetTools
    ) else if "!action!"=="3" (
        echo Restarting the service...
        net stop "%serviceName%"
        net start "%serviceName%"
        pause
        goto :NetTools
    ) else (
        echo Invalid action selected. Please choose a number between 1 and 3.
        pause
        goto :NetTools
    )
    endlocal
) else (
    echo The service "%serviceName%" does not exist. Please enter a valid service name.
    pause
    endlocal
    goto :NetTools
)

:NetTools5
cls
echo Choose to display network statistics:
echo:
echo 1. Workstation
echo 2. Server
echo 3. Back
set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" (
    echo Displaying network statistics for the workstation...
    net statistics workstation
    pause
    goto :NetTools5
) else if "%choice%"=="2" (
    echo Displaying network statistics for the server...
    net statistics server
    if %errorlevel% neq 0 (
        echo Server statistics are unavailable. This may occur if your machine is not configured as a server.
    )
    pause
    goto :NetTools5
) else if "%choice%"=="3" (
     goto :NetTools
) else (
    echo Invalid choice. Please select 1, 2, or 3.
    pause
    goto :NetTools5
)

:NetTools6
cls
echo Display Information About Your Connections:
echo:
echo 1. Display all active connections
echo 2. Display listening ports
echo 3. Display routing table
echo 4. Display statistics by protocol (TCP, UDP, etc...)
echo 5. Back
echo:
set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" (
    echo Displaying all active connections...
    netstat -an
    pause
    goto :NetTools6
) else if "%choice%"=="2" (
    echo Displaying all listening ports...
    netstat -an | find "LISTENING"
    pause
    goto :NetTools6
) else if "%choice%"=="3" (
    echo Displaying routing table...
    netstat -rn
    pause
    goto :NetTools6
) else if "%choice%"=="4" (
    echo Displaying protocol statistics...
    netstat -s
    pause
    goto :NetTools6
) else if "%choice%"=="5" (
    goto :NetTools
) else (
    echo Invalid choice. Please enter a number between 1 and 5.
    pause
    goto :NetTools6
)




:Process
cls
echo Process Management Submenu 
echo:
echo 1. View List of Running Processes
echo 2. Kill a Running Process
echo 3. Start a Process
echo 4. Back
set /p choice=Enter your choice(1-4): 
if "%choice%"=="1" goto :Process1
if "%choice%"=="2" goto :Process2
if "%choice%"=="3" goto :Process3
if "%choice%"=="4" goto :Start
echo Please input a number between 1 and 4 according to your needs & pause & goto :Process


:Process1
cls
tasklist
pause
goto :Process


:Process2
cls
set /p processName=Enter the name of the application^/process to kill: 
set "ext=%processName:~-4%"
if /i not "%ext%"==".exe" (
    set processName=%processName%.exe
)
tasklist | findstr /i /c:"%processName%" >nul 2>&1

if %errorlevel%==0 (
    echo The process "%processName%" exists.
    echo:
    echo Terminating the process "%processName%"
    taskkill /IM "%processName%" /F
    if %errorlevel%==0 (
        echo Process "%processName%" has been terminated successfully.
	pause
    	goto :Process
    ) else (
        echo Failed to terminate the process. Please ensure you have the required permissions.
        pause
        goto :Process
    )
) else (
    echo The process "%processName%" does not exist. Please try again.
    pause
    goto :Process
)


:Process3
cls
set /p processName=Enter the name of the application^/process you want to start: 
set "ext=%processName:~-4%" 
:: Check if it ends with .exe or not
if /i not "%ext%"==".exe" (
    set processName=%processName%.exe
)
:: Check if the application exists in the system PATH or is a valid executable
set "filePathhh="
setlocal enabledelayedexpansion
for /f "delims=" %%A in ('dir /b /s C:\%processName% 2^>nul') do set "filePathhh=%%A"
if not "!filePathhh!"=="" (
    echo Starting "%processName%"...
    start "" "!filePathhh!"
    echo "%processName%" started successfully!
    pause
    endlocal
    goto :Process
) else (
    echo The application "%processName%" does not exist or is not in the system PATH.
    echo Please enter a valid executable name.
    pause
    endlocal
    goto :Process
)


:Data
cls
echo Data Analysis Submenu 
echo:
echo 1. Search for a string within a file
echo 2. Sort the contents of a text file
echo 3. Search for a specific string in a text file
echo 4. Compare two files and display the differences
echo 5. Display the contents of a text file
echo 6. Display message "Hello, World!"
echo 7. Count the number of lines in a file
echo 8. Back
echo:

set /p choice=Enter your choice (1-8): 
if "%choice%"=="1" goto :Data1
if "%choice%"=="2" goto :Data2
if "%choice%"=="3" goto :Data3
if "%choice%"=="4" goto :Data4
if "%choice%"=="5" goto :Data5
if "%choice%"=="6" goto :Data6
if "%choice%"=="7" goto :Data7
if "%choice%"=="8" goto :Start
echo Please input a number between 1 and 8 according to your needs & pause & goto :Data


:Data1
cls
set /p file=Enter the name of the file you want to search in: 
setlocal enabledelayedexpansion
if exist "%file%" (
    echo The file "%file%" exists.
    set /p str=Enter the string you want to search for: 
    findstr /n /i "!str!" "%file%">nul
    if !errorlevel!==0 (
        echo String "!str!" found in the file.
        findstr /n /i "!str!" "%file%"
        echo:
        pause
        goto :Data
    ) else (
        echo String "!str!" not found in the file.
        pause						
        goto :Data
    endlocal
    )
) else (
    echo The file "%file%" does not exist.
    endlocal
    pause
    goto :Data
)

:Data2
cls
set /p file=Enter the name of the file you want to sort: 
if exist "%file%" (
    echo The file "%file%" exists
    sort "%file%"
    pause
    goto :Data
)

else (
    echo The file "%file%" doesn^'t exist.
    pause
    goto :Data
)


:Data3
cls
set /p file=Enter the name of the file you want to search in: 
setlocal enabledelayedexpansion
if exist "%file%" (
    echo The file %file% exists
    set /p str=Enter the specific string you want to search for: 
    findstr /n /c:"!str!" "%file%">nul 2>&1
    if !errorlevel! equ 0 (
        echo String "!str!" found in %file%
        findstr /n /c:"!str!" "%file%"
        echo:
        pause
        endlocal
        goto :Data
    ) else (
        echo String "!str!" ^not found in file %file%
        pause
        goto :Data    
        endlocal
    )
) else (
    echo The file %file% doesn^'t exist. 
    pause
    endlocal
    goto :Data
)

:Data4
cls
set /p file1=Enter the name of the first file: 
setlocal enabledelayedexpansion
if exist "%file1%" (
    echo The file "%file1%" exists.
    set /p file2=Enter the name of the second file to compare: 
    if exist "!file2!" (
	echo The file "!file2!" exists.
	echo:
        fc /W /N replace.txt Reports\search_results.txt
	pause 
	endlocal
	goto :Data
    ) else (
        echo The file "!file2!" doesn^t exist.
	pause
	endlocal
	goto :Data
    )

) else (
    echo The file "!file1!" doesn^'t exist.
    endlocal
    pause
    goto :Data
)


:Data5
cls
set /p file=Enter the name of the file you want to display: 
if exist "%file%" (
    type "%file%"
    pause
    goto :Data
) else (
    echo The file "%file%" doesn^t exist.
    pause
    goto :Data
)

:Data6
cls
echo Hello,World!
pause
goto :Data

:Data7
cls
set /p file=Enter the name of the file: 
if exist "%file%" (
    echo Number of lines in "%file%": 
    find /c /v "" "%file%"
    pause
    goto :Data
) else (
    echo The file "%file%" doesn^'t exist.
    pause
    goto :Data
)

:Exit
exit /b 0
