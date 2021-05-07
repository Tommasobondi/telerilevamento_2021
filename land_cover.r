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
dg1<-ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
dg2<-ggRGB(d2, r = 1, g = 2, b = 3, stretch = "lin")
grid.arrange(dg1, dg2, nrow=2)
dev.off()
#unsupervised claasificatio, unsupervised bescaus the cretation of the class is made by the softwere, so in argoument we just need to set argumente:number of class e number of campionje
#unsuperclass: https://cran.r-project.org/web/packages/RStoolbox/RStoolbox.pdf
d1c<-unsuperClass(d1, nClasses=2)
#plot and info
d1c
plot(d1c$map)
#class1 are the fildes, class2 rainforest, note that the river is included in class fildes ('cause of the n of classes, it's refletance is similar tho tnhe naked earth than to the forest, by the point of wiew of Nir band)
d1c<-unsuperClass(d1, nClasses=3)
#now c1=rainforest, c2=ground, c3=river
#same as above but at other epoque
d2c<-unsuperClass(d2, nClasses=2)
plot(d2c$map)
d2c
#now calcoulate the freq. of the classes
#form freq. we can count the number of pixel in both class, so, cause class rapresent a kinde of use of the gound (<nir, >nir), que can calcuolate the surface of the ground, rapp by pixel
#for bhot immagines so we cant compare then use of gound at different epoque
freq(d1c$map)
#value  count
#[1,]     1 307410
#[2,]     2  33882
s1 <- 307410+33882 #cechk above (d1)
freq(d2c$map)
#value  count
#[1,]     1 178737
#[2,]     2 163989
s2 <- 178737+163989
#now calc rel.freq foer every class at both epoque an comapre, using poportion of rainforest/agricolture in d1, d2
#also percentage is fine, freq.rel*100
#ford1<- 307410/s1
#agrid1<- 33882/s1
prop1<-freq(d1c$map)
#ford2<-178737/s2
#agri2<-163989/s2
prop2 <- freq(d2c$map) / s2
#dataset from the stat. count thata we had ceated
#data.frame: function to creatate a dataframe
#The function data.frame() creates data frames, tightly coupled collections of variables which share many of the properties of matrices and of lists, used as the fundamental data structure by most of R's modeling software.
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#now plot the dataset
#map calss to y istead x to flip 
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#now function grid.arrange
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.83, 10.16)
percent_2006 <- c(52.06, 47.93)
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#now plot the dataset
#map calss to y istead x to flip 
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#The grid package provides low-level functions to create graphical objects (grobs), and position them on a page in specific viewports
#this pack is included in grid.extre
grid.arange(p1, p2, nrow=1)













