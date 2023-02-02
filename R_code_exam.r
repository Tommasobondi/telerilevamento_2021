library(raster)
library(rgdal)
library(scales)
library(rasterVis)

#setting the variables: path to folder and final_prod_name
folder <- "phat\\to\\forder\\"
final_prod_name <- "C:\\tel21\\data_ok\\**.tif"

# Importa tutte le bande in una lista
bands <- list.files(folder, pattern = "*.jp2$", full.names = TRUE)

# Legge le bande con risoluzione originale
rasters <- lapply(bands, raster)

#ciclo for per scorrere attraverso la lista di bande e applicare la funzione resample ad ogni banda singolarmente (su band7, 20m)
rasters_resampled <- list()
for (i in 1:length(rasters)) {
  rasters_resampled[[i]] <- resample(rasters[[i]], rasters[[7]])
}

# Brick per unire i resample in un unico file raster
raster_brick <- brick(rasters_resampled)

#upload raster maskera, applica maschera, crop su no useful part
mask_shapefile <- readOGR("C:\\tel21\\ROI\\ROI_LES.shp")
masked_raster <- mask(raster_brick , mask_shapefile)
masked_crop <- crop(masked_raster, mask_shapefile)

#n normalizza valori rifl band tra 0 e 1  
#salvati prodotti pronti a uso
masked_crop_norm <- (masked_crop-min(masked_crop))/(max(masked_crop)-min(masked_crop))
names(masked_crop_norm) <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B8A", "B9", "B10", "B11", "B12")
a <- names(masked_crop_norm)
writeRaster(a, filename = final_prod_name.tif, format = "GTiff")

#verifica riuscita
print(masked_crop_norm)
plot(masked_crop_norm)
dev.off()

winter22<-brick("2023_w.tif")
winter19<-brick("2019_w.tif")
winter16<-brick("2016_w.tif")
summer16<-brick("2016_s.tif")
summer19<-brick("2019_s.tif")
summer22<-brick("2022_s.tif")

# Plot the images in par, set borders
par(mfrow=c(3,2),oma=c(0,2,4,0))
plotRGB(winter16, r=12, g=8, b=4, stretch="lin")
plotRGB(summer16, r=12, g=8, b=4, stretch="lin")
plotRGB(winter19, r=12, g=8, b=4, stretch="lin")
plotRGB(summer19, r=12, g=8, b=4, stretch="lin")
plotRGB(winter22, r=12, g=8, b=4, stretch="lin")
plotRGB(summer22, r=12, g=8, b=4, stretch="lin")

#give title to immages and subplots
mtext("winter-summer Short-Wave Infrared variation",side=3,line=2,outer=TRUE)
mtext("WINTER - SUMMER",side=3,line=0,outer=TRUE)
mtext("2022 - 2019 - 2016",side=2,line=0,outer=TRUE)
dev.off()

#NDVI -> vegetation index is good for quantifying the amount of vegetation.
#While high values suggest dense canopy, low or negative values indicate urban and water features
#Vegetation Index (B8-B4)/(B8+B4)
# NDVI = (NIR — RED) / (NIR + RED)

# ndvi function
ndvi<-function(b){
  ndvi<-(b[[8]]-b[[4]])/(b[[8]]+b[[4]])
  return(ndvi)
}

#NDVI
ndvi_w22<-ndvi(winter22)
ndvi_w19<-ndvi(winter19)
ndvi_w16<-ndvi(winter16)
ndvi_s16<-ndvi(summer16)
ndvi_s19<-ndvi(summer19)
ndvi_s22<-ndvi(summer22)

#annual variaton of ndvi
var16_ndvi <- ndvi_w16 - ndvi_s16
var19_ndvi <- ndvi_w19 - ndvi_s19
var22_ndvi <- ndvi_w22 - ndvi_s22
list_ndvi_var <- list(var16_ndvi, var19_ndvi, var22_ndvi)
ndvi_var <- stack(list_ndvi_var)
writeRaster(ndvi_var, filename = "ndvi_annual_variation", format = "GTiff")

