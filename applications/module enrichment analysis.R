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
#基因
new_Est <- read.csv("new_Est.csv")
new<-new_Est[,1]
x1 <- c(new[1:7])
x2 <- c(new[8:39])
x3 <- c(new[40:57])
x4 <- c(new[58:100])

#module1
gene.df1 = bitr(x1, 
                fromType="SYMBOL", 
                toType="ENTREZID",  
                OrgDb="org.Hs.eg.db")  
gene1 <- gene.df1$ENTREZID
ego_ALL1 <- enrichGO(gene = gene1,         
                     OrgDb=org.Hs.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         
                     pAdjustMethod = "BH",
                     pvalueCutoff =1, 
                     qvalueCutoff =1,
                     readable = TRUE)
ego_result_ALL1 <- as.data.frame(ego_ALL1)
write.csv(ego_result_ALL1,file = "p1.csv")
barplot(ego_ALL1, showCategory=10,title="EnrichmentGO_ALL")

#module2
gene.df2 = bitr(x2, 
                fromType="SYMBOL", 
                toType="ENTREZID", 
                OrgDb="org.Hs.eg.db")  
gene2 <- gene.df2$ENTREZID
ego_ALL2 <- enrichGO(gene = gene2,         
                     OrgDb=org.Hs.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         
                     pAdjustMethod = "BH",
                     pvalueCutoff =1, 
                     qvalueCutoff =1,
                     readable = TRUE)
ego_result_ALL2 <- as.data.frame(ego_ALL2)
write.csv(ego_result_ALL2,file = "p2.csv")
barplot(ego_ALL2, showCategory=10)

#module3
gene.df3 = bitr(x3, 
                fromType="SYMBOL", 
                toType="ENTREZID", 
                OrgDb="org.Hs.eg.db") 
gene3 <- gene.df3$ENTREZID
ego_ALL3 <- enrichGO(gene = gene3,        
                     OrgDb=org.Hs.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",       
                     pAdjustMethod = "BH",
                     pvalueCutoff =1,
                     qvalueCutoff =1,
                     readable = TRUE)
ego_result_ALL3 <- as.data.frame(ego_ALL3)
write.csv(ego_result_ALL3,file = "p3.csv")
barplot(ego_ALL3, showCategory=10)


#p.adj hotmap
#integrate pathways for each module
df<-read.csv("hot.csv",header = T)
#remove duplicate pathways
df<-df[-7,]
df<-df[-16,]  
df[,2] <- -log10(df[,2])       
df[,3] <- -log10(df[,3])
df[,4] <- -log10(df[,4])
df[,1]<-rev(df[,1])
df[,2]<-rev(df[,2])
df[,3]<-rev(df[,3])
df[,4]<-rev(df[,4])
df[is.na(df)] <- 0    
#convert to 3 columns
df1<-reshape2::melt(df,var.id="Description")
#setting level, fixed order
df1$Description<-factor(df1$Description,levels = df$Description)
ggplot(df1,aes(x=variable,y=Description))+
  geom_tile(aes(fill=value),color="grey")+
  scale_x_discrete(expand = c(0,0))+
  scale_y_discrete(expand = c(0,0),
                   position = "right")+
  theme(panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text.x = element_text(hjust=0.5,vjust = 0.5))+
  scale_fill_gradient(low="#003377",high="#ff6633")+
  theme(axis.text=element_text(size=18))

