#k-means
library(factoextra)
g<-read.csv("g.csv",header = TRUE, sep = ",", quote = "\"",
            dec = ".", fill = TRUE, comment.char = "!")
Est<-read.csv("Est.csv",header = TRUE, sep = ",", quote = "\"",
              dec = ".", fill = TRUE, comment.char = "!")
rownames(Est)<-g
colnames(Est)<-g
Est<-data.frame(Est)
fviz_nbclust(Est, kmeans, method = "wss") + geom_vline(xintercept = 4, linetype = 2)
km_result<-kmeans(Est,4)
table(km_result$cluster)
cluster<-km_result$cluster
new_Est<-cbind(Est,cluster)
c1<-subset(new_Est,new_Est$cluster=="1")
c2<-subset(new_Est,new_Est$cluster=="2")
c3<-subset(new_Est,new_Est$cluster=="3")
c4<-subset(new_Est,new_Est$cluster=="4")
new_Est<-rbind(c1,c2,c3,c4)
new_Est<-new_Est[,1:100]
colnames(new_Est)<-g
cluster_name<-rownames(new_Est)
new_Est<-new_Est[,cluster_name]
for(i in 1:100){
  new_Est[i,i]<-1
}

#correlation heatmap
library(ggcorrplot)
purple_to_white <- colorRampPalette(c("purple", "white"))(1000)
white_to_red <- colorRampPalette(c("white", "red"))(1000)
full_color_palette <- c(purple_to_white, white_to_red[-1])
breaks_neg <- seq(-1, 0, length.out = length(purple_to_white) + 1)
breaks_pos <- seq(0, 1, length.out = length(white_to_red))[-1]
breaks <- c(breaks_neg, breaks_pos)

annotation_row = data.frame(GeneCluster = factor(rep(c("Cluster1","Cluster2","Cluster3","Cluster4"), c(38,25,18,19))))
row.names(annotation_row)<-row.names(new_Est)
annotation_colors=list(GeneCluster=c(Cluster1="#E25B45",Cluster2="#FF8357",Cluster3="#FAC172",
                                     Cluster4="#89D5C9"))
