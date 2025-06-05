library(DOSE)
library(org.Mm.eg.db)
library(topGO)
library(clusterProfiler)
library(pathview)
library(ggplot2)
library(stringr)
library(GOplot)
keytypes(org.Mm.eg.db)
#mESC dataset
x <- c("Sox2","Nanog","Esrrb","Zfp42","Gata4","Phc1")
gene.df = bitr(x,
               fromType="SYMBOL",
               toType="ENTREZID",
               OrgDb="org.Hs.eg.db")
gene <- gene.df$ENTREZID

#BP
ego_BP <- enrichGO(gene = gene,
                   OrgDb=org.Mm.eg.db,
                   keyType = "ENTREZID",
                   ont = "BP",
                   pAdjustMethod = "BH",
                   pvalueCutoff = 1,
                   qvalueCutoff = 1,
                   readable = TRUE)
ego_result_BP <- as.data.frame(ego_BP)
barplot(ego_BP, showCategory=20) +
  theme(legend.text = element_text(size = 13), legend.title = element_text(size = 15))+
  theme(axis.text.x = element_text(size = 14))+
  theme(axis.text.y = element_text(size = 14))+
  theme(axis.title.x = element_text(size = 16,face = "plain",vjust = -1))+
  theme(plot.margin = unit(rep(1,4),'lines'))

ego_result_BP1<-ego_result_BP[1:20,]
ego_result_BP1<-ego_result_BP1[,-1]
ego_result_BP1<-ego_result_BP1[,-2:-7]
ego_result_BP1<-ego_result_BP1[,-3:-4]
ego_result_BP1$Description <- factor(ego_result_BP1$Description, levels = rev(ego_result_BP1$Description))

ggplot(ego_result_BP1, aes(x = Description, y = Count, fill = p.adjust)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "#E06663", high = "#327EBA",guide=guide_colorbar(reverse = TRUE)) +
  theme(legend.text = element_text(size = 13),
        legend.title = element_text(size = 15)) +
  theme(axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 16, face = "plain", vjust = -1),
        axis.title.y=element_text(size=16),
        plot.margin = unit(c(1, 1, 1.5, 0.5), 'lines'),
        panel.background = element_rect(fill = "white", color = "black"),
        panel.grid.major = element_line(color = "#EFEFEF"),
        panel.grid.minor = element_line(color = "#EFEFEF"),
        panel.border = element_blank()) +
  xlab("")+
  ylab("Count") +
  coord_flip()

#bar chart of the top ten pathways
BP<-data.frame(cbind(ego_result_BP[,2],ego_result_BP[,9],ego_result_BP[,11],ego_result_BP[,12]))
BP<-head(BP,10)
BP[,2]<-as.numeric(BP[,2])
colnames(BP)<-c("Description","p.adj","geneID","count")
BP$Description<-factor(BP$Description,levels = c("response to retinoic acid","endoderm formation","endoderm development" ,"somatic stem cell population maintenance" ,"formation of primary germ layer" ,"regulation of stem cell division" ,"endodermal cell fate commitment", "gastrulation","stem cell population maintenance","maintenance of cell number" ))
BP$geneID<-str_replace_all(BP$geneID,"/",",")  #修改分隔符号
geneID<-BP$geneID
BP[,2] <- -log10(BP[,2])
p<-ggplot(data=BP,aes(x=Description,y=p.adj))+
  geom_bar(stat="identity",width=0.8,fill="#FF8361")+ylab("-log10(p.adj)")+
  theme_minimal()+geom_text(aes(label=geneID), hjust=-0.15,size=4)+
  scale_y_continuous(limits=c(0,20), breaks=c(0,5,10))+
  theme_classic()+theme(panel.grid=element_blank(), plot.margin = margin(t = 1,
                                                                         r = 1,
                                                                         b = 0.5,
                                                                         l = 0.5,
                                                                         unit = "cm"))

p + coord_flip()+
  theme(axis.text=element_text(size=12),axis.title.x =element_text(size=16), axis.title.y=element_text(size=16))
