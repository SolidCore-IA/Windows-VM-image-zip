@echo on
:: NEW VIRTUAL MACHINE WINDOWS WORKSTATION SETUP
:: sets up key apps an configurations
title MS_WS_VM_SETUP
color 0c
::start
time /t
echo ?????DID YOU RUN AS ADMIN??.........
TIMEOUT -1
:: activate admin account. change password at run time.
net user administrator /active:yes
net user administrator CHANGEME 
:: disable UAC
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
:: disable activation for windows
REG add "HKLM\SYSTEM\CurrentControlSet\services\WatAdminSvc" /v Start /t REG_DWORD /d 4 /f
::enable verbose info on shutdown/startup
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f
:: disabe hybernation
powercfg.exe /hibernate off
::start remote registry
sc config RemoteRegistry start= auto
sc start RemoteRegistry
::allow remote connections
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
::other reg tweaks
reg import C:\Tweaks.reg
::reset internet
::firewall off
netsh advfirewall set allprofiles state off
:: set netsh IP info to related info
netsh interface ipv4 set address name="Local Area Connection" static 10.0.0.0 255.255.255.0 10.0.0.1
ipconfig /release
ipconfig /renew
ipconfig /flushdns
ipconfig /registerdns
:: install base apps
::ninite
start C:\ninite_ms_installer.exe
::end script
echo ...
msg * "System base started"
TIMEOUT /T -1