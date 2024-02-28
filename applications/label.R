#set a label for each edge
library(hash)
Est<-abs(Est)
rownames(Est)<-g
colnames(Est)<-g
row<-vector()
col<-vector()
data<-vector()
k=1
for(i in 1:100){
  for(j in 1:100){
    row[k]<-g[i]
    col[k]<-g[j]
    data[k]<-Est[i,j]
    k=k+1
  }
}
gt <- read.csv("network.csv",,header = TRUE, sep = ",", quote = "\"",
               dec = ".", fill = TRUE, comment.char = "!")
#extracting the edges of the genes in ground truth that are in 100
Gene1<-vector()
Gene2<-vector()
k=1
c<-dim(gt)[1]
for(i in 1:c){
  if(gt[i,1] %in% g & gt[i,2] %in% g){
    Gene1[k]<-gt[i,1]
    Gene2[k]<-gt[i,2]
    k=k+1
  }
}
gt<-cbind(Gene1,Gene2)    
com1<-paste(gt[,1], gt[,2],sep = "")    
gt<-cbind(gt,com1)
com2<-paste(e[,1], e[,2],sep = "")   
e<-cbind(e,com2)
d<-dim(gt)[1]
h <- hash( keys=com1, values=1:d)
#find the label of m edges
m<-dim(e)[1]  
label<-rep(0,m)
for(i in 1:m){
  if(has.key(com2[i], h)){
    label[i]=1
  }
  else{
    label[i]=0
  }
}
len_label <- length(which(label==1))      
res<-cbind(e,label)
write.table (res, file ="res.txt", sep ="\t", row.names =FALSE, col.names =TRUE, quote =FALSE)

