
#optional install code
#install.packages("qpcR")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("foreach")
#install.packages("readr")
#install.packages("gridExtra")

#libraries
library(qpcR)
library(dplyr)
library(ggplot2)
library(foreach)
library(readr)
library(gridExtra)

WD <- "C:/Users/sknie/Desktop/pipetest/" #root folder (variable?)
setwd(WD)

#WD
folders <-  read.delim(paste0(WD, "subfolder_names.csv" ), header = FALSE) #this is the root 
nrow(folders)
#folder of all thingies


foreach(i=1: (nrow(folders))) %do% {
  ExpID <- folders[i,] #get the ID variable?
  
  #load in the files
  Ch1_A_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch1_A_WorkingFile.csv"))
  Ch2_A_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch2_A_WorkingFile.csv"))
  Ch3_A_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch3_A_WorkingFile.csv"))
  Ch4_A_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch4_A_WorkingFile.csv"))
  
  Ch1_B_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch1_B_WorkingFile.csv"))
  Ch2_B_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch2_B_WorkingFile.csv"))
  Ch3_B_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch3_B_WorkingFile.csv"))
  Ch4_B_Raw <- read.delim(paste0(WD, ExpID, "/Files/Ch4_B_WorkingFile.csv"))
  
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
  Ch1_A_Raw$Secs <- seq(from = 1, length.out = nrow(Ch1_A_Raw), by = 1)
  Ch1_B_Raw$Secs <- seq(from = 1, length.out = nrow(Ch1_B_Raw), by = 1)
  
  
  #move columns around
  Ch1_A_Raw <- Ch1_A_Raw[, c(5,1,2,4,3)]
  Ch1_B_Raw <- Ch1_B_Raw[, c(5,1,2,4,3)]
  
  
  #append
  FrankenStein <- qpcR:::cbind.na(Ch1_A_Raw, Ch2_A_Raw, Ch3_A_Raw, Ch4_A_Raw, Ch1_B_Raw, Ch2_B_Raw, Ch3_B_Raw, Ch4_B_Raw) 
  FrankieStein_A <- qpcR:::cbind.na(Ch1_A_Raw, Ch2_A_Raw, Ch3_A_Raw, Ch4_A_Raw)
  FrankieStein_B <- qpcR:::cbind.na(Ch1_B_Raw, Ch2_B_Raw, Ch3_B_Raw, Ch4_B_Raw) 
  
  #reorder one last time
  FrankenStein <-FrankenStein[, c(1, 5, 6, 7, 8, 13, 14, 15, 16, 4, 12, 3, 2)]
  FrankieStein_A <- FrankieStein_A[, c(1, 5, 6, 7, 8, 4, 3, 2)]
  FrankieStein_B <- FrankieStein_B[, c(1, 5, 6, 7, 8, 4, 3, 2)]
  
  
  #titles
  FrnkStn <- as.character(paste0(WD, ExpID, "_Frankenstein.txt"))
  FrnkStn_A <- as.character(paste0(WD, ExpID, "_Frankiestein_A.txt"))
  FrnkStn_B <- as.character(paste0(WD, ExpID, "_Frankiestein_B.txt"))
  
  #export files
  write.table(FrankenStein, FrnkStn,
              append = FALSE,
              row.names = FALSE,
              col.names = TRUE)
  
  write.table(FrankieStein_A, FrnkStn_A,
              append = FALSE,
              row.names = FALSE,
              col.names = TRUE)
  
  write.table(FrankieStein_B, FrnkStn_B,
              append = FALSE,
              row.names = FALSE,
              col.names = TRUE)
}
