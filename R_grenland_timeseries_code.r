#now we test the changing of temperature in greenland year by year
#same base functin of codice commentato in mine github + rasterVis
#https://cran.r-project.org/web/packages/rasterVis/rasterVis.pdf
library(raster)
library(rasterVis)
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
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list.files
list<-list.files(pattern="lst")
list
#functin lapply to apply a determiate function (uor case func. raster), on a detemrita obyect( vedi linee 26-30)
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply
import<-lapply(list,raster)
#now i crate a single file from the 4 that i've imported, function stack, (import a list with functin lapply, then unify the 4 file in a new one)
#https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/stack
filenew<-stack(import)
#i visualize the new object (filenew) with plot
plot(filenew)
#with function "levelplot" i assigne a unique legend to the entire block of pixel of the immagine (in uor case pix of col and row are pixel of long and lat)
#es. levelplot of stacked immagine
#https://www.rdocumentation.org/packages/lattice/versions/0.10-10/topics/levelplot
#https://www.r-graph-gallery.com/27-levelplot-with-lattice.html
levelplot(filenew)
#es. levelplot of single immagine
levelplot(dieci)
#function color ramp palette on levelplot (now col.regions, not "col")
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#es.
levelplot(dieci, col.regions=cl)
dev.off()
#es.
levelplot(filenew, col.regions=cl)
dev.off()
#change attribute's names 
levelplot(filenew,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#change title of grafics
levelplot(filenew,col.regions=cl, main="temperature change in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
dev.off()
#now we use melt data, same as above
setwd("C:/lab/melt")
melt<-list.files(pattern="annual")
melt
importmelt<-lapply(melt,raster)
newmelt<-stack(importmelt)
#wiew file charateristic
newmelt
levelplot(newmelt)
dev.off()
#mat operation between data matrix( a single immagine is a matrix were the singli pixel rapprent a value, in our case the melt)
#stack function, we have to bond single immagine name with stack file ($)
melt_amount <- newmelt$2007annual_melt.tif - newmelt$1979annual_melt.tif
dev.off()
