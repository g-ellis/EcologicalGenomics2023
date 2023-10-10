############################################
#  Getting BioClim data for spruce samples #
############################################

library(raster) #spatial data package
library(FactoMineR) #PCA in R
library(factoextra) #PCA in R
library(corrplot) #plotting and data vis package


bio <- getData("worldclim",var="bio",res=10)

coords <- read.csv("https://www.uvm.edu/~kellrlab/forClass/colebrookSampleMetaData.csv", header=T)

#The chunk below refers to your bamlist file that you transferred during last week's PCA/admixture analysis. It should be the same one you want to use here -- if your sample list for analysis changes in the future, you'll need a different bamlist!
  
names <- read.table("e2_allRS_bam.list")
names <- unlist(strsplit(basename(as.character(names[,1])), split = ".sorted.rmdup.bam")) #removing path to just get sample ID
split = strsplit(names, "_")
pops <- data.frame(names[1:95], do.call(rbind, split[1:95]))
names(pops) = c("Ind", "Pop", "Row", "Col")

# merging coordinate data from meta-data df with our delimited "pops" df
angsd_coords <- merge(pops, coords, by.x="Ind", by.y="Tree")

points <- SpatialPoints(angsd_coords[c("Longitude","Latitude")])

#associate variables that correspond with our tree sample latitude-longitude points
clim <- extract(bio,points)

angsd_coords_clim <- cbind.data.frame(angsd_coords,clim)
str(angsd_coords_clim)



### Make the climate PCA: ###

clim_PCA = PCA(angsd_coords_clim[,15:33], graph=T) 

# Get a screeplot of cliamte PCA eigenvalues

fviz_eig(clim_PCA)

# What is the climate PCA space our red spruce pops occupy?

fviz_pca_biplot(clim_PCA, 
                geom.ind="point",
                col.ind = angsd_coords_clim$Latitude, 
                gradient.cols = c("#FC4E07", "#E7B800", "#00AFBB"),
                title="Climate PCA (Bioclim)",
                legend.title="Latitude")

# Which variables show the strongest correlation on the first 2 climate PC axes?
dimdesc(clim_PCA)[1:2]
# PC1 has strongest correlation with Bio 12 (mean precipitation) and PC2 has the strongest correlation with Bio 10 (mean temperature of warmest quarter) --> these are the two bioClim variables we'll use for our GEA

write.table(scale(angsd_coords_clim["bio12"]),
            "e2_allRS_bio12.txt",
            sep="\t",
            quote=F,
            row.names = F,
            col.names=F)

write.table(scale(angsd_coords_clim["bio10"]),
            "e2_allRS_bio10.txt",
            sep="\t",
            quote=F,
            row.names = F,
            col.names=F)

### back to bash to run GEA ###
