#take a look at the concept of statistic diversity and varyability
setwd("C:/lab")
library(raster)
library(RStoolbox)
#use functin brick, muklti set data ("raster" onli one set)
jari<-brick("p224r63_2011_masked")
#plot and visualize carateristich of immagine
plot(jari)
jari
#now i plot only blue band and red band (to know the names tacke a look at imm.car.)/ in datafile i have 7 band
#use $to bond band with its immagine, you can chang col with col=bxjcbaj, you can change pch (?), use argomument "cex" to enlarge the point dimension
#the X,Y axys position of variable depend on the aroument's order (x first, y second)
plot(jari$B1_sre, jari$B2_sre, pch=20)
#to plot all the possible correlation of the dataset use the functin pairs
#take a look at the matrix, is a matrix of covariance (the index is te prixon 1/-1)
pairs(jari)
#raster aggregate: PCAprocess take tame, so could be useful  the immagine.
#with raster aggregate (resample) i unify near pixel in a avareg pixel with lower definition 8es. from 4 pixel i create 1 that rappresent a major portion of territory, >definition
#is the same that you did in geospatial analysis, resample of v003
#in argoument method of recampioning, immagine that pixel are going to be aggregate, factor of aggregatiion( every x pixel one new)
jari_res<-aggregate(jari, fact=10)
#take a look at the comparison, our pixel now rappresent 100m of territory, lower reolution( data and plot, plotted with plotRGB. stretch lin, natural)
jari_res
jari
par(mfrow=c(2,1))
plotRGB(jari, r=4, g=3, b=2, stretch="lin")
plotRGB(jari_res, r=4, g=3, b=2, stretch="lin")
dev.off()
#RasterPCA,i create new compnent from two correalted, see the booknote/ the function crate a pca but also the map that explain the variability explicated by the various component
jari_res_pca<-rasterPCA(jari_res)
#function SUMMARY that give us a summary of our model, how and how much various band(variablex) expleain the model
summary(jari_res_pca$model)
#usual plot with obyect bounded with the relative model
plot(jari_res_pca$map)
#take a look at the mimmagine, now the first component explain more or less the total of variability
jari_res_pca


#$call
#rasterPCA(img = jari_res)
#$model
#Call:
#vrincomp(cor = spca, covmat = covMat[[1]])
#Standard deviations:
#      Comp.1       Comp.2       Comp.3       Comp.4       Comp.5       Comp.6 
#1.2050671362 0.0461548802 0.0151509516 0.0045752199 0.0018413569 0.0012333745 
#      Comp.7 
#0.0007595367 
#7  variables and  44550 observations.
#$map
#class    : RasterBrick 
#imensions : 150, 297, 44550, 7  (nrow, ncol, ncell, nlayers)
#esolution : 300, 300  (x, y)
#xtent     : 579765, 668865, -522735, -477735  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
#source     : memory
#names      :         PC1,         PC2,         PC3,         PC4,         PC5,         PC6,         PC7 
#min values : -1.96808463, -0.30213565, -0.07212306, -0.02976086, -0.02695826, -0.01712903, -0.00744772 
#max values : 6.065280099, 0.142898206, 0.114509980, 0.056825410, 0.008628344, 0.010537390, 0.005594290 
#r(,"class")
#1] "rasterPCA" "RStoolbox"


dev.off()
#now plot rgb to visualize teh new immagine in its'tota (information visualiziable)
plotRGB(jari_res_pca$map, r=4, g=3, b=2, stretch="lin")
