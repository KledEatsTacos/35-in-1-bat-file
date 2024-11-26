@echo off
chcp 65001
cls

:MENU
echo 1. Show Computer Serial Number, Name, Brand, and Model
echo 2. Display IP Address
echo 3. Show Windows License Status
echo 4. Display System Information
echo 5. Windows Version Information (winver)
echo 6. Show Last Format Date
echo 7. Check Disk Status
echo 8. Show Windows Update Status
echo 9. Show CPU Information
echo 10. Show Memory (RAM) Usage
echo 11. Update Group Policies (gpupdate /force)
echo 12. List User Accounts
echo 13. Show Storage Status
echo 14. Scan Hard Disk (chkdsk)
echo 15. Disable Firewall
echo 16. Enable Firewall
echo 17. Repair Windows System Files
echo 18. Start Disk Cleanup (cleanmgr)
echo 19. Update All Programs
echo 20. Update Windows Store Applications
echo 21. Clear Network DNS Cache (flushdns)
echo 22. Clean Unnecessary Files (temp)
echo 23. Perform RAM Optimization
echo 24. Perform Ping Test
echo 25. Perform Tracert (Route Tracking)
echo 26. Perform Nslookup (DNS Query)
echo 27. Show Netstat (Connection Status)
echo 28. Show ARP (Address Resolution Protocol) Table
echo 29. Show Route (Routing Table)
echo 30. Show Nbtstat (NetBIOS Status)
echo 31. Display IP Configuration (all)
echo 32. Release IP Configuration (release)
echo 33. Renew IP Configuration (renew)
echo 34. Show Wi-Fi Password
echo 35. Exit

set /p choice=Enter a choice (1-35): 

if "%choice%"=="1" goto COMPUTER_INFO
if "%choice%"=="2" goto IP
if "%choice%"=="3" goto LICENSE
if "%choice%"=="4" goto SYSINFO
if "%choice%"=="5" goto WINVER
if "%choice%"=="6" goto LAST_FORMAT_DATE
if "%choice%"=="7" goto DISK
if "%choice%"=="8" goto WINDOWSUPDATE
if "%choice%"=="9" goto CPUINFO
if "%choice%"=="10" goto MEMORY
if "%choice%"=="11" goto GPUPDATE
if "%choice%"=="12" goto USERS
if "%choice%"=="13" goto STORAGE
if "%choice%"=="14" goto CHKDSK
if "%choice%"=="15" goto DISABLE_FIREWALL
if "%choice%"=="16" goto ENABLE_FIREWALL
if "%choice%"=="17" goto SFC
if "%choice%"=="18" goto CLEANUP
if "%choice%"=="19" goto UPDATE_PROGRAMS
if "%choice%"=="20" goto UPDATE_STORE_APPS
if "%choice%"=="21" goto CLEAR_DNS
if "%choice%"=="22" goto CLEAN_TEMP_FILES
if "%choice%"=="23" goto OPTIMIZE_RAM
if "%choice%"=="24" goto PING_TEST
if "%choice%"=="25" goto TRACERT_TEST
if "%choice%"=="26" goto NSLOOKUP_TEST
if "%choice%"=="27" goto NETSTAT_TEST
if "%choice%"=="28" goto ARP_TEST
if "%choice%"=="29" goto ROUTE_TEST
if "%choice%"=="30" goto NBTSTAT_TEST
if "%choice%"=="31" goto IPCONFIG
if "%choice%"=="32" goto RELEASE_IP
if "%choice%"=="33" goto RENEW_IP
if "%choice%"=="34" goto WIFI_PASSWORD
if "%choice%"=="35" exit
goto MENU

:: Show Computer Serial Number, Name, Brand, and Model
:COMPUTER_INFO
cls
echo Computer Serial Number:
wmic bios get serialnumber
echo.
echo Computer Name:
hostname
echo.
echo Brand and Model:
wmic computersystem get manufacturer, model
pause
goto MENU

:: Display IP Address
:IP
cls
echo Computer IP Address:
ipconfig | findstr /i "IPv4"
pause
goto MENU

:: Show Windows License Status
:LICENSE
cls
echo Windows License Status:
slmgr /xpr
echo.
echo Windows License Key:
wmic path softwarelicensingservice get OA3xOriginalProductKey
pause
goto MENU

:: Display System Information
:SYSINFO
cls
echo System Information:
systeminfo
pause
goto MENU

:: Windows Version Information (winver)
:WINVER
cls
echo Windows Version Information:
winver
pause
goto MENU

:: Show Last Format Date
:LAST_FORMAT_DATE
cls
echo Last Format Date:
wmic os get installdate
pause
goto MENU

