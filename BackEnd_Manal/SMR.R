###### Knief.codes Respirometry Data Analysiss#####
### Date : 05/07/23

library(dplyr)

## Step 1: Clean up CSV file 
FishData <- subset(FishData, select = c(1:7)) #remove unnessecary artifacts
# needs code to exclude the unknown fish (999999, 777777, 888888)

## Step 2: Mock up fish weights over time
FishMass <- subset(FishMass, select = c(1:6))
FishMass$GrowthRate <- (FishMass$FinalWeight - FishMass$StartWeight)/FishMass$Lifespan
FishMass$Fish <- FishMass$Fish.ID

Mass_Formula <- "FishMass = StartWeight + (GrowthRate * Day)"
#need to get growthrate into FishData file by the fish ID

## Step 3: Calculate SMR
FishMerge <- left_join(FishData, FishMass, by = "Fish")

RespVol <- 2200

SMR_Formula <- "SMR = ((RespVol - FishVol) * Slope) / (Time - FishMass)" 

