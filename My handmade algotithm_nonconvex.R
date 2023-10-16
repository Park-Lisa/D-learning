# MCP update function for CD
mcp.update = function(z, lambda, gamma, under)
{
  if (abs(z) <= under* gamma * lambda){
    S(z, lambda) / (under - 1 / gamma)
  } else z/under
}

ncv.mcp<- function(x,y, pi_logistic, lambda, type, alpha, init=rep(0,p), max.iter=1000, eps=1.0e-8)    
{
  n <- length(y)
  p <- ncol(x)
  
  # marginal standardization of x
  x <- scale(x)
  # 추가
  m <- attr(x, "scaled:center")
  s <- attr(x, "scaled:scale")
  
  # centering of y
  my <- mean(y)
  y <- (y - my)
  
  # initialize beta
  beta <- init
  
  zj <- rep(0,p)
  vj <- rep(0,p)
  # residual
  r <- (y - x %*% beta)
  
  
  if (type == "mcp") {
    update.ft <- function(x, lambda, alpha, under) mcp.update(x, lambda, alpha, under)
  } else stop("type should be mcp")
  
  # start update
  for (t in 1:max.iter)
  {
    new.beta <- beta
    for (j in 1:p)
    {
      
      zj[j] <- 1/n * crossprod(x[,j]*pi_logistic,  r) + 1/n*crossprod(x[,j]*pi_logistic,  x[,j])*new.beta[j]
      vj[j] <- 1/n*crossprod(x[,j]*pi_logistic,  x[,j]) 
      if (alpha > 1/vj[j]){
        new.beta[j] <- update.ft(zj[j], lambda, alpha, vj[j]) 
        r <- r - (new.beta[j] - beta[j]) * x[,j]  }
      else stop("error")
    }
    if (max(abs(beta - new.beta)) < eps) break
    beta <- new.beta
  }
  
  # transform back
  beta <- beta / s
  beta0 <- my - m %*% beta
  
  index <- which(abs(beta) > eps)
  beta.info <- beta[index]
  
  obj= c(beta0, beta)
}
