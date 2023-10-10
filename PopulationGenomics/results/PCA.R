library(ggplot2) # plotting
library(ggpubr) # plotting


## First, let's work on the genetic PCA:

e2_COV <- as.matrix(read.table("e2_allRS_poly.cov")) # read in the genetic covariance matrix

e2_PCA <- eigen(e2_COV) # extract the principal components from the COV matrix

## How much variance is explained by the first few PCs?
var <- round(e2_PCA$values/sum(e2_PCA$values),3)

var[1:3]
# 0.054 0.016 0.014 when e=1
# 0.053 0.035 0.028 when e=2, makes sense that PC2 is better explaining differentiation when K=3 because we're not compressing 2 different population history structures


# A "screeplot" of the eigenvalues of the PCA:

barplot(var, 
        xlab="Eigenvalues of the PCA", 
        ylab="Proportion of variance explained")


## Bring in the bam.list file and extract the sample info:
names <- read.table("allRS_bam.list")
names <- unlist(strsplit(basename(as.character(names[,1])), split = ".sorted.rmdup.bam"))
split = strsplit(names, "_")
pops <- data.frame(names[1:95], do.call(rbind, split[1:95]))
names(pops) = c("Ind", "Pop", "Row", "Col")

## A quick and humble PCA plot:

plot(PCA$vectors[,1:2],
     col=as.factor(pops[,2]),
     xlab="PC1",ylab="PC2", 
     main="Genetic PCA")

## A more beautiful PCA plot using ggplot :)

data=as.data.frame(PCA$vectors)
data=data[,c(1:3)]
data= cbind(data, pops)

cols=c("#377eB8","#EE9B00","#0A9396","#94D2BD","#FFCB69","#005f73","#E26D5C","#AE2012", "#6d597a", "#7EA16B","#d4e09b", "gray70")

PCA <- ggscatter(data, x = "V1", y = "V2",
          color = "Pop",
          mean.point = FALSE,
          star.plot = FALSE) +
  theme_bw(base_size = 13, base_family = "Times") +
  theme(panel.background = element_blank(), 
        legend.background = element_blank(), 
        panel.grid = element_blank(), 
        plot.background = element_blank(), 
        legend.text=element_text(size=rel(.7)), 
        axis.text = element_text(size=13), 
        legend.position = "bottom") +
  labs(x = paste0("PC1: (",var[1]*100,"%)"), y = paste0("PC2: (",var[2]*100,"%)"), title = "Red Spruce PCA (k=3)") +
  scale_color_manual(values=c(cols), name="Source population") +
  guides(colour = guide_legend(nrow = 2))




## Next, we can look at the admixture clustering:

# import the ancestry scores (these are the .Q files)

q <- read.table("allRS_poly.admix.2.Q", sep=" ", header=F)

K=dim(q)[2] #Find the level of K modeled

## order according to population code
ord<-order(pops[,2])

# make the plot:
k2_plot <- barplot(t(q)[,ord],
        col=cols[1:K],
        space=0,border=NA,
        xlab="Populations",ylab="Admixture proportions",
        main=paste0("Red spruce K=",K))
text(tapply(1:nrow(pops),pops[ord,2],mean),-0.05,unique(pops[ord,2]),xpd=T)
abline(v=cumsum(sapply(unique(pops[ord,2]),function(x){sum(pops[ord,2]==x)})),col=1,lwd=1.2)


#### Trying with k=3 ####

q3 <- read.table("allRS_poly.admix.3.Q", sep=" ", header=F)

K3=dim(q3)[2] #Find the level of K modeled

## order according to population code
ord<-order(pops[,2])

# make the plot:
k3_plot <- barplot(t(q3)[,ord],
        col=cols[1:K3],
        space=0,border=NA,
        xlab="Populations",ylab="Admixture proportions",
        main=paste0("Red spruce K=",K3))
text(tapply(1:nrow(pops),pops[ord,2],mean),-0.05,unique(pops[ord,2]),xpd=T)
abline(v=cumsum(sapply(unique(pops[ord,2]),function(x){sum(pops[ord,2]==x)})),col=1,lwd=1.2)


#### Trying with k=4 ####

q4 <- read.table("allRS_poly.admix.4.Q", sep=" ", header=F)

K4=dim(q4)[2] #Find the level of K modeled

## order according to population code
ord<-order(pops[,2])

# make the plot:
k4_plot <- barplot(t(q4)[,ord],
        col=cols[1:K4],
        space=0,border=NA,
        xlab="Populations",ylab="Admixture proportions",
        main=paste0("Red spruce K=",K4))
text(tapply(1:nrow(pops),pops[ord,2],mean),-0.05,unique(pops[ord,2]),xpd=T)
abline(v=cumsum(sapply(unique(pops[ord,2]),function(x){sum(pops[ord,2]==x)})),col=1,lwd=1.2)