cl <- colorRampPalette(c("blue","light blue","pink","red"))(200)
levelplot(ndvi_var,col.regions=cl, main="NDVI sesonal variation time series", names.attr=c("2016","2019","2022"))
dev.off()
#annual avarage ndvi
a16_ndvi <- (ndvi_w16 + ndvi_s16)/2
a19_ndvi <- (ndvi_w19 + ndvi_s19)/2
a22_ndvi <- (ndvi_w22 + ndvi_s22)/2
list_ndvi_a <- list(a16_ndvi, a19_ndvi, a22_ndvi)
ndvi_a <- stack(list_ndvi_a)
writeRaster(ndvi_a, filename = "NDVI_annual_avarage", format = "GTiff")

cl <- colorRampPalette(c("blue","light blue","pink","red"))(200)
levelplot(ndvi_a,col.regions=cl, main="NDVI time series", names.attr=c("2016","2019","2022"))
dev.off()
#Moisture Index = (NIR- SWIR)/(NIR+SWIR)
#Moisture Index (B8A-B11)/(B8A+B11)

# moisture index function
mi<-function(b){
  mi<-(b[[8]]-b[[11]])/(b[[8]]+b[[11]])
  return(mi)
}

#MI -> moisture index is ideal for finding water stress in plants. It uses the short-wave and near-infrared to generate an index of moisture content. 
#In general, wetter vegetation has higher values. But lower moisture index values suggest plants are under stress from insufficient moisture.
# moisture index winter22
mi_w22<-mi(winter22)
mi_w19<-mi(winter19)
mi_w16<-mi(winter16)
mi_s16<-mi(summer16)
mi_s19<-mi(summer19)
mi_s22<-mi(summer22)

#annual variaton of moisture index
var16_mi <- mi_w16 - mi_s16
var19_mi <- mi_w19 - mi_s19
var22_mi <- mi_w22 - mi_s22
list_mi_var <- list(var16_mi, var19_mi, var22_mi)
mi_var <- stack(list_mi_var)
writeRaster(mi_var, filename = "MI_annual_variation", format = "GTiff")

cl <- colorRampPalette(c("blue","light blue","pink","red"))(200)
levelplot(mi_var,col.regions=cl, main="Vegetation moisture sesonal variation time series", names.attr=c("2016","2019","2022"))
dev.off()
#annual avarage moisture index
a16_mi <- (ndvi_w16 + ndvi_s16)/2
a19_mi <- (ndvi_w19 + ndvi_s19)/2
a22_mi <- (ndvi_w22 + ndvi_s22)/2
list_mi_av <- list(a16_mi, a19_mi, a22_mi)
mi_av <- stack(list_mi_av)
writeRaster(mi_av, filename = "MI_annual_av", format = "GTiff")

cl <- colorRampPalette(c("blue","light blue","pink","red"))(200)
levelplot(mi_av,col.regions=cl, main="Vegetation moisture time series", names.attr=c("2016","2019","2022"))
dev.off()

MIsesonal <- brick("MI_annual_variation.tif")
names(MIsesonal) <- c("varmi2016", "varmi2019", "varmi2022")

NDVIsesonal <- brick("ndvi_annual_variation.tif")
names(NDVIsesonal) <- c("varndvi2016", "varndvi2019", "varndvi2022")

#2016
cor16 <- stack(MIsesonal$varmi2016, NDVIsesonal$varndvi2016)

ex_cor16_mi <-(cor16$varmi2016)
ex_cor16_ndvi <-(cor16$varndvi2016)

# checks for missing values in the data by using the "is.na" function and remove in both ->look at stackoverflow
#"|" operator is used to perform an element-wise OR operation between two logical vectors
#"is.na" function checks each element of the input vector and returns a logical vector indicating whether the corresponding element is missing or not
result of the OR operation between two logical vectors is also a logical vector, where the value of each corrisponding element is true
any_missing <- is.na(ex_cor16_mi) | is.na(ex_cor16_ndvi)
ex_cor16_mi_no_na <- ex_cor16_mi[!any_missing]
ex_cor16_ndvi_no_na <- ex_cor16_ndvi[!any_missing]

