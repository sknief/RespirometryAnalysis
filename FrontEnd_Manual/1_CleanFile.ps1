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
$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"
#################################################################

# Get the list of txt files in the root folder and subfolders
$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*.txt" -Recurse

# Loop over each txt file
foreach ($txtFile in $txtFiles) {
    # Read the txt file and skip the first 12 lines
    $data = Get-Content -Path $txtFile.FullName | Select-Object -Skip 24

    # Save the modified content to a new file with "_modified" appended to the original filename
    $outputFile = Join-Path -Path $txtFile.Directory.FullName -ChildPath ($txtFile.BaseName + "_cleaned.txt")
    $data | Set-Content -Path $outputFile
}
