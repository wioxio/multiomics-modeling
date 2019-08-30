args = commandArgs(trailingOnly=TRUE)#args=c(1,100,1)

source("load.R")
source("cross-validation.R")
source("traintest.R")

#pval=readRDS(paste0('../RDSfiles/GLMBoost.rds'))
out=DataGenerate('../Data/Data.Rda', T)



foldid=as.integer(as.factor(out$featurepatients[out$featureindex]))
set.seed(1000)
featureweeks=out$featureweeks[out$featureindex]



immune=out$features[[5]]
pca <- prcomp(immune, center = TRUE,scale. = TRUE)

sorted_features=names(sort(abs(pca$rotation[,1]),decreasing=TRUE))

out$features[[5]]=out$features[[5]][,colnames(out$features[[5]])%in%sorted_features[1:as.numeric(as.character(args[2]))]]



alpha = seq(0,1,.1)
lambda = c( seq(0,1,.025), seq(12) )
  

lambda=lambda[as.numeric(as.character(args[1]))]

saved=read.table("immunePCA_pval",header=FALSE)
  
glmn = list()
for(i in 1:length(alpha))
{
 if(length(intersect(intersect(which(saved[,1]==as.numeric(as.character(args[2]))),which(saved[,2]==lambda)),which(saved[,3]==alpha[i])))>0){next}

  glmn[[i]] = TestGLM_immune(out, featureweeks, foldid, lambda,alpha[i], TRUE, FALSE)
  #this finds alpha and lambda from the saved pval matrix
  content=t(c(as.numeric(as.character(args[2])),lambda,alpha[i],glmn[[i]]$Testpval))
  if(length(content)<4){next}
  write.table(content,file="immunePCA_pval",col.names=FALSE,row.names=FALSE,quote=FALSE,append=TRUE)

}
