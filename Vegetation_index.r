library(raster)
setwd("C:/lad/vege")
de1<-brick(defor1.jpg)
de2<-brick(defor2.jpg)
#done the usual stuff, i plot the mimmagine
#RGB immgine (pre  elaborated)( b1=Nir, b2=blue, b3= green
mfrow(
