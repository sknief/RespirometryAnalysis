#WD
WD <- "C:/Users/sknie/Desktop/pipetest/2023-02-18_133424_COHORT A RESP DAY 5/Files"
TESTA <- "ValueTBD"
setwd(WD)

#libraries
library(qpcR)

#load in the files
Ch1_A_Raw <- read.delim("Ch1_A_WorkingFile.csv")
Ch2_A_Raw <- read.delim("Ch2_A_WorkingFile.csv")
Ch3_A_Raw <- read.delim("Ch3_A_WorkingFile.csv")
Ch4_A_Raw <- read.delim("Ch4_A_WorkingFile.csv")

Ch1_B_Raw <- read.delim("Ch1_B_WorkingFile.csv")
Ch2_B_Raw <- read.delim("Ch2_B_WorkingFile.csv")
Ch3_B_Raw <- read.delim("Ch3_B_WorkingFile.csv")
Ch4_B_Raw <- read.delim("Ch4_B_WorkingFile.csv")

#Change headers for the subfiled
colnames(Ch1_A_Raw)[3] <- "A_Ch1"
colnames(Ch2_A_Raw)[1] <- "A_Ch2"
colnames(Ch3_A_Raw)[1] <- "A_Ch3"
colnames(Ch4_A_Raw)[1] <- "A_Ch4"
colnames(Ch1_B_Raw)[3] <- "B_Ch1"
colnames(Ch2_B_Raw)[1] <- "B_Ch2"
colnames(Ch3_B_Raw)[1] <- "B_Ch3"
colnames(Ch4_B_Raw)[1] <- "B_Ch4"

nrow(Ch1_A_Raw)

#make a seconds column
Ch1_A_Raw$Secs <- seq(from = 5, length.out = nrow(Ch1_A_Raw), by = 5)
Ch1_B_Raw$Secs <- seq(from = 5, length.out = nrow(Ch1_B_Raw), by = 5)


#move columns around
Ch1_A_Raw <- Ch1_A_Raw[, c(5,1,2,4,3)]
Ch1_B_Raw <- Ch1_B_Raw[, c(5,1,2,4,3)]


#append
FrankenStein <- qpcR:::cbind.na(Ch1_A_Raw, Ch2_A_Raw, Ch3_A_Raw, Ch4_A_Raw, Ch1_B_Raw, Ch2_B_Raw, Ch3_B_Raw, Ch4_B_Raw) 
FrankieStein_A <- qpcR:::cbind.na(Ch1_A_Raw, Ch2_A_Raw, Ch3_A_Raw, Ch4_A_Raw)
FrankieStein_B <- qpcR:::cbind.na(Ch1_B_Raw, Ch2_B_Raw, Ch3_B_Raw, Ch4_B_Raw) 

#titles
FrnkStn <- as.character(paste0(TESTA, "_Frankenstein.txt"))
FrnkStn_A <- as.character(paste0(TESTA, "_Frankiestein_A.txt"))
FrnkStn_B <- as.character(paste0(TESTA, "_Frankiestein_B.txt"))

#export files
write.table(FrankenStein, FrnkStn,
            append = FALSE,
            row.names = FALSE,
            col.names = TRUE)

write.table(FrankieStein, FrnkStn_A,
            append = FALSE,
            row.names = FALSE,
            col.names = TRUE)

write.table(FrankieStein, FrnkStn_B,
            append = FALSE,
            row.names = FALSE,
            col.names = TRUE)