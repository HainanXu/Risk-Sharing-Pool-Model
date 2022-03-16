rm(list=ls())
library(dplyr)
prepared_data <- read_csv("prepared_data_final.csv")

View(prepared_data)

prepared_data<-dplyr::mutate(prepared_data,
                  severity=amount/nEvent)
#filter(prepared)

prepared_data$amount<-NULL
#prepared_data$frequency
#prepared_data$nEvent<-NULL
prepared_data$pure_premium<-NULL
#mean(prepared_data$pure_premium)
#prepared_data$exposure<-1
View(prepared_data)

set.seed(123)
train<-sample(100000,75000)
training_set<-prepared_data[train,]
test_set<-prepared_data[-train,]
frequency_test=dplyr::pull(test_set,frequency)
severity_test=dplyr::pull(test_set,severity)
test_set$nEvent<-NULL
#test_set$frequency

test_set$exposure<-1
test_set$frequency<-NULL
test_set$severity<-NULL
test_set$exposure<-NULL

training_set$severity<-NULL
training_set$nEvent<-NULL


f2_frequency<- glm(frequency ~ .-exposure-unique_id-vehicleVar7-numberWeeklyBurgers-eatSpicy-keto,
                  data=training_set,
                  weights = exposure,
                  family = poisson(link  ='log'))

summary(f2_frequency)

test_set$exposure<-1
pred2<-predict(f2_frequency, newdata = test_set,type= "response")
mean(pred2)
mean(frequency_test)


training_set2<-prepared_data[train,]
training_set2$frequency<-NULL
training_set2$diet<-NULL
training_set2$vehicleVar1<-NULL
training_set2$vehicleVar2<-NULL
training_set2$vehicleVar4<-NULL

f2_severity<- glm(severity ~ .-exposure-unique_id,
                   data=training_set2%>%filter(nEvent==1),
                   weight = nEvent,
                   family =  tweedie(var.power=0.5,link.power=0))
summary(f2_severity)

test_set$nEvent<-1
pred3<-predict(f2_severity,test_set,Type='response')


mean(predict(f2_severity,test_set,Type='response'))
mean(severity_test)

fre_sev=data.frame('unique_id'=test_set$unique_id,'p'=pred2*pred3)

#Compare fre_sev and test_set, looks good
View(fre_sev)
View(test_set)

##do similar opporation to score_data set
fre_sev=data.frame('unique_id'=full_score_data_final$unique_id,'p'=pred2*pred3)


