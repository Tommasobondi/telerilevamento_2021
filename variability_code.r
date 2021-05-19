#install.packages("viridis")
#viridis is a pack useful for the manage of the colour - https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(raster)
library(RStoolbox)
library(ggplot2)
library(viridis)
library(gridExtra)
setwd("C:/lab/sim")
#this immagine is a 3 band immagine (previously elaborated, so funct brick, to import the dataset, otherwise raster
sent<-brick("sentinel.png")
#is a rgb multileve-immagine - https://www.rdocumentation.org/packages/raster/versions/3.4-10/topics/plotRGB
#we know that the sequence of layer (nir, green, blue) is already setted (nir=1, green=2, blue=3), so we can forget to wrote it in the argoument
plotRGB(sent, stretch="lin")
#standard deviation-by using only one band we calcoulate it, firt take a look at the immagine's data
sent
nir<-sent$sentinel.1
red<-sent$sentinel.2
#obiviusly the variability must be calcuolated on "somethig"-> ndvi index (see veg ind code)
#ndvi=(nir-red)/(nir+red)
ndvi <- (nir-red)/(nir+red)
plot(ndvi)
#compare "nir" with "sent", look at the distribution of the vegetation ad the geospatial shape of the area
cl<-colorRampPalette(c("black","white","red","magenta","green"))(100)
plot(ndvi,col=cl)
#in the moving window that we set we can calculate one of the statistric value present in the function-https://www.rdocumentation.org/packages/raster/versions/3.0-12/topics/focal
#in argoument first the dataset, then set the matrix( argoument W(for window)) (wind usually is a square, to deny redundance(isotropy of point), but it can have variety of shape)
ndvi3<-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvi3, col=clsd)
#now, with this plot, we have visulized the st.dev of nir index, so the dev.stand of the vegetation in this area, based on th st.dev of the refletance
#now we calcuolate the mean, so the mean of the biomassa in this immagine
ndvi4<-focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvi4, col=clsd)
#change the dimension of the moving window, on tand.dev
ndvi5<-focal(ndvi, w=matrix(1/81, nrow=9, ncol=9), fun=sd)
plot(ndvi5, col=clsd)
#comparion of two windows, nb: i'm not changhing the resolutin of the immagine, im just changing the area on witch i calcoulate the statistisc index, uasually it depends by the kinde of enviromente
par(mfrow=c(1,2))
plot(ndvi5, col=clsd)
plot(ndvi3, col=clsd)
