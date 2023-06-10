 ########################################################
##                FIRESTING PIEPELINE                 ##
##                   BY KNIEF.CODES                   ##
##  ------------------------------------------------- ##
##               AUTHOR: STELLA MS KNIEF              ##
##      START DATE: 26/05/2023 PUBLISH: 29/05/23      ##
##                    VERSION 1.0                     ##
##       CITE WHAT YOU USE, KO-FI IF YOU'RE NICE      ##
########################################################

## User input here!! ############################################
# Specify the root folder containing the txt files and subfolders
$rootFolderPath = "C:\Users\sknie\OneDrive - The University of Queensland\RESP_DATA"
$outputFilePath = "C:\Users\sknie\OneDrive - The University of Queensland\RESP_DATA\subfolder_names.csv"
$RScriptLocation = "C:\Users\sknie\Documents\GitHub\RespirometryAnalysis\DataCleaning\4.1_Frankenstein.R" 
#################################################################


# Get all subfolders in the root folder
$subfolders = Get-ChildItem -Path $rootFolderPath -Directory
 
# Create Working Files
foreach ($subfolder in $subfolders) {
    $outputFolderPath = Join-Path -Path $subfolder.FullName -ChildPath "Files"
 #Time to Frankenstein it in R cause Powershell is making me lose my will to live
  Rscript.exe $RScriptLocation
}
