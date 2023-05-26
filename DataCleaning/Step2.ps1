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
      $originalHeaders = $content[0] -split 

      # Write the updated content back to the text file
      $content | Set-Content -Path $txtFile.FullName
  



  #Step 2.2: then redo these with names that matter

    # Modify the column headers
    $modifiedHeaders2 = $modifiedHeaders1 | ForEach-Object {
        # Apply any desired modifications
        $_ | Select-String 'Variable1' | ForEach-Object { $_ -replace 'Variable1', 'Date' } |
            Select-String 'Variable2' | ForEach-Object { $_ -replace 'Variable2', 'Time' } |
            Select-String 'Variable3' | ForEach-Object { $_ -replace 'Variable3', 'Oxygen' } |
            Select-String 'Variable4' | ForEach-Object { $_ -replace 'Variable4', 'dphi' } |
            Select-String 'Variable5' | ForEach-Object { $_ -replace 'Variable5', 'SignalIntensity' } |
            Select-String 'Variable6' | ForEach-Object { $_ -replace 'Variable6', 'AmbLight' } |
            Select-String 'Variable7' | ForEach-Object { $_ -replace 'Variable7', 'Status' } |
            Select-String 'Variable8' | ForEach-Object { $_ -replace 'Variable8', 'Date_T' } |
            Select-String 'Variable9' | ForEach-Object { $_ -replace 'Variable9', 'Time_T' } |
            Select-String 'Variable10' | ForEach-Object { $_ -replace 'Variable10', 'dt_T' } |
            Select-String 'Variable11' | ForEach-Object { $_ -replace 'Variable11', 'SampleTemp' } |
            Select-String 'Variable12' | ForEach-Object { $_ -replace 'Variable12', 'Status_T' } |
            Select-String 'Variable13' | ForEach-Object { $_ -replace 'Variable13', 'Date_P' } |
            Select-String 'Variable14' | ForEach-Object { $_ -replace 'Variable14', 'Time_P' } |
            Select-String 'Variable15' | ForEach-Object { $_ -replace 'Variable15', 'dt_P' } |
            Select-String 'Variable16' | ForEach-Object { $_ -replace 'Variable16', 'Pressure' } |
            Select-String 'Variable17' | ForEach-Object { $_ -replace 'Variable17', 'Status_P' } |
            Select-String 'Variable18' | ForEach-Object { $_ -replace 'Variable18', 'Status_T' }
    }

        # Replace the original header row with the modified column headers
        $content[0] = $modifiedHeaders2 -join ' '

        # Write the updated content back to the text file
        $content | Set-Content -Path $txtFile2.FullName
    }

