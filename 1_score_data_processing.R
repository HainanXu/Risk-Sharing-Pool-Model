rm(list=ls())
library(readr)

df <- read_csv("dataMCMWorkshopScoring.csv")

#data preprocessing: use 0 to substitute the num; use mode to substutute char
##missing values(num): numberWeeklyBurgers, numberWeeklySodas,numberDaysMeditatingPerYear
##missing values(char):vehicleVar6, vehicleVar8, vehicleVar10

df$numberWeeklyBurgers[is.na(df$numberWeeklyBurgers)]=0
df$numberMonthlyCucumbers[is.na(df$numberMonthlyCucumbers)]=0
#df$numberWeeklySodas[is.na(df$numberWeeklySodas)]=0
#df$numberDaysMeditatingPerYear[is.na(df$numberDaysMeditatingPerYear)]=0


df$numberWeeklySodas=ifelse(is.na(df$numberWeeklySodas),
                            ave(df$numberWeeklySodas,FUN= function(x) mean(x,na.rm=TRUE)),
                            df$numberWeeklySodas)
df$numberDaysMeditatingPerYear=ifelse(is.na(df$numberDaysMeditatingPerYear),
                                      ave(df$numberDaysMeditatingPerYear,FUN= function(x) mean(x,na.rm=TRUE)),
                                      df$numberDaysMeditatingPerYear)

df$vehicleVar6=ifelse(is.na(df$vehicleVar6),
                      ave(df$vehicleVar6,FUN= function(x) mean(x,na.rm=TRUE)),
                      df$vehicleVar6)

df$vehicleVar7=ifelse(is.na(df$vehicleVar7),
                      ave(df$vehicleVar7,FUN= function(x) mean(x,na.rm=TRUE)),
                      df$vehicleVar7)
df$vehicleVar8=ifelse(is.na(df$vehicleVar8),
                      ave(df$vehicleVar8,FUN= function(x) mean(x,na.rm=TRUE)),
                      df$vehicleVar8)
df$vehicleVar9=ifelse(is.na(df$vehicleVar9),
                      ave(df$vehicleVar9,FUN= function(x) mean(x,na.rm=TRUE)),
                      df$vehicleVar9)

df$vehicleVar10=ifelse(is.na(df$vehicleVar10),
                       ave(df$vehicleVar10,FUN= function(x) mean(x,na.rm=TRUE)),
                       df$vehicleVar10)

df$numberMonthlyCucumbers<-NULL
df$numberYearsWithoutTransFat<-NULL
df$numberDaysMeditatingPerYear<-NULL

write_csv(df, 'full_score_data_final.csv')

