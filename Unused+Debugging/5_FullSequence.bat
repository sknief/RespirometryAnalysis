: Delete this line for debugging purposes
@ECHO OFF 

Powershell.exe -NoProfile -ExecutionPolicy Bypass -File  C:\Users\sknie\Documents\GitHub\RespirometryAnalysis\DataCleaning\1_CleanFile.ps1

: If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}
