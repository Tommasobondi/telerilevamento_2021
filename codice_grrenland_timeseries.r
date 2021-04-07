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
#comparison between all 4 datataset
par(mfcol=c(2,2))
plot(duemila)
plot(cinque)
plot(dieci)
plot(quindici)
#we crate a list of files, These functions produce a character vector of the names of files or directories in the named directory.
#NB pattern "lst"n in this case, an optional regular expression. Only file names which match the regular expression will be returned.
# use "" in list because you are taking foerm outside the r mambient
list<-list.files(pattern="lst")
list
#functin lapply to apply a determiate function (uor case func. raster), on a detemrita obyect( vedi linee 26-30)
import<-lapply(list,raster)
#now i crate a single file from the 4 that i've imported, function stack, (import a list with functin lapply, then unify the 4 file in a new one)
filenew<-stack(import)
#i visualize the new object (filenew) with plot
plot(filenew)
