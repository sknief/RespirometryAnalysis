# Specify the root folder containing the txt files and subfolders
$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"

## Step 3: Remove Unneccessary Variables
$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*_cleaned_headed.txt" -Recurse

# Specify the columns to delete (0-based index)
#$columnsToDelete = 2, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17
#$columnsToDelete = 17, 16, 15, 14, 13, 12, 10, 9, 8, 7, 6, 5, 4, 2

foreach ($txtFile in $txtFiles) {
    
# Read the content of the input file
$content = Get-Content -Path $txtFile.FullName

# Process each row and select the first three columns
$modifiedContent = $content | ForEach-Object {
    # Split the row into columns using the delimiter (e.g., tab or space)
    $columns = $_ -split "`t"

    # Select the first three columns
    $selectedColumns = $columns[0, 1, 3, 11 ]

    # Join the selected columns back together
    $selectedRow = $selectedColumns -join "`t"

    # Output the modified row
    $selectedRow
}
     # Write the updated content back to the text file
    $outputFile = Join-Path -Path $txtFile.Directory.FullName -ChildPath ($txtFile.BaseName + "_trimmed.txt")
    $modifiedContent | Set-Content -Path $outputFile -Force
}

