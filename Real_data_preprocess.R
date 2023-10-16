set.seed(1234)
install.packages("speff2trial")
library(speff2trial)
data(ACTG175)
ACTG175
head(ACTG175)
str(ACTG175)

#x variable: wtkg, cd40, cd80, age, karnof, gender, race, homo, drugs, symptom, str2, hemo
#y variable: cd420- cd40


library(glmnet)
tune = "lambda.min"  
y_real <- as.matrix(ACTG175$cd420- ACTG175$cd40)
colnames(y_real) <- c('treat')

x_real <- cbind(ACTG175$wtkg, ACTG175$cd40, ACTG175$cd80, ACTG175$age, ACTG175$karnof, ACTG175$gender, ACTG175$race, ACTG175$homo, ACTG175$drugs, ACTG175$symptom, ACTG175$str2, ACTG175$hemo)

colnames(x_real) <- c('wtkg', 'cd40', 'cd80', 'age', 'karnof', 'gender', 'race', 'homo', 'drugs', 'symptom', 'str2', 'hemo')

x_real<-data.frame(x_real)
x_real$arms=ACTG175$arms

str(x_real)


x_real_2 <- x_real[x_real$arms == "2" | x_real$arms == "1" , ]
x_real_2$arms <-ifelse (x_real_2$arms =="2" ,-1, 1 ) 
a_real_2 <- x_real_2$arms 
x_real_2 = x_real_2[ ,-13]



wtkg <- x_real_2$wtkg
cd40<- x_real_2$cd40
cd80  <- x_real_2$cd80
age  <- x_real_2$age
karnof  <- x_real_2$karnof
homo <- x_real_2$homo


gender.1 <- as.factor(x_real_2$gender)
race.1 <- as.factor(x_real_2$race)
homo.1 <- as.factor(x_real_2$homo )
drugs.1<- as.factor( x_real_2$drugs)
symptom.1<- as.factor( x_real_2$symptom)
str2.1<- as.factor( x_real_2$str2)
hemo.1<- as.factor( x_real_2$hemo)


wtkg.1 <- scale(wtkg)
cd40.1 <- scale(cd40)
cd80.1 <- scale(cd80)
age.1 <- scale(age)
karnof.1 <- scale(karnof)




pi_real_2 <- c(rep(1/2, nrow(x_real_2)))
data_real <- cbind(x_real,y_real)
y_real_2 <- data_real[data_real$arms == 2 | data_real$arms == 1,  ]
y_real_2 <- y_real_2$treat

xfactors <- model.matrix(~ gender.1 + race.1+ homo.1+ drugs.1+ symptom.1+ str2.1+ hemo.1)[, -1]
x_real_2.1 <- as.matrix(data.frame(wtkg.1, cd40.1, cd80.1, age.1, karnof.1, xfactors))



