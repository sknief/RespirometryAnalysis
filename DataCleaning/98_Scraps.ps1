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

    
    #Time to Frankenstein it in R cause Powershell is making me lose my will to live
    $RScriptLocation = "C:\Users\sknie\Documents\GitHub\RespirometryAnalysis\DataCleaning\4.1_Frankenstein.R"
    Rscript.exe $RScriptLocation


}
