Stop-service “wauserv”
dism /online /cleanup-image /spsuperseded
Remove-item -path C:\Windows\SoftwareDistribution\ -recurse
Remove-item -path C:\Windows\Temp\* -recurse
Remove-item -path C:\users\*\appdata\local\temp* -recurse
Remove-item -path C:\users\*\downloads\* -recurse
>Optimize-Volume -DriveLetter C -Defrag -Verbose 
cleanmgr.exe /SAGESET:600
cleanmgr.exe /SAGERUN:600
Set-path C:\msserver-kit\
.\ccsetup*\CCleaner64.exe /AUTO
sdelete.exe -z C:\
Remove-item -path C:\msserver-kit\ -recurse
C:\windows\system32\sysprep\sysprep.exe /generalize /oobe /shutdown /quiet