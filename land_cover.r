library(raster)
library(RStoolbox)
library(ggplot2)
setwd("C:/lab/vege")
#https://ggplot2-book.org/
#now we need a dataset, but is a multilevel dataset, so func. brick
d1<-brick("defor1.jpg")
#visualize info and plot
d1
plotRGB(d1, r=1, g=2, b=3, stretch="lin")

