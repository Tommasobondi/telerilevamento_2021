library(raster)
library(RStoolbox)
library(ggplot2)
#https://ggplot2-book.org/    this pack work with everykinde of dataset
setwd("C:/lab/vege")
#now we need a dataset, but is a multilevel dataset, so func. brick
d1<-brick("defor1.jpg")
#visualize info and plot
d1
plotRGB(d1, r=1, g=2, b=3, stretch="lin")
#ggR: Plot single layer imagery in grey-scale. Can be used with any Raster* object -> 
#ggRGB: Create ggplot2 Raster Plots with RGB from 3 RasterLayers
#Calculates RGB color composite raster for plotting with ggplot2. Optional values for clipping and and stretching can be used to enhance the imagery.
ggRGB(d1, r = 1, g = 2, b = 3, stretch = "lin")
dev.off()
#same for def 2
d2<-brick("defor2.jpg")
ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
#compariosn
par(mfrow=c(1,2))
ggRGB(d1, r = 1, g = 2, b = 3, stretch = "lin")
ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
#note that classic function par don't work on ggRGB
# function gridExtra: Miscellaneous Functions for "Grid" Graphics. 
#Provides a number of user-level functions to work with "grid" graphics, notably to arrange multiple grid-based plots on a page, and draw tables.
install.packages("gridExtra")
library(gridExtra)
dg1<-ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
dg2<-ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
grid.arrange(dg1, dg2, nrow=2)
