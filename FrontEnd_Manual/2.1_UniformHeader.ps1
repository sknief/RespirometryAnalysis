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
#################################################################


## Step 2: Change Headers 
$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*_cleaned.txt" -Recurse

foreach ($txtFile in $txtFiles) {
    # Read the content of the text file
    $content = Get-Content -Path $txtFile.FullName

    # Identify the header row and split it into column headers
    $originalHeaders = $content[0] -split '\s+'

    # Step 2.1: replace headers with index values (because they are different across channel files)
    $modifiedHeaders = for ($i = 0; $i -lt $originalHeaders.Count; $i++) {
        if ($i -lt 18) {
            "Variable$($i + 1)"
        }
        else {
            # Stop the loop after 18 index increases
            break
        }
    }

    # Replace the original header row with the modified column headers
    $content[0] = $modifiedHeaders -join "`t"

    # Write the updated content back to the text file
    $content | Set-Content -Path $txtFile.FullName
}