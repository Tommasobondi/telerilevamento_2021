#riguarda lezione
#knit r: report immagines and code on pdf, usual stuff to set the code(directory, packages)
install.packages("kintr")
install.packages("stitch")
setwd("c:/lab/greenland")
library(knitr)
#function for small-scale automatic reporting based on an R script and a template. The default template is an Rnw file (LaTeX)
stitch("greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
