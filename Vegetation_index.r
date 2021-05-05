library(raster)
setwd("C:/lab/vege")
de1<-brick("defor1.jpg")
de2<-brick("defor2.jpg")
#done the usual stuff, i plot the mimmagine
#RGB immgine (pre  elaborated)( b1=Nir, b2=blue, b3= green)
par(mfrow=c(2,1))
plotRGB(de1, r=1, g=2, b=3, stretch="lin")
plotRGB(de2, r=1, g=2, b=3, stretch="lin")
#we have comparated the tow immagines in a multytemporal logic, sample plot RGB with Nir on red
#now i will create a index vegetation for both of the immagines, and compare them(same place, different time)
#NDVI index (nir, red)
#NDVI1 (nir-red de1)
de1
#visualize name of band of intrest
#i bound evry pixel of the immagine(de1$def...) with the band and then i subtract (line 13)
#output is a immgine with in every pixel nir-red of the original band of immagine def1
dvi1= de1$defor1.1 - de1$defor1.2 
#visualize, set colours
dev.off
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
dev.off()
#comparison if dvi index in time series (dvi1, dvi2)
dvi2= de2$defor2.1 - de2$defor2.2
plot(dvi2, col=cl)
dev.off()
#multitempan-> title to immagine
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time1")
plot(dvi2, col=cl, main="DVI at time2")
#with the same logic of subtraction of vlaue for every pixel, i crate a map of dvi index difference at time1-time2
dvidiff<- dvi1-dvi2
#new legend for colour that rappresent the difference between index, different from above where colour rappresent value
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidiff, col=cld, main="DVI difference time1-time2")
dev.off()
#NDVI is a relative index (normalize the value with the sum of variables (range: -1 -- 1))
# (NIR-RED)/(NIR+RED)
#i can also write dvi1-(de1$defor1.1 + de1$defor1.2) es.
ndvi1= (de1$defor1.1 - de1$defor1.2)/(de1$defor1.1 + de1$defor1.2)
ndvi2= (de2$defor2.1 - de2$defor2.2)/(de2$defor2.1 + de2$defor2.2)
par(mfrow=c(2,1))
plot(ndvi1, col=cl, main="NDVI at time1")
plot(ndvi2, col=cl, main="NDVI at time2")
ndvi1
#look at the value range (-1/1)
dev.off()
#with the same logic of subtraction of vlaue for every pixel, i crate a map of NDVI index difference at time1-time2
ndvidiff<- ndvi1-ndvi2
plot(ndvidiff, col=cld, main="NDVI difference time1-time2")
#take a look the index are the same (in scale)
#par(mfrow=c(2,1))
#plot(ndvidiff, col=cld, main="NDVI difference time1-time2")
#plot(dvidiff, col=cld, main="DVI difference time1-time2")

#in RStoolbox function "spectralIndices" to calcoulate vegetation index !!!!!!!!!
library(RStoolbox)
#in argoument i mus declare the band and the immagine that i want to elaborate (plot with colourramppalette cl)
#time2
vegind1<-spectralIndices (de1, green=3, red=2, nir=1)
plot(vegind1, col=cl)
#time2
vegind2<-spectralIndices (de2, green=3, red=2, nir=1)
plot(vegind2, col=cl)
#Diversity Indices for Numerical Matrices.Providing functions to calculate indices of diversity on numerical matrices based on information theory.
install.packages("rasterdiv")
library(rasterdiv)
#In th package is included "copNDVI".A RasterLayer (EPSG: 4326) of the global average NDVI value per pixel for the 21st of June overthe period 1999-2017.
plot(copNDVI)
#in the packages i can also found the argoumenmt for reclasssifdicaton of the layer copNDVI. delete the water surface
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)
#In pack. rasterVis is conteined func. levelplot. Draw Level Plots and Contour plots. so we can see contour plots in the copNDVI layer contained in pack. rasterdiv
#look at "greenland code" for more info on levelplot
library(rasterVis)
levelplot(copNDVI)

