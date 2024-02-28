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
km_result<-kmeans(Est1,4)
table(km_result$cluster)
cluster<-km_result$cluster
new_Est<-cbind(Est,cluster)
cc1<-subset(new_Est,new_Est$cluster=="1")
cc2<-subset(new_Est,new_Est$cluster=="2")
cc3<-subset(new_Est,new_Est$cluster=="3")
cc4<-subset(new_Est,new_Est$cluster=="4")
new_Est<-rbind(cc1,cc2,cc3,cc4)
new_Est<-new_Est[,1:100]
colnames(new_Est)<-g1
cluster_name<-rownames(new_Est)
new_Est<-new_Est[,cluster_name]
for(i in 1:100){
  new_Est[i,i]<-1
}

#correlation heatmap
library(ggcorrplot)
ggcorrplot(new_Est)+theme(,
                           plot.margin = margin(t = 1,  
                                                r = 0,  
                                                b = 2,  
                                                l = 0,  
                                                unit = "cm"))
