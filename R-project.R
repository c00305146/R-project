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

#Subsetting (2 points) -
litsamples=A[A$Range=="light",]
darksamples=A[A$Range=="dark",]
shallowsamples=A[A$Range=="shallow",]

#Ordering (2 points)- 
#order from increasing depth
B= arrange(A, Depth)
#order from increaseing methylation
C= arrange(A, Methylation)
#Summarizing (5 points) 
library(tidyverse)
#average depth and methylation
D=summarise(A, meanmeth=mean(Methylation),meandepth=mean(Depth, na.rm = T))
#range of depth and methylation________________
E=summarise(A, rangemeth=range(Methylation))
summarise
#Merge or Join data frames (5 points) 
#join the two summarise together so they are in one data frame#######
#Custom function(s) (10 points) -
#‘if else’ statement (10 points)-
#make function to make dark, light or shallow
Rangefunc =function(x){
  if(x>0& x<=200)
    "shallow"
  else if (x>200& x<=1000)
    "light"
  else (x>=1000)
    "dark"
}

#Custom operator(s) (10 points) 
#‘for loop’ (10 points) 
#use funtion to for loop through data#####
# ‘ddply’ (10 points) 
#use ddply to clean up 1st and 2nd plates#####
#Histogram plot (5 points)
#make a histogram of the %methylation####
#Point, bar, or line plot (whichever makes the most sense) (5 points) 
#‘ggplot’ with at least 2 geoms (e.g. point, bar, tile), use one of the ‘scale_’ geoms, and adjusting the theme of the plot (10 points)
# A map of showing the geographic location where the data was collected (10 points)
#use code that is already made for this######
#Exporting data set (2 points) 
#Exporting and saving figures from ggplot (2 points) 