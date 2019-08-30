remove(list = ls())
source("load.R")
source("cross-validation.R")
source("traintest.R")

out=DataGenerate('../Data/Data.Rda', T)

foldid=as.integer(as.factor(out$featurepatients[out$featureindex]))
set.seed(1000)
featureweeks=out$featureweeks[out$featureindex]

glmn = list()
for(i in seq(length(out$features)))
{
  glmn[[i]] = TestGLM(out, featureweeks, foldid, paste0('../RDSfiles/GLM', i, '.rds'), TRUE, FALSE, i)
}

gmtrpv = vector() 
gmtstpv = vector()

gmBtrain =  glmn[[1]]$Trainpredict
gmBtest = glmn[[1]]$Testpredict

gmtrpv[1] = glmn[[1]]$Trainpval
gmtstpv[1]= glmn[[1]]$Testpval

for(i in c(2:length(out$features)))
{ 
  gmBtrain = cbind(gmBtrain, glmn[[i]]$Trainpredict)
  gmBtest = cbind(gmBtest, glmn[[i]]$Testpredict)
  gmtrpv[i] = glmn[[i]]$Trainpval
  gmtstpv[i] = glmn[[i]]$Testpval
}

gmboost=BoostGLM(gmBtrain, featureweeks, gmBtest, foldid, '../RDSfiles/GLMBoost.rds', TRUE, FALSE) 
ablation_all=gmboost$Testpval

#Here we make a matrix which will be used to inform which features will be excluded
ablation_result=matrix( 0, nrow = 2^7, ncol = 7)
i=1
for(a in 1:2){
for(b in 1:2){
for(c in 1:2){
for(d in 1:2){
for(e in 1:2){
for(f in 1:2){
for(g in 1:2){
ablation_result[i,1]=a-1
ablation_result[i,2]=b-1
ablation_result[i,3]=c-1
ablation_result[i,4]=d-1
ablation_result[i,5]=e-1
ablation_result[i,6]=f-1
ablation_result[i,7]=g-1
i=i+1
}
}
}
}
}
}
}

#This function excludes corresponding features when the row index of the ablation_result matrix is given
Boost_oblation <- function(i){ 
print(i)
exclude_index=c(ablation_result[i,1]*1,ablation_result[i,2]*2,ablation_result[i,3]*3,ablation_result[i,4]*4,ablation_result[i,5]*5,ablation_result[i,6]*6,ablation_result[i,7]*7)
exclude_index=exclude_index[which(exclude_index>0)]
if(length(exclude_index)==6){
return(glmn[[(1:7)[-exclude_index]]]$Testpval)
}else{
gmboost=BoostGLM(gmBtrain[,-exclude_index], featureweeks, gmBtest[,-exclude_index], foldid, '../RDSfiles/GLMBoost.rds', TRUE, FALSE) 

return(gmboost$Testpval)
}

}


#Sort the results. In the report, only top 10 results were shown

ablation_all=c(ablation_all,sapply(2:(length(ablation_result[,1])-1), Boost_oblation))

ablation_result=cbind(ablation_result[-128,],ablation_all)
ablation_result_sort=ablation_result[order(ablation_result[,8],decreasing=TRUE),]
