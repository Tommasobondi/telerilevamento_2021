#setting setwd code, same as usual, active RStoolbox
setwd("C:/lab/solar")
library(raster)
#RStoolbox useful to classify, "classificazione non supervisionata" -> the softwere decide the class( training set) by itself
#https://bleutner.github.io/RStoolbox/
library(RStoolbox)
#in windows pay attention to the format of file during dowload, wd hide the format in the name and download it as .jpeg/ u need jpg
#tonight take a look at package(sp) -> https://cran.r-project.org/web/packages/sp/index.html
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#visualize rgb lelevels, use all possibnle stretch
#https://www.rdocumentation.org/packages/raster/versions/3.4-10/topics/plotRGB
plotRGB(so, 1,2,3, stretch="lin")
#classification: function "unsuperclass" contained in RStoolbox, to the definition take a look at Rmanual/argoument (file, n of Class)
#NB, r is keysensitive
#https://www.rdocumentation.org/packages/RStoolbox/versions/0.2.6/topics/unsuperClass
soclass<-unsuperClass(so, nClasses=3)
#we must plot the map, the obyet now that is classified is composed by many levels)
#usue $ to bound theobject with map
plot(soclass$map)
#now we can visualize the three defined class
#use function (set.seed)-> assigne a number to set randomized traing size
#https://qastack.it/programming/13605271/reasons-for-using-the-set-seed-function
#20class, associated wit colorramp palette
cl <- colorRampPalette(c('yellow','red','black'))(100)
soclasses<-unsuperClass(so, nClasses=20)
plot(soclasses$map, col=cl)
dev.off()
#try with another immagine
coron<-brick("suncorona.png")
corona<-unsuperClass(coron, nClasses=3)
plot(corona$map)
#in order to check the accuracy of a map created with the classification you must do a groud-check
dev.off()
#now we use the grand canyon immagine
gc<-brick("iss022e014078_087_lrg.jpg")
#note the difference plot-plotRGB, is a multylevel immagine
plotRGB(so, 1,2,3, stretch="lin")
dev.off()
plot(gc)
dev.off()
#grand canyon- https://landsat.visibleearth.nasa.gov/view.php?id=80948
#library for classification
library(raster)
library(RStoolbox)
setwd("C:/lab/solar")
#is a multilevel immgine so i must use function brick, to ploto plotRGB with color in its band, to visualize immagni with "natural color"
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
#note the difference using different kind of startch, both of them are with natural colors, but hist is "stressed"
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
#classification: functio "unsuperclass" contained in RStoolbox, to the definition take a look at Rmanual/argoument (file, n of Class)
#the pixel that compose the immagine, that presnt different value, are associeted, by the citeria if minimum difference (by the central value of the class), to X classes
#NB, r is keysensitive
gcclass<-unsuperClass(gc, nClasses=2)
#we must plot the map, the obyet now that is classified is composed by many levels)
#usue $ to bound theobject with map
plot(gcclass$map)
#is intresting to take a loook at the caratheristic of the classified immagine
gcclass
#remenber: the callification is based only on the refletance value, rapresented in the pixel
#https://virtuale.unibo.it/pluginfile.php/803698/mod_resource/content/1/ICARUS_2015.pdf
