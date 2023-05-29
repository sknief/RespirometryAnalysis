$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"

# Get all subfolders in the root folder
$subfolders = Get-ChildItem -Path $rootFolderPath -Directory

$outputFilePath = "C:\Users\sknie\Desktop\pipetest\subfolder_names.csv"

# Create an array to store subfolder names
$subfolderNames = @()

foreach ($subfolder in $subfolders) {
    # Add the subfolder name to the array
    $subfolderNames += $subfolder.Name
}

# Save the subfolder names as a text file
$subfolderNames | Out-File -FilePath $outputFilePath -Encoding utf8
#that works



foreach ($subfolder in $subfolders) {
    $outputFolderPath = Join-Path -Path $subfolder.FullName -ChildPath "Files"
    

    New-Item -ItemType Directory -Path $outputFolderPath -Force


    # Making of working files and isolating all the information needed.
    $txtFiles = Get-ChildItem -Path $subfolder.FullName -Filter "*_cleaned_headed_trimmed.txt" -Recurse

    # Process each text file
    foreach ($txtFile in $txtFiles) {
        Write-Host "Processing file: $($txtFile.FullName)"
        
        # Read the content of the current text file
        $content = Get-Content -Path $txtFile.FullName
       

        if ($txtFile.Name -like "*`(A Ch.1`)*.txt") {
            Write-Host "Matched pattern: *`(A Ch.1`)*.txt"
           #all of this is like. fine. 
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch1_A_WorkingFile.csv")
            $blank = New-Item -ItemType File -Path $outputFile -Force
            $content | Set-Content $blank
            #Copy-Item -Path $txtFile.FullName -Destination $outputFile 
            #$csvVersion | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(A Ch.2`)*.txt") {
            Write-Host "Matched pattern: *`(A Ch.2`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch2_A_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8

        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(A Ch.3`)*.txt") {
            Write-Host "Matched pattern: *`(A Ch.3`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch3_A_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(A Ch.4`)*.txt") {
            Write-Host "Matched pattern: *`(A Ch.4`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch4_A_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

## all the B's

        if ($txtFile.Name -like "*`(B Ch.1`)*.txt") {
            Write-Host "Matched pattern: *`(B Ch.1`)*.txt"
            # Save the column of interest in the hashtable
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch1_B_WorkingFile.csv")
            $content | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(B Ch.2`)*.txt") {
            Write-Host "Matched pattern: *`(B Ch.2`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch2_B_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(B Ch.3`)*.txt") {
            Write-Host "Matched pattern: *`(B Ch.3`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch3_B_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }

        if ($txtFile.Name -like "*`(B Ch.4`)*.txt") {
            Write-Host "Matched pattern: *`(B Ch.4`)*.txt"
            # Save the column of interest in the hashtable
           
            $modifiedContent = $content | ForEach-Object {
                # Split the row into columns using the delimiter (e.g., tab or space)
                $columns = $_ -split "`t"
            
                # Select the first three columns
                $selectedColumns = $columns[2]
                # Output the modified row
                $selectedColumns
            }
            $outputFile = Join-Path -Path $outputFolderPath -ChildPath ("Ch4_B_WorkingFile.csv")
            $modifiedContent | Out-File -FilePath $outputFile -Encoding utf8
        }
        else {
            Write-Host "Wrong File!"
        }
    }

    #Time to Frankenstein it in R cause Powershell is making me lose my will to live
   # $RScriptLocation = "C:\Users\sknie\Documents\GitHub\RespirometryAnalysis\DataCleaning\4.1_Frankenstein.R"
    #Rscript.exe $RScriptLocation


}

# Now to frankenstein them

