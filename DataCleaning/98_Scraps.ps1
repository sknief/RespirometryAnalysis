$csvFiles = "C:\Users\sknie\Desktop\pipetest\2023-02-18_133424_COHORT A RESP DAY 5\Files\Ch1_A_WorkingFile.csv", "C:\Users\sknie\Desktop\pipetest\2023-02-18_133424_COHORT A RESP DAY 5\Files\Ch2_A_WorkingFile.csv", "C:\Users\sknie\Desktop\pipetest\2023-02-18_133424_COHORT A RESP DAY 5\Files\Ch3_A_WorkingFile.csv"
$outputFilePath = "C:\Users\sknie\Desktop\pipetest\2023-02-18_133424_COHORT A RESP DAY 5\Files\AAAAAAAAAAA.csv"

# Initialize an empty hashtable to store the combined data
$combinedData = @{}

# Iterate over each CSV file
foreach ($csvFile in $csvFiles) {
    # Get the file name without extension
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($csvFile)

    # Read the CSV file
    $csvData = Import-Csv $csvFile

    # Iterate over each column in the CSV data
    foreach ($column in $csvData | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name) {
        # Generate the column header using the file name
        $header = "$fileName - $column"

        # Check if the column already exists in the combined data
        if ($combinedData.ContainsKey($header)) {
            # If the column already exists, append the data from the current CSV file
            $combinedData[$header] += $csvData.$column
        } else {
            # If the column doesn't exist, create a new entry in the combined data
            $combinedData[$header] = $csvData.$column
        }
    }
}

# Convert the hashtable to a custom object to ensure consistent column order
$combinedObject = [PSCustomObject]$combinedData

# Export the combined data to a new CSV file
$combinedObject | Export-Csv -Path $outputFilePath -NoTypeInformation