#linear regression model between seasonal variation in NDVI and MI
model_ses_var <- lm(ex_cor16_ndvi_no_na ~ ex_cor16_mi_no_na)

# Plot of the relationship between the two variables, adding the regression line in red and displaying the R-squared value on the plot.
#dependent variable is the seasonal variation in NDVI
plot(ex_cor16_ndvi_no_na, ex_cor16_mi_no_na, main="Relationship between MI and NDVI seasonal variation 2016", xlab="NDMI seasonal variation", ylab="NDVI seasonal variation")
abline(model_ses_var, col="red")
summary(model_ses_var)
text(x = 1, y = 0.9, labels = paste("R-squared =", round(summary(model_ses_var)$r.squared, 4)))
dev.off()              

#2019
cor19 <- stack(MIsesonal$varmi2019, NDVIsesonal$varndvi2019)

ex_cor19_mi <-(cor19$varmi2019)
ex_cor19_ndvi <-(cor19$varndvi2019)

# Check for missing values and remove it ->look at stackoverflow
any_missing <- is.na(ex_cor19_mi) | is.na(ex_cor19_ndvi)
ex_cor19_mi_no_na <- ex_cor19_mi[!any_missing]
ex_cor19_ndvi_no_na <- ex_cor19_ndvi[!any_missing]

# linear regression model between seasonal variation in NDVI and MI
model_ses_var <- lm(ex_cor19_ndvi_no_na ~ ex_cor19_mi_no_na)

# Plot the model
plot(ex_cor19_ndvi_no_na, ex_cor19_mi_no_na, main="Relationship between MI and NDVI seasonal variation 2019", xlab="NDMI seasonal variation", ylab="NDVI seasonal variation")
abline(model_ses_var, col="red")
summary(model_ses_var)
text(x = 0.5, y = 0.9, labels = paste("R-squared =", round(summary(model_ses_var)$r.squared, 4)))
dev.off()

#2022
cor22 <- stack(MIsesonal$varmi2022, NDVIsesonal$varndvi2022)

ex_cor22_mi <-(cor22$varmi2022)
ex_cor22_ndvi <-(cor22$varndvi2022)

# Check for missing values and remove it ->look at stackoverflow
any_missing <- is.na(ex_cor22_mi) | is.na(ex_cor22_ndvi)
ex_cor22_mi_no_na <- ex_cor22_mi[!any_missing]
ex_cor22_ndvi_no_na <- ex_cor19_ndvi[!any_missing]

# linear model
model_ses_var <- lm(ex_cor22_ndvi_no_na ~ ex_cor22_mi_no_na)

# Plot the model
plot(ex_cor22_ndvi_no_na, ex_cor22_mi_no_na, main="Relationship between MI and NDVI seasonal variation 2022", xlab="NDMI seasonal variation", ylab="NDVI seasonal variation")
abline(model_ses_var, col="red")
summary(model_ses_var)
text(x = 0.5, y = 0.9, labels = paste("R-squared =", round(summary(model_ses_var)$r.squared, 4)))
dev.off()

#plotting maps of the regressions' variables
cor16 <- stack(MIsesonal$varmi2016, NDVIsesonal$varndvi2016)
plotRGB(cor16, r="varmi2016", g=NULL, b="varndvi2016", stretch = "hist")
dev.off()

cor19 <- stack(MIsesonal$varmi2019, NDVIsesonal$varndvi2019)
plotRGB(cor19, r="varmi2019", g=NULL, b=varndvi2019, stretch = "hist")
dev.off()

cor22 <- stack(MIsesonal$varmi2022, NDVIsesonal$varndvi2022)
plotRGB(cor22, r="varmi2022", g=NULL, b="varndvi2022", stretch = "hist")
dev.off()

