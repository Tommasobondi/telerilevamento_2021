#now we test the changing of temperature in greenland year by year
#same base functin of codice commentato in mine github
library(raster)
setwd("C:/lab/greenland")
#now we charge the datatset in R with function raster(diverso da codice precente, dove caricavo con brick), the i plot it to see every immagine charged with functin raster
#remenber that raster is a kinde of immagine with raster indica la griglia ortogonale di punti che costituisce un'immagine raster. Nella grafica raster l'immagine viene
#vista come una scacchiera e ad ogni elemento della scacchiera, chiamato pixel, viene associato uno specifico colore.
duemila<-raster("lst_2000.tif")
plot(duemila)
dev.off()
cinque<-raster("lst_2005.tif")
plot(cinque)
dev.off()
dieci<-raster("lst_2010.tif")
plot(dieci)
dev.off()
quindici<-raster("lst_2015.tif")
plot(quindici)
dev.off()

