#install.packages("viridis")
#viridis is a pack useful for manage the colour (clour the ggplot graphs)- https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
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
#take a look at multi-an code
#https://rdrr.io/cran/RStoolbox/man/rasterPCA.html
#by mult.an we crate the pc1, and then we will apply the moving window for statistic index on the pc1
#obviousli only the pc1 cant preserve all the information q, but it, by itselfes, can explain a lot of the variability
sentPCA<-rasterPCA(sent)
plot(sentPCA$map)
#note that from the firs pca to the last one we gradually lose a q of information
sentPCA
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary
#with function summary we can see how mutch the single component can explayn the variability (immagine it on a cartesan plan, how mutch the variabylity is distributed on the axis, original and component pc...)
#the first pc contain 67,36804% of the origianl information
summary(sentPCA$model)
#the name of the model is sentPCA, is made by various component, inside "map" the first component is pc1
pc1<-sentPCA$map$PC1
#is already active the par
pc1f<-focal(pc1, w=matrix(1/81, nrow=9, ncol=9), fun=sd)
plot(pc1f, col=clsd)
pc1f2<-focal(pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(pc1f2, col=clsd)
#source function, allow to use (upload, so " ") line of code already wirtten
#in this case i will test with file downloadable from virtulare page, download, C-lab-sim
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/source
#pay attention to the object, if the "source" code contains object denominated difference by the conde in witch you are actually working it could not work, you must pair the name
#source("source_ggplot.r")
#Error in eval(ei, envir) : object 'sentpca' not found -> correct the object's name
sentpca<-rasterPCA(sent)
source("source_ggplot.r")
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#https://www.rdocumentation.org/packages/ggplot2/versions/3.3.3
#ggplot create a new window (like par function). How it work? it add blocks, you must define the geometry (function geom_line, geom_point)
#in our case the dataset is a raster-> https://www.rdocumentation.org/packages/ggplot2/versions/0.9.0/topics/geom_raster
#open window, raster geometry, file in argoument, mapping argoument(we must choose what we want to map)
ggplot()+
geom_raster(pc1f2, mapping=aes(x=x, y=y, fill=layer))
dev.off()
#note that with this combo(rsterPCa with focal(stand dev) and ggplot) is amaziong to map the geographicas variation of the diversiti of territory, in every context!!!!!!!!
#viridis-The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”.
#to change scale in argoument: option=magma for es.
#to use a viridis' legend use function scale_fill_viridis (add funct with "+")
ggplot() +
geom_raster(pc1f2, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()
#to add title in ggplot funct "ggtitle"
gp1<-ggplot() +
geom_raster(pc1f2, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")
dev.off()
gp2<-ggplot() +
geom_raster(pc1f2, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")
dev.off()
gp3<-ggplot() +
geom_raster(pc1f2, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option="turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")
#now we have 3 map, with grid.arrange -https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html
grid.arrange(gp1, gp2, gp3, nrow=1)
#amazing
 










