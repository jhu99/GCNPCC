library(DOSE)
library(org.Mm.eg.db)
library(topGO)
library(clusterProfiler)
library(pathview)
library(ggplot2)
library(stringr)
library(GOplot)

keytypes(org.Mm.eg.db)
#gene
new_Est1 <- read.csv("new_Est100.csv")
new<-new_Est1[,1]
x1 <- c(new[1:38])
x2 <- c(new[39:63])
x3 <- c(new[64:81])
#x4 <- c(new[62:76])
x4<<-c("Atf7ip","H2ac18","H2ac6","H2bc18","Amdhd2","H4c12","H4c18","H2ac12","H2bc13","H2bc12","H2ac13","Hexa","H2ac22","H3c11","H3c3","H2ac24","H3c10","H2bc7","Pgk1")

#module1
#基因ID转换
gene.df1 = bitr(x1, #数据集
                fromType="SYMBOL", #输入为SYMBOL格式
                toType="ENTREZID",  # 转为ENTERZID格式
                OrgDb="org.Mm.eg.db")  #小鼠 数据库
gene1 <- gene.df1$ENTREZID
#GO富集
ego_ALL1 <- enrichGO(gene = gene1,         #基因ID
                     OrgDb=org.Mm.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         #富集的GO类型
                     pAdjustMethod = "BH",#矫正方式，这个不用管，一般都用的BH
                     pvalueCutoff = 1, #P值可以取0.05，P值进行过滤，1全部输出
                     qvalueCutoff = 1,
                     readable = TRUE)
ego_result_ALL1 <- as.data.frame(ego_ALL1)
write.csv(ego_result_ALL1,file = "p1.csv")
barplot(ego_ALL1, showCategory=10)

#module2
#基因ID转换
gene.df2 = bitr(x2, #数据集
                fromType="SYMBOL", #输入为SYMBOL格式
                toType="ENTREZID",  # 转为ENTERZID格式
                OrgDb="org.Mm.eg.db")  #小鼠 数据库
gene2 <- gene.df2$ENTREZID
#GO富集
ego_ALL2 <- enrichGO(gene = gene2,         #基因ID
                     OrgDb=org.Mm.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         #富集的GO类型
                     pAdjustMethod = "BH",#矫正方式，这个不用管，一般都用的BH
                     pvalueCutoff = 1, #P值可以取0.05，P值进行过滤，1全部输出
                     qvalueCutoff = 1,
                     readable = TRUE)
ego_result_ALL2 <- as.data.frame(ego_ALL2)
write.csv(ego_result_ALL2,file = "p2.csv")
barplot(ego_ALL2, showCategory=10)

#module3
#基因ID转换
gene.df3 = bitr(x3, #数据集
                fromType="SYMBOL", #输入为SYMBOL格式
                toType="ENTREZID",  # 转为ENTERZID格式
                OrgDb="org.Mm.eg.db")  #小鼠 数据库
gene3 <- gene.df3$ENTREZID
#GO富集
ego_ALL3 <- enrichGO(gene = gene3,         #基因ID
                     OrgDb=org.Mm.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         #富集的GO类型
                     pAdjustMethod = "BH",#矫正方式，这个不用管，一般都用的BH
                     pvalueCutoff = 1, #P值可以取0.05，P值进行过滤，1全部输出
                     qvalueCutoff = 1,
                     readable = TRUE)
ego_result_ALL3 <- as.data.frame(ego_ALL3)
write.csv(ego_result_ALL3,file = "p3.csv")
barplot(ego_ALL3, showCategory=10)

#module4
#基因ID转换
gene.df4 = bitr(x4, #数据集
                fromType="SYMBOL", #输入为SYMBOL格式
                toType="ENTREZID",  # 转为ENTERZID格式
                OrgDb="org.Mm.eg.db")  #小鼠 数据库
gene4 <- gene.df4$ENTREZID
#GO富集
ego_ALL4 <- enrichGO(gene = gene4,         #基因ID
                     OrgDb=org.Mm.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         #富集的GO类型
                     pAdjustMethod = "BH",#矫正方式，这个不用管，一般都用的BH
                     pvalueCutoff = 1, #P值可以取0.05，P值进行过滤，1全部输出
                     qvalueCutoff = 1,
                     readable = TRUE)
ego_result_ALL4 <- as.data.frame(ego_ALL4)
write.csv(ego_result_ALL4,file = "p4.csv")
barplot(ego_ALL4, showCategory=10)

#All100基因
#基因ID转换
new<-new[-82:-100]
new<-c(new,x4)
gene.dfAll = bitr(new, #数据集
                  fromType="SYMBOL", #输入为SYMBOL格式
                  toType="ENTREZID",  # 转为ENTERZID格式
                  OrgDb="org.Mm.eg.db")  #小鼠 数据库
geneAll <- gene.dfAll[,2]
#GO富集
ego_ALL5 <- enrichGO(gene = geneAll,         #基因ID
                     OrgDb=org.Mm.eg.db,
                     keyType = "ENTREZID",
                     ont = "ALL",         #富集的GO类型
                     pAdjustMethod = "BH",#矫正方式，这个不用管，一般都用的BH
                     pvalueCutoff = 1, #P值可以取0.05，P值进行过滤，1全部输出
                     qvalueCutoff = 1,
                     readable = TRUE)
ego_result_ALL5 <- as.data.frame(ego_ALL5)
write.csv(ego_result_ALL5,file = "all.csv")
barplot(ego_ALL5, showCategory=10)



#p.adj热图
df<-read.csv("4hot6.csv",header = T)
df[,2] <- -log10(df[,2])       #取-log10，越大越好
df[,3] <- -log10(df[,3])
df[,4] <- -log10(df[,4])
df[,5] <- -log10(df[,5])
df[,1]<-rev(df[,1])   #颠倒顺序
df[,2]<-rev(df[,2])
df[,3]<-rev(df[,3])
df[,4]<-rev(df[,4])
df[,5]<-rev(df[,5])
df[is.na(df)] <- 0     #用0代替NA

#有重复
df<-df[-11:-12,]
#转换成3列
df1<-reshape2::melt(df,var.id="Description")
#设置level，固定顺序
df1$Description<-factor(df1$Description,levels = df$Description)
#head(df1)
library(ggplot2)
ggplot(df1,aes(x=variable,y=Description))+
  geom_tile(aes(fill=value),color="#A3A3A3")+
  scale_x_discrete(expand = c(0,0))+
  scale_y_discrete(expand = c(0,0),position = "right")+
  theme(panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text.x = element_text(hjust=0.5,vjust = 0.5))+
  scale_fill_gradient(low="#003377",high="#ff6633")+
  theme(axis.text=element_text(size=13))+
  theme(plot.margin = unit(rep(1,4),'lines'))
