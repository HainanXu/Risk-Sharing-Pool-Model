library(readr)
library(tweedie)
library(statmod)
df<- read_csv("dataMCMWorkshopTrain.csv")

#check for misssing values in the dataset
sum(is.na(df))
df$numberWeeklyBurgers[is.na(df$numberWeeklyBurgers)]=0

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
#since the correlation between ... is high, we remove the ""
df$numberMonthlyCucumbers<-NULL
df$numberYearsWithoutTransFat<-NULL
df$numberDaysMeditatingPerYear<-NULL



df<-dplyr::mutate(df,
                  frequency=nEvent/exposure)
df<-dplyr::mutate(df,
                  pure_premium=amount/exposure)

write_csv(df, 'prepared_data_final.csv')



