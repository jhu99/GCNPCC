#mean values of gene expression at each time
library(ggplot2)
gy<-c("Sox2","Nanog","Esrrb","Zfp42","Gata4","Phc1")
n<-length(gy)
sub<-mESC[gy,]
sub1<-data.frame()
for(i in 1:n){
  sub1[i,1]<-mean(sub[i,1:90])
  sub1[i,2]<-mean(sub[i,91:158])
  sub1[i,3]<-mean(sub[i,159:248])
  sub1[i,4]<-mean(sub[i,249:330])
  sub1[i,5]<-mean(sub[i,331:421])
}
colnames(sub1)<-c("00h","12h","24h","48h","72h")
rownames(sub1)<-gy
#画折线图
supp1=c(rep("Sox2",5),rep("Nanog",5),rep("Esrrb",5),rep("Zfp42",5),rep("Gata4",5),rep("Phc1",5))
dose1=c(0,12,24,48,72)
length1=c(t(sub1[1,]),t(sub1[2,]),t(sub1[3,]),t(sub1[4,]),t(sub1[5,]),t(sub1[6,]))
tgg=data.frame(supp1,dose1,length1)
ggplot(tgg, aes(x=factor(dose1), y=length1, colour=supp1,group=supp1)) +
  geom_line(size=1.2)+geom_point()+
  theme(panel.background = element_rect(fill = "white",color="black"),panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(legend.text = element_text(size = 11), legend.title = element_text(size = 13))+
  theme(axis.text.y = element_text(size = 12,face = "bold",angle = 90,vjust=1,hjust=0.5))+
  theme(axis.text.x = element_text(size = 12,face = "bold",vjust=-0.3,hjust=0.5))+
  xlab("time")+theme(axis.title.x = element_text(size = 14,face = "plain",vjust = -1))+
  ylab("average expression")+theme(axis.title.y = element_text(size = 14,face = "plain",vjust = 3))+
  theme(plot.margin = unit(rep(1,4),'lines'))
