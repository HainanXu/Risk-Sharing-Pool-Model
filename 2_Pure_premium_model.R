rm(list=ls())
library(dplyr)
prepared_data <- read_csv("prepared_data_final.csv")
View(prepared_data)
sum(is.na(prepared_data))
prepared_data$amount<-NULL
prepared_data$frequency<-NULL
prepared_data$nEvent<-NULL

mean(prepared_data$pure_premium)

View(prepared_data$exposure)

set.seed(123)
train<-sample(100000,85000)
training_set<-prepared_data[train,]
test_set<-prepared_data[-train,]
test_set$exposure<-1


#numberDailyCalories-numberWeeklyBurgers-diet-keto-eatSpicy-vehicleVar1-vehicleVar9-vehicleVar3-deductible-vehicleVar6,
f1_tweedie <- glm(pure_premium ~.-exposure-unique_id,
          data=training_set,
          weight = exposure,
          family = tweedie(var.power=1.5,link.power=0))
summary(f1_tweedie)
pred<-predict(f1_tweedie, newdata = test_set,type= "response")


mean(pred)
mean(prepared_data$pure_premium)



#names(prepared_data)
#View(prepared_data)


full_score_data_final <- read_csv("full_score_data_final.csv")
full_score_data_final$exposure<-1
pred2<-predict(f1_tweedie, newdata = full_score_data_final,type= "response")
mean(pred2)
mean(full_score_data_final$price)
score_prediction=data.frame('unique_id'=full_score_data_final$unique_id,'p'=pred2)


haha2=arrange(full_score_data_final, desc(price))[1:2500,]
haha=arrange(score_prediction, desc(p))[1:2500,]

mean(haha2)
View(haha2)
View(haha)

write.csv(haha$unique_id,"Cooperators_final_round_submission.csv")


