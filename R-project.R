#R-project
#URL for github repository= https://github.com/c00305146/R-project

#reading in the data-
library(tidyverse)
A=read_csv("all_samples.csv")

#Application of the appropriate data storage structure: list, data frame, matrix or array (2 points)-
str(A)

#Example of indexing (2 points)-
#indexing % methylation
A[,4]
#indexing depth of collections
A[,6]

#Ordering (2 points)- 
#order from increasing depth
B= arrange(A, Depth)
#order from increaseing methylation
C= arrange(A, Methylation)

#Summarizing (5 points)-
library(tidyverse)
#average depth and methylation
D=summarise(A, meanmeth=mean(Methylation),meandepth=mean(Depth, na.rm = T))

#Range of Methylation and Depth
methrange=range(A$Methylation)
methrange=as.data.frame(methrange)
methrange$seq=seq(1,nrow(methrange),1)
depthrange=range(A$Depth)
depthrange=as.data.frame(depthrange)
depthrange$seq=seq(1,nrow(depthrange),1)
#Merge ranges of methylation and depth
E=merge(x=depthrange,y=methrange,by="seq",no.dups=T,all.x=T)

#Custom function(s) (10 points) -
#‘if else’ statement (10 points)-
#‘for loop’ (10 points) -
#function to make dark, light or shallow in Range colomn
A$Range=NA
Rangefunc=function(x){
  if(x>0& x<=200.0)
    A[i,]$Range="shallow"
  else if (x>200.0& x<=1000.0)
    A[i,]$Range="light"
  else
    A[i,]$Range="dark"
}

for(i in 1:nrow(A)){
  A[i,]$Range<-Rangefunc(x=A[i,]$Depth)
}
A$Range

#Exporting data set (2 points) 
save(A, file="all_samples_range.csv")

#Histogram plot (5 points)-
#histogram of the %methylation
library(ggplot2)
ggplot(data = A,aes(x=Methylation))+
  geom_histogram(binwidth = 0.3)
#histogram of the depth
ggplot(data = A,aes(x=Depth))+
  geom_histogram(binwidth =200.0)

#Point, bar, or line plot (whichever makes the most sense) (5 points)-
#point graph of methylation vs. depth
ggplot(data = A,aes(x=Depth,y=Methylation))+
  geom_point()

#‘ggplot’ with at least 2 geoms (e.g. point, bar, tile), use one of the ‘scale_’ geoms, and adjusting the theme of the plot (10 points)-
plot=ggplot(A)+ 
  geom_point(data=A,aes(x=Depth, y=Methylation))+
  geom_rect(data=A, aes(xmin=Start,xmax=End,fill=Range),
            ymin=-Inf,ymax=Inf,alpha=0.04)+
  scale_fill_manual(values = c("firebrick","brown2","orange"))+
  theme_classic()+
  ggtitle(label = "Depth vs %Methylation")

#Exporting and saving figures from ggplot (2 points)
ggsave(filename =("Depth vs Methylation.tiff"),
       plot = plot, width = 4, height = 3, units = 'in',
       dpi = 300)

# A map of showing the geographic location where the data was collected (10 points)-
library(rgdal)
library(sp)
library(maptools)
library(tidyverse)
library(osmdata)
library(ggmap)
#Subset Depths --------------------------------------------------------------
shallow=A[A$Range=="shallow",]
light=A[A$Range=="light",]
dark=A[A$Range=="dark",]
# Plot Points by Depth -------------------------------------------------------------
data(wrld_simpl)
plot(wrld_simpl, xlim=c(-100,100), ylim=c(-100,100), axes=TRUE, col="gray")
box()

points(shallow$Long, shallow$Lat, col='blue', pch=20, cex=1.5)
points(light$Long, light$Lat, col='green', pch=20, cex=1.5)
points(dark$Long, dark$Lat, col='red3', pch=20, cex=1.5)
