args = commandArgs(trailingOnly=TRUE)

source("load.R")
source("cross-validation.R")
source("traintest.R")

#pval=readRDS(paste0('../RDSfiles/GLMBoost.rds'))
out=DataGenerate('../Data/Data.Rda', T)

foldid=as.integer(as.factor(out$featurepatients[out$featureindex]))
set.seed(1000)
featureweeks=out$featureweeks[out$featureindex]


lambda =  seq(0,50,.025)
lambda=lambda[-1] 

lambda=lambda[(40*(as.numeric(as.character(args[1]))-1)+1):(40*(as.numeric(as.character(args[1]))))]
  
glmn = list()
for(i in 1:length(lambda))
{
  glmn[[i]] = TestRidge(out, featureweeks, foldid, lambda[i], TRUE, FALSE)
  
  write.table(t(c(lambda[i],glmn[[i]]$Testpval)),"ridge_pval",col.names=FALSE,row.names=FALSE,quote=FALSE)

}