#now we are going to analize the temporal evolution of ndvi
NDVI <- brick("NDVI_annual_avarage.tif")
names(NDVI) <- c("ndvi_2016", "ndvi_2019", "ndvi_2022")

# plot istrogram to visualize distributibution ad set correct class
hist(NDVI)
dev.off()

#create matrix of classification and classify the product
reclass_ndvi <- c(-1, 0.2, 1,    #no_vegetation: (-1 - 0.2) = 1
              0.2, 0.35, 2,      #low: (0.2 - 0.35) = 2
             0.35, 0.5, 3,       #low_medium(0.35 - 0.5) = 3
             0.5, 0.65, 4,       #high_medium: (0.5 - 0.65) = 4
             0.65, Inf, 5)       #high: (0.65 - inf) = 5
reclass_m <- matrix(reclass_ndvi, ncol = 3, byrow = TRUE)
NDVI_class <- reclassify(NDVI, reclass_ndvi)

#plot, setting colour for 5 classes
plot(NDVI_class, legend = FALSE, col = c("black", "orange", "yellow", "green", "dark green"), axes = FALSE)

#set the legend
legend("bottomright", legend = c("Desertic", "Very low vegetation coverage", "Medium-low vegetation coverage", "Medium-high vegetation coverage", "High vegetation coverage"),
       fill = c("black", "orange", "yellow", "green", "dark green"))
dev.off()

#set the plot with par
par(mfrow = c(1, 3))
#work with table
#with table we calculate the frequency of the class in the last col [,,i] ->(look at stackover..), than calculate percentage
#create a table of class counts for each layer
#2016
class_counts <- table(NDVI_class$ndvi_2016[,,i])
class_percentages <- round(100 * class_counts / sum(class_counts), 2)
barplot(class_percentages, main = paste(names(NDVI)[i]), xlab = "Class", ylab = "Percentage", col = c("black", "orange", "yellow", "green", "dark green"))
#2019
class_counts <- table(NDVI_class$ndvi-2019[,,i])
class_percentages <- round(100 * class_counts / sum(class_counts), 2)
barplot(class_percentages, main = paste(names(NDVI)[i]), xlab = "Class", ylab = "Percentage", col = c("black", "orange", "yellow", "green", "dark green"))
#2022
class_counts <- table(NDVI_class$ndvi_2022[,,i])
class_percentages <- round(100 * class_counts / sum(class_counts), 2)
barplot(class_percentages, main = paste(names(NDVI)[i]), xlab = "Class", ylab = "Percentage", col = c("black", "orange", "yellow", "green", "dark green"))
dev.off()

#plot boxplot to visualize trend of ndvi
boxplot(NDVI, outline=F, horizontal=T, axes=T, names=c("ndvi_2016", "ndvi_2019", "ndvi_2022"), main="NDVI Value Boxplot")
dev.off()


#now we repeat the same passage but on the differencial between 2022 and 2016 classifying the decrease.       
NDVI_decrease <- NDVI$ndvi_2022 - NDVI$ndvi_2016
#levelplot to visualize decrease
clb <- colorRampPalette(c("blue","white","red"))(100)
levelplot(NDVI_decrease, col.regions=clb)
dev.off()

hist(NDVI_decrease)
reclass_ndvi_decrease <- c(-1, -0.2, 1,   
              -0.2, -0.1, 2,      
             -0.1, 0, 3,      
             0, 0.1, 4,       
             0.1, Inf, 5)       
reclass_m <- matrix(reclass_ndvi_decrease, ncol = 3, byrow = TRUE)
NDVI_decrease_class <- reclassify(NDVI_decrease, reclass_ndvi_decrease)

#plot, setting colour for 5 classes
plot(NDVI_decrease_class, legend = FALSE, col = c("red", "orange", "yellow", "light blue", "green"), axes = FALSE)

#set the legend
legend("bottomleft", legend = c("Strong decrease", "Decrease", "Light decrease", "Increase", "Strong increase"),
       fill = c("red", "orange", "yellow", "light blue", "green"))
dev.off()
