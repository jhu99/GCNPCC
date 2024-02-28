library(DOSE)
library(org.Hs.eg.db)
library(topGO)
library(clusterProfiler)
library(pathview)
library(ggplot2)
library(GOplot)
library(stringr)
library(dplyr)
keytypes(org.Hs.eg.db) 
#hESC dataset
x <- c("NANOG","HAPLN1","RHOBTB3","CER1","LHX1","CYP26A1","COL5A2","APOBEC3G","NRP1","SOX2")
gene.df = bitr(x, 
               fromType="SYMBOL", 
               toType="ENTREZID",  
               OrgDb="org.Hs.eg.db") 
gene <- gene.df$ENTREZID

#BP
ego_BP <- enrichGO(gene = gene,
                   OrgDb=org.Hs.eg.db,
                   keyType = "ENTREZID",
                   ont = "BP",
                   pAdjustMethod = "BH",
                   pvalueCutoff = 0.05,
                   qvalueCutoff = 0.05,
                   readable = TRUE)

ego_result_BP <- as.data.frame(ego_BP)
barplot(ego_BP, showCategory=20,title="EnrichmentGO_BP")

GO <-ego_BP[1:20,c(1,2,8,6)]  #选取富集结果的前20个，提取id,description,geneID,p.adj
GO$geneID<-str_replace_all(GO$geneID,"/",",")  #修改分隔符号
names(GO)=c("ID","Term","Genes","adj_pval")
GO$Category = "BP"
genedata = data.frame(ID=x,logFC=rnorm(length(x),mean=0,sd=2))
circ<-circle_dat(GO,genedata)

#bar chart of the top ten pathways
BP<-data.frame(cbind(ego_result_BP[,2],ego_result_BP[,6],ego_result_BP[,8],ego_result_BP[,9]))
BP<-head(BP,10)
BP[,2]<-as.numeric(BP[,2])
colnames(BP)<-c("Description","p.adj","geneID","count")
BP$Description<-factor(BP$Description,
                       levels = c("endodermal cell fate commitment",
                                  "urogenital system development",
                                  "cell fate specification",
                                  "renal system development",
                                  "kidney development",
                                  "endodermal cell differentiation",
                                  "formation of primary germ layer",
                                  "endoderm development",
                                  "gastrulation","endoderm formation"))
BP[,3]<-c("NANOG,LHX1,COL5A2,SOX2",
          "NANOG,CER1,LHX1,COL5A2,SOX2",
          "NANOG,LHX1,COL5A2,SOX2",
          "NANOG,LHX1,COL5A2,SOX2",
          "NANOG,COL5A2,SOX2",
          "CER1,LHX1,CYP26A1,NRP1",
          "CER1,LHX1,CYP26A1,NRP1",
          "NANOG,NRP1,SOX2",
          "CER1,LHX1,CYP26A1,NRP1",
          "NANOG,SOX2")
geneID<-BP$geneID
BP[,2] <- -log10(BP[,2])
p<-ggplot(data=BP,aes(x=Description,y=p.adj))+
  geom_bar(stat="identity",width=0.9,fill="#FF8361")+
  ylab("-log10(p.adj)")+theme_minimal()+
  geom_text(aes(label=geneID), hjust=-0.15,size=4.5)+
  scale_y_continuous(limits=c(0,10), breaks=c(0,2,4,6,8,10))+
  theme_classic()+theme(panel.grid=element_blank(),
  plot.margin = margin(t = 1, r = 1, b = 0.5, l = 0.5, unit = "cm"))
p + 
  coord_flip()+
  theme(axis.text=element_text(size=14),axis.title.x =element_text(size=17), axis.title.y=element_text(size=17))


