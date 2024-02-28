#number of correct edges
library(ggplot2)
a1<-head(res,1000)
a1<-subset(a1,a1[,5]==1)
a2<-head(res2,1000)
a2<-subset(a2,a2[,5]==1)
a3<-head(res3,1000)
a3<-subset(a3,a3[,5]==1)
a4<-head(res4,1000)
a4<-subset(a4,a4[,5]==1)

b1<-dim(a1)[1]
b2<-dim(a2)[1]
b3<-dim(a3)[1]
b4<-dim(a4)[1]
name=c("pcor","scLink","GENIE3","SCODE")
name<-factor(name,levels=c("pcor","scLink","GENIE3","SCODE"))
data<-data.frame(name,count=c(b1,b2,b3,b4))

ggplot(data,aes(x=name,y=count)) + 
  geom_bar(stat="identity",width = 0.7,fill='#FF8361')+
  labs(x = "Methods", y = "Count")+
  theme(panel.background = element_rect(fill = "white",color="black"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+geom_text(aes(label=count), 
  vjust=1.6, color="white", size=4.5)+labs(title='hESC')
