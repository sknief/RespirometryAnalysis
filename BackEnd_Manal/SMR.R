###### Knief.codes Respirometry Data Analysis#####
### Date : 05/07/23

#Packages
library(dplyr)
library(ggplot2)

######## Step 1: Clean up CSV file ##########
#remove unnessecary artifacts
FishData <- subset(FishData, select = c(1:8)) 
#get rid of unknown fish entries (for now)
FishData_Scaled <-FishData[!(FishData$Fish == "999999" | FishData$Fish == "888888" | FishData$Fish == "777777"),]
FishMass <- subset(FishMass, select = c(1:6))

######## Step 2: Mock up fish weights over time ########
FishMass$GrowthRate <- (FishMass$FinalWeight - FishMass$StartWeight)/FishMass$Lifespan
FishMass$Fish <- FishMass$Fish.ID
#join the two files
FishMerge <- left_join(FishData_Scaled, FishMass, by = "Fish")
#calculate the weight of fish each day
FishMerge$CurrentWeight <- FishMerge$StartWeight + (FishMerge$DayofLife * FishMerge$GrowthRate) 
# clean up dataset again and turn it into a new dataframe
FishMerge_SMR <- subset(FishMerge, select = c(1:7, 16))
colnames(FishMerge_SMR) <- c("Day", "Cohort", "Respirometer", "Fish", "Treatment", "Slope_sec", "Temp", "CurrentWeight")
FishMerge_SMR <- na.omit(FishMerge_SMR)

######## Step 3: Calculate SMR ########
RespVol <- 2200
Time <- 3.86 #hours taken from seconds in the labchart thingy (not sure how accurate this is)
#convert slope_sec to slope_hour (*3600)
FishMerge_SMR$Slope_hour <- FishMerge_SMR$Slope_sec * 3600
#two types of SMR
FishMerge_SMR$SMR <-((RespVol - FishMerge_SMR$CurrentWeight) * FishMerge_SMR$Slope_hour) / (Time - FishMerge_SMR$CurrentWeight) #from paper, looks whack
FishMerge_SMR$SMR2 <- ((-1*((FishMerge_SMR$Slope_hour)/100)*((RespVol-FishMerge_SMR$CurrentWeight)/1000))*8.74) #from Barb's excel sheet

######## Step 4: Analysis Attempt No. 1 ########
#exclude the boost ones for now cause of sequence error
FishMerge_SMR_NoBoost <- FishMerge_SMR[!(FishMerge_SMR$Cohort == "AB"),]














####$$$$$$$$$ CODE GRAVEYARD $$$$$$$$$$$####

#experimental plot of all
Testplot <- ggplot(FishMerge_SMR_NoBoost, aes(x = Day, y = SMR2))
Testplot + geom_jitter(aes(col = FishMerge_SMR_NoBoost$Treatment, shape = FishMerge_SMR_NoBoost$Cohort))

#subset by the two treatments
FishControl <- FishMerge_SMR[(FishMerge_SMR_NoBoost$Treatment == "Control"),]
FishChallenge <- FishMerge_SMR[(FishMerge_SMR_NoBoost$Treatment == "Challenge"),]

MeanFishControl <- FishControl %>%
  group_by(Day) %>%
  summarise(meanSMR = mean(SMR2))

MeanFishTreatment <- FishChallenge %>%
  group_by(Day) %>%
  summarise(meanSMR = mean(SMR2))

MeanFishControl$Treatment <- "Control"
MeanFishTreatment$Treatment <- "Treatment"

MeanFish <- bind_rows(MeanFishControl, MeanFishTreatment)

Testplot2 <- ggplot(MeanFish, aes(x = Day, y = meanSMR))
Testplot2 + geom_line(aes(col = MeanFish$Treatment))

### seperate the cohorts

CohortB <- FishMerge_SMR_NoBoost[!(FishMerge_SMR$Cohort == "A"),]
Testplot3 <- ggplot(CohortB, aes(x = Day, y = SMR2))
Testplot3 + geom_point(aes(col = CohortB$Treatment))

#subset by the two treatments
FishControlB <- CohortB[(CohortB$Treatment == "Control"),]
FishChallengeB <- CohortB[(CohortB$Treatment == "Challenge"),]

MeanFishControl <- FishControl %>%
  group_by(Day) %>%
  summarise(meanSMR = mean(SMR2))

MeanFishTreatment <- FishChallenge %>%
  group_by(Day) %>%
  summarise(meanSMR = mean(SMR2))

MeanFishControl$Treatment <- "Control"
MeanFishTreatment$Treatment <- "Treatment"

MeanFish <- bind_rows(MeanFishControl, MeanFishTreatment)

Testplot2 <- ggplot(MeanFish, aes(x = Day, y = meanSMR))
Testplot2 + geom_line(aes(col = MeanFish$Treatment))


CohortA <- FishMerge_SMR_NoBoost[!(FishMerge_SMR$Cohort == "B"),]
Testplot3 <- ggplot(CohortA, aes(x = Day, y = SMR2))
Testplot3 + geom_point(aes(col = CohortA$Treatment))



wait <- lm(FishMerge_SMR$SMR2 ~ FishMerge_SMR$Cohort)
anova(wait)

holdon <- lm(FishMerge_SMR$SMR2 ~ FishMerge_SMR$Cohort + FishMerge_SMR$Treatment + FishMerge_SMR$Day)
anova(holdon)

holdon2 <- lm(FishMerge_SMR$SMR2 ~ FishMerge_SMR$Treatment + FishMerge_SMR$Day + (1|FishMerge_SMR$Cohort))
anova(holdon2)


## to do, isolate cohorts and try and find significant differences there
#clean up the code so far
