# Shell script to clean up data and prepare files for analysis

#move to data folder
Set-Location C:/Users/sknie/OneDrive/PhD_Vault/Chapter2/Data/RespirometryAnalysisV1/RawData

#set up variables
$RootFolder = "C:/Users/sknie/OneDrive/PhD_Vault/Chapter2/Data/RespirometryAnalysisV1/RawData"
$SubFolders = Get-ChildItem -Path $RootFolder -Directory

#loop to clean up file names and remove the additional lines from the txt files
Foreach($Folder in $SubFolders)
{
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(A Ch.1)_Oxygen.txt" -Destination "$Folder/ChannelData/A1.txt"
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(A Ch.2)_Oxygen.txt" -Destination "$Folder/ChannelData/A2.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(A Ch.3)_Oxygen.txt" -Destination "$Folder/ChannelData/A3.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(A Ch.4)_Oxygen.txt" -Destination "$Folder/ChannelData/A4.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(B Ch.1)_Oxygen.txt" -Destination "$Folder/ChannelData/B1.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(B Ch.2)_Oxygen.txt" -Destination "$Folder/ChannelData/B2.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(B Ch.3)_Oxygen.txt" -Destination "$Folder/ChannelData/B3.txt" 
   Copy-Item "$Folder/ChannelData/Firesting O2 (4 Channels)_(B Ch.4)_Oxygen.txt" -Destination "$Folder/ChannelData/B4.txt" 

   Get-Content "$Folder/ChannelData/A1.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/A1_R.txt"
   Get-Content "$Folder/ChannelData/A2.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/A2_R.txt"
   Get-Content "$Folder/ChannelData/A3.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/A3_R.txt"
   Get-Content "$Folder/ChannelData/A4.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/A4_R.txt"
   Get-Content "$Folder/ChannelData/B1.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/B1_R.txt"
   Get-Content "$Folder/ChannelData/B2.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/B2_R.txt"
   Get-Content "$Folder/ChannelData/B3.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/B3_R.txt"
   Get-Content "$Folder/ChannelData/B4.txt" | Select-Object -Skip 24 | Out-File "$Folder/ChannelData/B4_R.txt"
}

#now i need a few more commands to move the files I want to a new folder, might just manually do that like I used to for honours


##########
