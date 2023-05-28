$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"

# Get all subfolders in the root folder
$subfolders = Get-ChildItem -Path $rootFolderPath -Directory

foreach ($subfolder in $subfolders) {
    # Specify the output file path for the current subfolder
    $outputFilePath = Join-Path -Path $subfolder.FullName -ChildPath "TestOutput.txt"

    # Get all text files within the current subfolder
    $txtFiles = Get-ChildItem -Path $subfolder.FullName -Filter "*_cleaned_headed_trimmed.txt" -Recurse

    # Create a hashtable to store selected columns for each file in the subfolder
    $selectedColumns = @{}

    # Process each text file in the subfolder
    foreach ($txtFile in $txtFiles) {
        # Read the content of the current text file
        $content = Get-Content -Path $txtFile.FullName

        # Select the desired column from each row
        $column = $content | ForEach-Object {
            # Split the row into columns using the delimiter (e.g., tab or comma)
            $columns = $_ -split "`t"

            # Select the desired column index (0-based index)
            $selectedColumn = $columns[2]  # Replace 0 with the desired column index

            # Output the selected column
            $selectedColumn
        }

        $originalHeaders = $column[0] -split '\s+'

        # Check if the source file name meets a certain condition
        if ($txtFile.FullName -like "*(B Ch1)*.txt") {
            # Rename the column
            $modifiedHeaders = $originalHeaders -replace 'Oxygen', 'Ch1'
        }
        else {
            $modifiedHeaders = $originalHeaders -replace 'Oxygen', 'NotCh1'
        }

        $column[0] = $modifiedHeaders -join "`t"

        # Add the selected column to the hashtable with the filename as the key
        $selectedColumns[$txtFile.Name] = $column
    }

    # Write the collated data to the output file for the current subfolder
    $selectedColumns.GetEnumerator() | ForEach-Object {
        # Create a string with the filename as the column header
        $header = $_.Key

        # Create a string with the column data, joined by a tab delimiter
        $columnData = $_.Value -join "`t"

        # Output the column header followed by the column data
        $header, $columnData
    } | Out-File -FilePath $outputFilePath
}
