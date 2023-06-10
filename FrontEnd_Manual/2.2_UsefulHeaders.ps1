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


$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*_cleaned.txt" -Recurse

foreach ($txtFile in $txtFiles) {
    # Read the content of the text file
    $content = Get-Content -Path $txtFile.FullName

    

    # Identify the header row and split it into column headers
    $originalHeaders = $content[0] -split '\s+'

    # Step 2.2: Modify the column headers with desired names
    $modifiedHeaders = $originalHeaders     -replace 'Variable18', 'Status_P' `
                                            -replace 'Variable17', 'Pressure' `
                                            -replace 'Variable16', 'dt_P' `
                                            -replace 'Variable15', 'Time_P '`
                                            -replace 'Variable14', 'Date_P' `
                                            -replace 'Variable13', 'Status_T' `
                                            -replace 'Variable12', 'Temp' `
                                            -replace 'Variable11', 'dt_T' `
                                            -replace 'Variable10', 'Time_T' `
                                            -replace 'Variable9', 'Date_T' `
                                            -replace 'Variable8', 'Status' `
                                            -replace 'Variable7', 'AmbLi' `
                                            -replace 'Variable6', 'SignalInt' `
                                            -replace 'Variable5', 'dphi' `
                                            -replace 'Variable4', 'Oxygen' `
                                            -replace 'Variable3', 'dt' `
                                            -replace 'Variable2', 'Time' `
                                            -replace 'Variable1', 'Date'

    # Replace the original header row with the modified column headers
    $content[0] = $modifiedHeaders -join "`t"

    # Write the updated content back to the text file
    $outputFile = Join-Path -Path $txtFile.Directory.FullName -ChildPath ($txtFile.BaseName + "_headed.txt")
    $content | Set-Content -Path $outputFile
}
