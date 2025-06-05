#calculate the AUROC
library(ggplot2)
library(pROC)
roc1<-roc(res1[,7],res1[,4])
auc1=auc(roc1)
roc2<-roc(res2[,7],res2[,4])
auc2=auc(roc2)
roc3<-roc(res3[,5],res3[,3])
auc3=auc(roc3)
roc4<-roc(res4[,5],res4[,3])
auc4=auc(roc4)
roc5<-roc(res5[,5],res5[,3])
auc5=auc(roc5)

auc1
auc2
auc3
auc4
auc5
#draw the ROC
ggroc1 <- ggroc(list(GCNPCC=roc1,scLink=roc2,GENIE3=roc3,SCODE=roc4,GRNBoost2=roc5),size = 1.5,legacy.axes = TRUE)+
  theme(panel.background = element_rect(fill = "white",color="black"),panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme(legend.position=c(0.88,0.12))+theme(legend.text=element_text(size=15, face="plain"))+
  theme(legend.background=element_rect(fill="white", colour="black"))+scale_y_continuous(expand = c(0, 0))+
  scale_x_continuous(expand = c(0, 0))+ labs(color = NULL)
ggroc1+
  annotate("text",x=c(0.28,0.28,0.28,0.28,0.28),
           y=c(0.97,0.935,0.9,0.865,0.83),
           label=c("GCNPCC : 0.5877", "scLink : 0.5093", "GENIE3 : 0.5314", "SCODE : 0.5159", "GRNBoost2 : 0.5305"),
           size = 5, fontface = "bold", family = "A", hjust = 1)+
  xlab("false positive rate")+theme(axis.title.x = element_text(size = 17,face = "plain",vjust = -1))+
  ylab("true positive rate")+theme(axis.title.y = element_text(size = 17,face = "plain",vjust = 3))+
  theme(axis.text.y = element_text(size = 14,face = "bold",angle = 90,vjust=1,hjust=0.5))+
  theme(axis.text.x = element_text(size = 14,face = "bold",vjust=-0.3,hjust=0.5))+
  theme(plot.margin = unit(rep(1,4),'lines'))
