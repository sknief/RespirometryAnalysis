# Specify the root folder containing the txt files and subfolders
$rootFolderPath = "C:\Users\sknie\Desktop\pipetest"

## Step 1 goes here
# Get the list of txt files in the root folder and subfolders
#$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*.txt" -Recurse


## Step 2: Change Headers 
$txtFiles = Get-ChildItem -Path $rootFolderPath -Filter "*_cleaned.txt" -Recurse

foreach ($txtFile in $txtFiles) {
    # Read the content of the text file
    $content = Get-Content -Path $txtFile.FullName

    # Identify the header row and split it into column headers
    $originalHeaders = $content[0] -split '\s+'

    #Step 2.1: replace headers with index values (because they are different across channel files)

            # Modify the column headers
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
        $content[0] = $modifiedHeaders[0..17] -join ' '

        # Write the updated content back to the text file
        $content | Set-Content -Path $txtFile.FullName
    
    }
