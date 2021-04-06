#dopoprovaseva
#attivazione funz raster precedente,ente installta
library(raster)
#recupero file esterno(in cartella lab)
setwd("C:/lab/")
#assegno nome a miei dati, ora interni a r, li carico con funzione BRICK
#funzione brik serve a importare file con multilev visualizzandoli tuuti
trieste<- brick("p224r63_2011_masked.grd")
#funz plot (visualizza) di dati denominati
plot(trieste)
#cambio di scala colori presntazioni dati
colorRampPalette(c("black","grey","light grey"))(100)
cl<-colorRampPalette(c("black","grey","light grey"))(100)
plot(trieste,col=cl)
#BANDE RILEVATE DA LENDSAT
#banda1=blu
#banda2=verde
#banda3=rosso
#banda4=infrared vicino
#banda5=infrared medio
#banda6=infrared termico
#banda7=infrared medio
#in order to visualize only one band->clean then current graph with dev.off
dev.off()
#in order to visualize only one band->tie up original immagine with the band that y want to visualize ($ simbnoloche lega)
plot(trieste$B1_sre)
#modify colours of immagine with colorrampplalette(comesopra)
#con sequenza colori ustata prima(named CL)
plot(trieste$B1_sre,col=cl)
#con sequenza colori nuova(named CLO)
clo<-colorRampPalette(c("green","blue","red","yellow"))(200)
plot(trieste$B1_sre,col=clo)
#clean all with dev.off
dev.off()
#with "par" i structure the pattern of the new plot, in this case 2 band for graphics(what i visualize), structured in 1 row and 2 columns
par(mfrow=c(1,2))
#now that i've structured the pattern of the graphics i camn plot wathever band i wont in it, in the limit of the stucture that i've decided wit the comand "par"
plot(trieste$B1_sre)
plot(trieste$B2_sre)
#exchange colums with row modyfing the argoument of the functi "par"
par(mfrow=c(2,1))
plot(trieste$B1_sre)
plot(trieste$B2_sre)
#parfmROW row and colums, parmfCOL clumns and row (in this case i'm going to have a graphics with 1 column and 4 rows with thenfirst 4 landsat's bands)
par(mfcol=c(1,4))
plot(trieste$B1_sre)
plot(trieste$B2_sre)
plot(trieste$B3_sre)
plot(trieste$B4_sre)
#i can play the same "game" changing col/row or the numbers(n of col/row) in the argoument, i can even change the colour's ramp of the immagine with colorramppalette, ALWAY DEV OFF IN ORDER TO CLEAN THE GRAPHIC WINDOW)
par(mfcol=c(2,2))
plot(trieste$B1_sre)
plot(trieste$B2_sre)
plot(trieste$B3_sre)
plot(trieste$B4_sre)
#i assigne "proper" colour to every band, every part of the graphics (see row 49)
clblue<-colorRampPalette(c("dark blue","blue","light blue"))(200)
clgreen<-colorRampPalette(c("dark green","green","light green"))(200)
clred<-colorRampPalette(c("dark red","red","pink"))(200)
clnir<-colorRampPalette(c("red","yellow","orange"))(200)
#with the old good plot i "print" every band in the colour tath i've assigned in the graphics order that i've decided with COLORRAMPPALETTE and PAR(MF..)
plot(trieste$B1_sre, col=clblue)
plot(trieste$B2_sre, col=clgreen)
plot(trieste$B3_sre, col=clred)
plot(trieste$B4_sre,col=clnir)
#with functio PLOTRBG i can create a multilayer raster based on the three visible band(blu, green, red)(word in our vision)
#argoument stretch help the visualization of the band, by stretching the band alwyas in a range from 0 to 1
plotRGB(trieste,r=3,g=2,b=1,stretch="Lin")
#change band in the three "position" allowed by rgb pattern. By using infared in red i can visualize this band, that i can't normally see)
plotRGB(trieste,r=4,g=3,b=2, stretch="Lin")
#change colour, infrared in green
plotRGB(trieste,r=3,g=4,b=2, stretch="Lin")
#change
plotRGB(trieste,r=3,g=2,b=4, stretch="Lin")
#par function (row 49,50)+plotRGB function
par(mfcol=c(2,2))
plotRGB(trieste,r=3,g=2,b=1,stretch="Lin")
plotRGB(trieste,r=4,g=3,b=2, stretch="Lin")
plotRGB(trieste,r=3,g=4,b=2, stretch="Lin")
plotRGB(trieste,r=3,g=2,b=4, stretch="Lin")
#stretch can be different by linear, now i use histogram stretch
par(mfcol=c(2,2))
plotRGB(trieste,r=3,g=2,b=1,stretch="hist")
plotRGB(trieste,r=4,g=3,b=2, stretch="hist")
plotRGB(trieste,r=3,g=4,b=2, stretch="hist")
plotRGB(trieste,r=3,g=2,b=4, stretch="hist")
#comparison between linar and histogram stretch
par(mfcol=c(2,1))
plotRGB(trieste,r=3,g=4,b=2, stretch="hist")
plotRGB(trieste,r=3,g=4,b=2, stretch="lin")
#total comparison (lin,hist)
par(mfrow=c(4,4))
#natural
plotRGB(trieste,r=3,g=2,b=1,stretch="Lin")
plotRGB(trieste,r=3,g=2,b=1,stretch="hist")
#r4,g3,b2
plotRGB(trieste,r=4,g=3,b=2, stretch="Lin")
plotRGB(trieste,r=4,g=3,b=2, stretch="hist")
#r3,g4.b2
plotRGB(trieste,r=3,g=4,b=2, stretch="Lin")
plotRGB(trieste,r=3,g=4,b=2, stretch="hist")
#r2,g2,b4
plotRGB(trieste,r=3,g=2,b=4, stretch="Lin")
plotRGB(trieste,r=3,g=2,b=4, stretch="hist")
dev.off()
#now we charge anothewr file, the same zone but in 1988 (p224r63_1988.grd), same procedure of upstair( ps. note the descritpion of the file)
#attivazione funz raster precedente,ente installta
library(raster)
#recupero file esterno(in cartella lab)
setwd("C:/lab/")
brick("p224r63_1988.grd")
#now we charge also the immagine used befor, the one of 2011
#we are going to see how work the multitemporal analysis
brick("p224r63_2011.grd")
#now we can see the information of both files, i rename it( per fare ordine)
ottantotto<- brick("p224r63_1988_masked.grd")
undici <- brick("p224r63_2011_masked.grd")
#function plotrgb on, before only 1988, after on both the part (with function par) of our multi temporal analysis (natural color, see line 66-68), i also use functin strech( line 67)
plotRGB(ottantotto, r=3, g=2, b=1, stretch="Lin")
#multitemporal 88-2011
par(mfcol=c(1,2))
plotRGB(undici, r=3, g=2, b=1, stretch="Lin")
plotRGB(ottantotto, r=3, g=2, b=1, stretch="Lin")
dev.off()
#multitemporan and comparison hist-lin strech function
par(mfcol=c(2,2))
plotRGB(undici, r=3, g=2, b=1, stretch="Lin")
plotRGB(undici, r=3, g=2, b=1, stretch="hist")
plotRGB(ottantotto, r=3, g=2, b=1, stretch="Lin")
plotRGB(ottantotto, r=3, g=2, b=1, stretch="hist")
#i print the immagion that i've cretated with the function pdf8 (i must use "" while i'm writhing the name of the file because im'going out from R)
pdf("mutitemp.pdf)
par(mfcol=c(2,2))
plotRGB(undici, r=3, g=2, b=1, stretch="Lin")
plotRGB(undici, r=3, g=2, b=1, stretch="hist")
plotRGB(ottantotto, r=3, g=2, b=1, stretch="Lin")
plotRGB(ottantotto, r=3, g=2, b=1, stretch="hist")
dev.off()



