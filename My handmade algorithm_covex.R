#elastic net & lasso 

#soft-thresholding operator
S.elastic<- function(z, lambda, alpha)
{
  (z-lambda*alpha)*(z>lambda*alpha) + (z+lambda*alpha)*(z< -lambda*alpha) + 0*(abs(z) <= lambda*alpha)
}

#lasso update function for CD
elastic.update<-S.elastic



#coordinate descent algorithm
ncv.elastic<- function(x,y,pi_logistic,lambda, type, alpha, init=rep(0,p), max.iter=1000, eps=1.0e-8)   
{
  n <- length(y)
  p <- ncol(x)
  
  # marginal standardization of x
  x <- scale(x)
  m <- attr(x, "scaled:center")
  s <- attr(x, "scaled:scale")
  
  # centering of y
  my <- mean(y)
  y <- (y - my)
  
  # initialize beta
  beta <- init
  
  # residual
  r <- (y - x %*% beta)
  
  if (type == "lasso") 
  {
    elastic.update.ft <- function(x, lambda,alpha) elastic.update(x, lambda, alpha)
  } else stop("type should be lasso")
  
  # start update
  for (t in 1:max.iter)
  {
    new.beta <- beta
    for (j in 1:p)
    {
      xj <- 1/n * crossprod(x[,j]*pi_logistic,  r) + 1/n*crossprod(x[,j]*pi_logistic,  x[,j])*new.beta[j]
      
      vj <- 1/n*crossprod(x[,j]*pi_logistic,  x[,j]) 
      
      new.beta[j] <- elastic.update.ft(xj, lambda, alpha) 
      new.beta[j] <- new.beta[j] /(vj+(lambda)*(1-alpha))
      r <- r - (new.beta[j] - beta[j]) * x[,j]  
    }
    if (max(abs(beta - new.beta)) < eps) break
    beta <- new.beta
  }
  
  # transform back
  beta <- beta/s
  beta0 <- my - m %*% beta
  
  index <- which(abs(beta) > eps)
  beta.info <- beta[index]
  sd.info <- s
  
  obj= c(beta0, beta)
}
