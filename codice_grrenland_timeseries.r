#now we test the changing of temperature in greenland year by year
#same base functin of codice commentato in mine github
library(raster)
setwd("C:/lab/greenland")
#now we charge the datatset in R with function raster(diverso da codice precente, dove caricavo con brick), the i plot it to see
duemila<-raster("lst_2000.tif")
plot(duemila)

