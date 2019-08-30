##ridge_pval.r result plot
data<-read.table("ridge_pval",header=FALSE)
data[which(data[,2]==max(data[,2])),]
plot(data,xlab="lambda",ylab="-log(pval)")
