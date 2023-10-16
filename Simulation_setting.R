simulating_1 = function(n=100 , p=30) {
  x = matrix(runif(n*p, min=-1, max=1), nrow=n)
  x <- scale(x)
  pi_logistic <- c(rep(1/2, 100))
  a= rbinom(n, size=1, prob=1/2)
  a<-ifelse (a >0 ,1,-1) 
  w = rnorm(n, 0, 1)
  r = 1+ x[,1] + x[,2] + 2*x[,3] + 0.5*x[,4] + 1.8*(0.3-x[,1]-x[,2])*a +w ;
  y=2*r*a
  tauX_true = 1.8*(0.3-x[,1]-x[,2]) 
  itr_true<-ifelse(2*tauX_true>0 ,1,-1)
  obj2 <- ncv.elastic.3(x, y, type="lasso", pi_logistic=1/pi_logistic, alpha=1, lambda = 1.27 ) # 최종: 1.25
  obj2
}

simulating_2 = function(n=100 , p=30) {
  x = matrix(runif(n*p, min=-1, max=1), nrow=n)
  x <- scale(x)
  pi_logistic <- c(rep(1/2, 100))
  a= rbinom(n, size=1, prob=1/2)
  a<-ifelse (a >0 ,1,-1) 
  w = rnorm(n, 0, 1)
  r = 1+ x[,1] + x[,2] + 2*x[,3] + 0.5*x[,4] + 0.442*abs(x[,3])*(1-x[,1]-x[,2])*a +w  #(2)
  y=2*r*a
  tauX_true = 0.442*abs(x[,3])*(1-x[,1]-x[,2]) 
  itr_true<-ifelse(2*tauX_true>0 ,1,-1) 
  obj2 <- ncv.elastic.3(x, y, type="lasso", pi_logistic=1/pi_logistic, alpha=1, lambda = 1.27)
  obj2
}

simulating_3 = function(n=100 , p=30) {
  x = matrix(runif(n*p, min=-1, max=1), nrow=n)
  x <- scale(x)
  pi_logistic <- c(rep(1/2, 100))
  a= rbinom(n, size=1, prob=1/2)
  a<-ifelse (a >0 ,1,-1) 
  w = rnorm(n, 0, 1)
  r = 1+ 2*x[,1] + x[,2] + 0.5*x[,3] + 0.3*(0.9-x[,1])*a +w ;
  y=2*r*a
  tauX_true= 0.3*(0.9-x[,1])   #(3)
  itr_true<-ifelse(2*tauX_true>0 ,1,-1) 
  obj2 <- ncv.elastic.3(x, y, type="lasso", pi_logistic=1/pi_logistic, alpha=1, lambda = 1.3)
  obj2
}

simulating_4 = function(n=100 , p=30) {
  x = matrix(runif(n*p, min=-1, max=1), nrow=n)
  x <- scale(x)
  pi_logistic <- c(rep(1/2, 100))
  a= rbinom(n, size=1, prob=1/2)
  a<-ifelse (a >0 ,1,-1) 
  w = rnorm(n, 0, 1)
  r = 1+ (x[,1])^2 + (x[,2])^2 + 1.8*(0.3-x[,1]-x[,2])*a +w   #(4)
  y=2*r*a
  tauX_true = 1.8*(0.3-x[,1]-x[,2]) # = delta(x)    / (1),(4)
  itr_true<-ifelse(2*tauX_true>0 ,1,-1) 
  obj2 <- ncv.elastic.3(x, y, type="lasso", pi_logistic=1/pi_logistic, alpha=1, lambda = 1.25)
  obj2
}

# 100번 비교
obj_list = replicate(100, simulating_1(), simplify = FALSE )
length(obj_list)



error_rate <- c()
for (i in 1:100) {
  pred.lasso.ncv.test <- obj_list[[i]][1] + x.test%*%obj_list[[i]][-1]
  opt_lasso_ncv.test <-ifelse(pred.lasso.ncv.test>=0 ,1,-1) 
  answer_lasso_ncv.test = itr_true.test - opt_lasso_ncv.test
  misclass_rate= 1- length(which(answer_lasso_ncv.test == 0))/nrow(x.test)
  error_rate <- append(error_rate, misclass_rate)
}
mean(error_rate)


# p= 120, 480, 1920 일때의 결과 비교


n=100; p=1920
n.test=10000
set.seed(1234) ;
x.test = matrix(runif(n.test*p, min=-1, max=1), nrow=n.test) ;
#x.test <- scale(x.test)
a.test = rbinom(n.test, size=1, prob=1/2)
a.test<-ifelse (a.test >0 ,1,-1) 
w.test = rnorm(n.test, 0, 1)  #표준편차는 1 or 4 


r.test =1+ x.test[,1] + x.test[,2] + 2*x.test[,3] + 0.5*x.test[,4] + 1.8*(0.3-x.test[,1]-x.test[,2])*a.test +w.test  #(1)
r.test = 1+ (x.test[,1])^2 + (x.test[,2])^2 + 1.8*(0.3-x.test[,1]-x.test[,2])*a.test +w.test #(4)
r.test = 1+ x.test[,1] + x.test[,2] + 2*x.test[,3] + 0.5*x.test[,4] + 0.442*abs(x.test[,3])*(1-x.test[,1]-x.test[,2])*a.test +w.test #(2)
r.test = 1+ 2*x.test[,1] + x.test[,2] + 0.5*x.test[,3]  + 0.3*(0.9-x.test[,1])*a.test +w.test ; #(3)

y.test=2*r.test*a.test
tauX_true.test = 1.8*(0.3-x.test[,1]-x.test[,2])  #(1),(4)
tauX_true.test = 0.442*abs(x.test[,3])*(1-x.test[,1]-x.test[,2]) #(2)
tauX_true.test = 0.3*(0.9-x.test[,1]) #(3)

itr_true.test<-ifelse(tauX_true.test*2>0 ,1,-1) 


error_rate <- c()
for (i in 1:100) {
  pred.lasso.ncv.test <- obj_list[[i]][1] + x.test%*%obj_list[[i]][-1]
  opt_lasso_ncv.test <-ifelse(pred.lasso.ncv.test>=0 ,1,-1) 
  answer_lasso_ncv.test = itr_true.test - opt_lasso_ncv.test
  misclass_rate = 1- length(which(answer_lasso_ncv.test == 0))/nrow(x.test)
  error_rate <- append(error_rate, misclass_rate)
}
mean(error_rate)




