#calculate the AUROC
library(ggplot2)
library(pROC)
roc1<-roc(res[,5],res[,3])
roc2<-roc(res2[,5],res2[,3])
roc3<-roc(res3[,5],res3[,3])
roc4<-roc(res4[,5],res4[,3])
auc(roc1)
auc(roc2)
auc(roc3)
auc(roc4)
#draw the ROC
ggroc1 <- ggroc(list(GCNPCC=roc1,scLink=roc2,GENIE3=roc3,SCODE=roc4),size = 1.5,legacy.axes = TRUE)+
  theme(panel.background = element_rect(fill = "white",color="black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  theme(legend.position=c(0.90,0.12))+
  theme(legend.text=element_text(size=20, face="plain"))+
  theme(legend.background=element_rect(fill="white", colour="black"))+
  scale_y_continuous(expand = c(0, 0)) +scale_x_continuous(expand = c(0, 0))
ggroc1+
  annotate("text", x=0.125, y=0.965, label=" GCNPCC : 0.691",size=6, fontface="bold",family = "A")+
  annotate("text", x=0.12, y=0.93, label=" scLink : 0.6338",size=6, fontface="bold",family = "A")+
  annotate("text", x=0.128, y=0.895, label="GENIE3 : 0.5131",size=6, fontface="bold",family = "A")+
  annotate("text", x=0.128, y=0.86, label="SCODE : 0.6622",size=6, fontface="bold",family = "A")
