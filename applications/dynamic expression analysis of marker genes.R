#edges related to nanog
library(ggplot2)
res[101,]
a<-res[101:510,1]
b<-res[101:510,2]
sum(c(a,b)=="NANOG")
edge <- NULL
for(i in 101:510){
  if(res[i,1]=="NANOG" || res[i,2]=="NANOG"){      
    edge<-rbind(edge,res[i,])
  }
}
#NANOG network
edge1<-edge[,1:3]
edge1<-subset(edge1,edge1[,1]=="NANOG")
write.table (edge1, file ="NANOG.txt", sep ="\t", row.names =FALSE, col.names =TRUE, quote =FALSE)

#mean values of gene expression at each time
gy<-unique(edge[,1])
n<-length(gy)
sub<-hESC[gy,]
sub1<-data.frame()
for(i in 1:n){
  sub1[i,1]<-mean(sub[i,1:92])
  sub1[i,2]<-mean(sub[i,93:194])
  sub1[i,3]<-mean(sub[i,195:260])
  sub1[i,4]<-mean(sub[i,261:432])
  sub1[i,5]<-mean(sub[i,433:570])
  sub1[i,6]<-mean(sub[i,571:758])
}
colnames(sub1)<-c("00h","12h","24h","36h","72h","96h")
rownames(sub1)<-gy
#画折线图
supp1=c(rep("NANOG",6),rep("HAPLN1",6),rep("RHOBTB3",6),rep("CER1",6),rep("LHX1",6),rep("CYP26A1",6),rep("COL5A2",6),rep("APOBEC3G",6),rep("NRP1" ,6),rep("SOX2" ,6))
dose1=c(0,12,24,36,72,96)
length1=c(t(sub1[1,]),t(sub1[2,]),t(sub1[3,]),t(sub1[4,]),t(sub1[5,]),t(sub1[6,]),t(sub1[7,]),t(sub1[8,]),t(sub1[9,]),t(sub1[10,]))
tgg=data.frame(supp1,dose1,length1)
ggplot(tgg, aes(x=factor(dose1), y=length1, colour=supp1,group=supp1)) + 
  geom_line(size=1)+theme(panel.background = element_rect(fill = "white",color="black"),
                          panel.grid.major = element_blank(), 
                          panel.grid.minor = element_blank())+
  xlab("time")+ylab("average expression")+geom_point()
