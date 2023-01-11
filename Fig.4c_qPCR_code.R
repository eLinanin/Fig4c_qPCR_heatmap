install.packages('heatmaply')
library(heatmaply)
PCR <- read.csv("..path to your folder here..\\Figure 4 - Source Data 2.csv",sep=",")
row.names(PCR)<- PCR$RUN1
PCR<-PCR[,2:11]
PCRLog<-log10(PCR)
PCR_matrix<-data.matrix(PCRLog)
min(PCR_matrix[is.finite(PCR_matrix)])
#set the minimum value
PCR_matrix[which(!is.finite(PCR_matrix))] <- -5.20
PCR_matrix<-t(PCR_matrix)

# cluster rows
hc.rows<-hclust(dist(PCR_matrix))
plot(hc.rows,axes=F, main = NULL, sub = NULL)

# transpose the matrix and cluster columns
hc.cols <- hclust(dist(t(PCR_matrix)))
set.seed(55)
#Final heatmap
heatmaply(PCR_matrix, Colv=as.dendrogram(hc.cols), scale='none',col=BuPu(256), rect_gp = "black",grid_color = "grey",grid_size = 0.01,  show_dendrogram = c(T, F),
          fontsize_row = 15)
