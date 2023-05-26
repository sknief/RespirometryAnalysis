# Specify the root folder containing the txt files and subfolders
$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"

$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*_cleaned.txt" -Recurse

foreach ($txtFile in $txtFiles) {
    # Read the content of the text file
    $content = Get-Content -Path $txtFile.FullName

    # Identify the header row and split it into column headers
    $originalHeaders = $content[0] -split '\s+'

    # Step 2.2: Modify the column headers with desired names
    $modifiedHeaders = $originalHeaders     -replace 'Variable18', 'Status_T' `
                                            -replace 'Variable17', 'Status_P' `
                                            -replace 'Variable16', 'Pressure' `
                                            -replace 'Variable15', 'dt_P' `
                                            -replace 'Variable14', 'Time_P' `
                                            -replace 'Variable13', 'Date_P' `
                                            -replace 'Variable12', 'Status_T' `
                                            -replace 'Variable11', 'SampleTemp' `
                                            -replace 'Variable10', 'dt_T' `
                                            -replace 'Variable9', 'Time_T' `
                                            -replace 'Variable8', 'Date_T' `
                                            -replace 'Variable7', 'Status' `
                                            -replace 'Variable6', 'AmbLight' `
                                            -replace 'Variable5', 'SignalIntensity' `
                                            -replace 'Variable4', 'dphi' `
                                            -replace 'Variable3', 'Oxygen' `
                                            -replace 'Variable2', 'Time' `
                                            -replace 'Variable1', 'Date'

    # Replace the original header row with the modified column headers
    $content[0] = $modifiedHeaders -join "`t"

    # Write the updated content back to the text file
    $outputFile = Join-Path -Path $txtFile.Directory.FullName -ChildPath ($txtFile.BaseName + "_headed.txt")
    $content | Set-Content -Path $outputFile
}
