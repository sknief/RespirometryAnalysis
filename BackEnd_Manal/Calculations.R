 ########################################################
##                FIRESTING PIEPELINE                 ##
##                   BY KNIEF.CODES                   ##
##  ------------------------------------------------- ##
##               AUTHOR: STELLA MS KNIEF              ##
##      START DATE: 10/06/2023 PUBLISH:               ##
##                    VERSION 1.0                     ##
##       CITE WHAT YOU USE, KO-FI IF YOU'RE NICE      ##
########################################################

#Base parameters
RespVol <- 2200
Days <- 43

#Fish Data & Mass Calcs
FishData <- load.csv(FishData_Trial1.csv)
#I'm assuming that my fish grew linearly cause there is NO point in measuring them daily, way to fluctuating and like imprecise (plus handling stress)

