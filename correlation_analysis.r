#Calculate correlations and retrive feature names & correlation coefficient

cor_result=cor(out$features[[7]],(out$features[[6]]))
high_cor=which(abs(cor_result)>0.6,arr.ind=TRUE)
result=integer()

for(i in 1:length(high_cor[,1]))
{
result=rbind(result,c(rownames(cor_result)[high_cor[i,1]],colnames(cor_result)[high_cor[i,2]],cor_result[high_cor[i,1],high_cor[i,2]]))
}

#Visualize correlations using igraph with weighted edges
library(igraph)
nodes=unique(c(result[,1],result[,2]))
net <- graph_from_data_frame(d=result, vertices=nodes, directed=T) 
E(net)$width <-abs(as.numeric(as.character(result[,3])))*3
V(net)$label.color <- "black"
V(net)$size  <-3
V(net)$label <- NA
E(net)$arrow.size <- .02
V(net)$color[rownames(as.matrix(V(net)))%in%rownames(cor_result)]="orange"
V(net)$color[rownames(as.matrix(V(net)))%in%colnames(cor_result)]="blue"
plot(net, 

     , vertex.frame.color="#555555",

     vertex.label="", vertex.label.color="black",

     vertex.label.cex=.7) 
