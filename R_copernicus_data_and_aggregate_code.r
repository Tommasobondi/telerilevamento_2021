#how to visualize copoernicus data
#copernicus data shortcut in desktop
#https://drive.google.com/drive/folders/1Vk6DTfo32ol-goRobIfX0x7Gg19tjthz
library(rasterVis)
#ncdf4 useful to visualize .nc file format data
#https://cran.r-project.org/web/packages/ncdf4/ncdf4.pdf
library(ncdf4)
setwd("c:/lab/copernicus/")
#setted all the preliminary stuff, charge and visualize the dataset(use raster because i have only one layer)
cry<-raster("cryosphere.nc")
plot(cry)
cl <- colorRampPalette(c('blue','light blue','green','red','yellow'))(100)
plot(cry,col=cl)
#ricampiono variabile originale, la rendo piu leggera
#applico ricampionamento linerae, per ogni X pixel origianli creo 1 pixel nuovo con palore pari a media pixel originale
#funz è aggregate, argomento oggetto da ricampionare e fact fattore di riduzione)
#https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/aggregate
cryricamp <- aggregate(cry, fact=100)
plot(cryricamp, col=cl)
