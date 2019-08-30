#################################################################################
#This function accepts lambda and alpha as inputs and can be used to test performance only with immune data
TestGLM_immune <- function(out, Y, foldid, lambda,alpha, scale=TRUE, coef)
{
  library(matrixStats)
  parm = list()
  X=out$features[[5]]

  parm$scale = scale
  parm$method = 'glmnet'
  parm$coef = coef
  alpha = seq(0,1,.1)

  parm$a = alpha
  parm$l = lambda
  
  return(wrapTest1layer(X, Y, foldid, parm))
}



#################################################################################
#This function tests  lamda values of Ridge regression for the microbiome data.
TestRidge <- function(out, Y, foldid, lambda, scale=TRUE, coef)
{
  library(matrixStats)
  parm = list()
  X=out$features[[4]]
 
  parm$scale = scale
  parm$method = 'glmnet'
  parm$coef = coef
  alpha = 0
  
    
  
  parm$a = alpha
  parm$l = lambda
  
  return(wrapTest1layer(X, Y, foldid, parm))
}
