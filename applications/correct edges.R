#number of correct edges
library(ggplot2)
a1<-head(res1,100)
a1<-subset(a1,a1[,7]==1)
a2<-head(res2,100)
a2<-subset(a2,a2[,7]==1)
a3<-head(res3,100)
a3<-subset(a3,a3[,5]==1)
a4<-head(res44,100)
a4<-subset(a4,a4[,5]==1)
a5<-head(res5,100)
a5<-subset(a5,a5[,5]==1)

b1<-dim(a1)[1]
b2<-dim(a2)[1]
b3<-dim(a3)[1]
b4<-dim(a4)[1]
b5<-dim(a5)[1]

a11<-head(res1,200)
a11<-subset(a11,a11[,7]==1)
a22<-head(res2,200)
a22<-subset(a22,a22[,7]==1)
a33<-head(res3,200)
a33<-subset(a33,a33[,5]==1)
a44<-head(res44,200)
a44<-subset(a44,a44[,5]==1)
a55<-head(res5,200)
a55<-subset(a55,a55[,5]==1)

b11<-dim(a11)[1]
b22<-dim(a22)[1]
b33<-dim(a33)[1]
b44<-dim(a44)[1]
b55<-dim(a55)[1]

data<-data.frame(
  name=factor(c("GCNPCC", "scLink", "GENIE3", "SCODE", "GRNBoost2", "GCNPCC", "scLink", "GENIE3", "SCODE", "GRNBoost2"),
              levels = c("GCNPCC", "scLink", "GENIE3", "SCODE", "GRNBoost2")),
  count=c(b1,b2,b3,b4,b5,b11,b22,b33,b44,b55),
  group = rep(c("top100", "top200"), each = 5))

ggplot(data,aes(x=name,y=count,fill=group))+
  geom_bar(stat="identity",width = 0.8,position = position_dodge(0.8))+
  scale_fill_manual(values=c("top100"="#E25B45", "top200"="#FF8361"))+
  labs(fill = "")+  # 将图例标题设置为空字符串以移除它
  theme(panel.background = element_rect(fill = "white",color="black"),panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  geom_text(aes(label=count),position=position_dodge(0.8), vjust=1.6, color="white", size=4.5)+
  theme(axis.text.y = element_text(size = 12,face = "bold",angle = 90,vjust=1,hjust=0.5),
        axis.text.x = element_text(size = 12,face = "bold",vjust=-0.3,hjust=0.5),
        legend.position = c(0.85, 0.92),
        legend.text = element_text(size = 12))+ # 调整图例中文本的大小
  xlab("Methods")+theme(axis.title.x = element_text(size = 14,face = "plain",vjust = -1))+
  ylab("Count")+theme(axis.title.y = element_text(size = 14,face = "plain",vjust = 3))+
  theme(plot.margin = unit(rep(1,4),'lines'))