:: Check Disk Status
:DISK
cls
echo Disk Status:
wmic logicaldisk get caption, description, freespace, size
pause
goto MENU

:: Show Windows Update Status
:WINDOWSUPDATE
cls
echo Windows Update Status:
wmic qfe list brief /format:table
pause
goto MENU

:: Show CPU Information
:CPUINFO
cls
echo CPU Information:
wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed
pause
goto MENU

:: Show Memory (RAM) Usage
:MEMORY
cls
echo Memory (RAM) Usage:
wmic memorychip get capacity, speed, manufacturer
pause
goto MENU

:: Update Group Policies (gpupdate /force)
:GPUPDATE
cls
echo Updating Group Policies...
gpupdate /force
pause
goto MENU

:: List User Accounts
:USERS
cls
echo User Accounts:
net user
pause
goto MENU

:: Show Storage Status
:STORAGE
cls
echo Storage Status:
wmic logicaldisk get caption, description, freespace, size
pause
goto MENU

:: Scan Hard Disk (chkdsk)
:CHKDSK
cls
echo Scanning hard disk...
chkdsk C: /f /r /x
pause
goto MENU

:: Disable Firewall
:DISABLE_FIREWALL
cls
echo Disabling Firewall...
netsh advfirewall set allprofiles state off
pause
goto MENU

:: Enable Firewall
:ENABLE_FIREWALL
cls
echo Enabling Firewall...
netsh advfirewall set allprofiles state on
pause
goto MENU

:: Repair Windows System Files
:SFC
cls
echo Scanning system files...
sfc /scannow
pause
goto MENU

:: Start Disk Cleanup
:CLEANUP
cls
echo Starting Disk Cleanup...
cleanmgr
pause
goto MENU

:: Update All Programs (winget)
:UPDATE_PROGRAMS
cls
echo Updating installed programs...
winget upgrade --all
pause
goto MENU

:: Update Windows Store Applications
:UPDATE_STORE_APPS
cls
echo Updating Windows Store applications...
powershell -Command "Get-AppxPackage | Foreach {Add-AppxPackage -Path $_.InstallLocation} "
pause
goto MENU

:: Clear Network DNS Cache
:CLEAR_DNS
cls
echo Clearing DNS Cache...
ipconfig /flushdns
pause
goto MENU

:: Clean Unnecessary Files
:CLEAN_TEMP_FILES
cls
echo Cleaning temporary files...

:: Delete files in %TEMP% folder
del /q /f /s %TEMP%\*

:: Delete files in %WINDIR%\Temp folder
del /q /f /s %WINDIR%\Temp\*

:: Clean Windows Temp folder
cleanmgr /sagerun:1

echo Cleaning completed.
pause
goto MENU

:: Perform RAM Optimization
:OPTIMIZE_RAM
cls
echo Performing RAM optimization...
echo.
echo Terminating running processes...
echo.
taskkill /f /im explorer.exe
start explorer.exe
pause
goto MENU

:: Perform Ping Test
:PING_TEST
cls
echo Performing ping test...
set /p ip=Enter IP address for ping test: 
ping %ip%
pause
goto MENU

:: Perform Tracert (Route Tracking)
:TRACERT_TEST
cls
echo Starting tracert (route tracking)...
set /p ip=Enter IP address for route tracking: 
tracert %ip%
pause
goto MENU

:: Perform Nslookup (DNS Query)
:NSLOOKUP_TEST
cls
echo Starting nslookup (DNS query)...
set /p domain=Enter domain for DNS query: 
nslookup %domain%
pause
goto MENU

:: Show Netstat (Connection Status)
:NETSTAT_TEST
cls
echo Starting netstat (connection status)...
netstat -an
pause
goto MENU

:: Show ARP Table
:ARP_TEST
cls
echo Starting ARP table...
arp -a
pause
goto MENU

:: Show Route Table
:ROUTE_TEST
cls
echo Starting route table...
route print
pause
goto MENU

:: Show Nbtstat (NetBIOS Status)
:NBTSTAT_TEST
cls
echo Starting nbtstat (NetBIOS status)...
nbtstat -n
pause
goto MENU

:: Display IP Configuration
:IPCONFIG
cls
echo IP Configuration:
ipconfig
pause
goto MENU

:: Release IP Configuration
:RELEASE_IP
cls
echo Releasing IP configuration...
ipconfig /release
pause
goto MENU

:: Renew IP Configuration
:RENEW_IP
cls
echo Renewing IP configuration...
ipconfig /renew
pause
goto MENU

:: Show Wi-Fi Password
:WIFI_PASSWORD
cls
echo Wi-Fi Password:
set /p wifi=Enter Wi-Fi network name: 
netsh wlan show profile name="%wifi%" key=clear | findstr /i "Key Content"
pause
goto MENU