##ridge_pval.r result plot
data<-read.table("ridge_pval",header=FALSE)
data[which(data[,2]==max(data[,2])),]
plot(data,xlab="lambda",ylab="-log(pval)")


##retrieving parameters with the optimal pvalue from immpune_pca.r results
data<-read.table("immunePCA_pval",header=FALSE)
data_sub25=data[which(data[,1]==25),]
data_sub25[which(data_sub25[,4]==max(data_sub25[,4])),]

data_sub50=data[which(data[,1]==50),]
data_sub50[which(data_sub50[,4]==max(data_sub50[,4])),]

data_sub100=data[which(data[,1]==100),]
data_sub100[which(data_sub100[,4]==max(data_sub100[,4])),]

data_sub200=data[which(data[,1]==200),]
data_sub200[which(data_sub200[,4]==max(data_sub200[,4])),]
