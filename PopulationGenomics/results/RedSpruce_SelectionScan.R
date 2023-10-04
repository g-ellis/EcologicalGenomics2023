###################################
#  Selection scans for red spruce #
###################################

library(RcppCNPy) # for reading python numpy (.npy) files


### read in selection statistics (these are chi^2 distributed)

selectionstats<-npyLoad("allRS_poly.selection.npy")

# convert test statistic to p-value
pval <- as.data.frame(1-pchisq(selectionstats,1))
names(pval) = c("p_PC1", "p_PC2")

## read positions, associate P-values with SNP meta-data
p <- read.table("allRS_poly_mafs.sites",sep="\t",header=T, stringsAsFactors=T)
dim(p)

p_filtered = p[which(p$kept_sites==1),]
dim(p_filtered)


# How many sites got filtered out when testing for selection? -> 132274 Why?

## make manhattan plot
plot(-log10(pval$p_PC1),
     col=p_filtered$chromo,
     xlab="Position",
     ylab="-log10(p-value)",
     main="Selection outliers: pcANGSD e=2 (K3)")



# We can zoom in if there's something interesting near a position...

plot(-log10(pval$p_PC1[2e05:2.01e05]),
     col=p_filtered$chromo, 
     xlab="Position", 
     ylab="-log10(p-value)", 
     main="Selection outliers: pcANGSD e=2 (K3)")

# get the contig with the lowest p-value for selection
sel_contig <- p_filtered[which(pval==min(pval$p_PC1)),c("chromo","position")]
sel_contig

# get all the outliers with p-values below some cutoff
cutoff=1e-3   # equals a 1 in 500 probability
outlier_contigs <- p_filtered[which(pval$p_PC1<cutoff),c("chromo","position")]
outlier_contigs_pc2 <- p_filtered[which(pval$p_PC2<cutoff),c("chromo","position")]


# how many outlier loci < the cutoff?
dim(outlier_contigs)[1]
dim(outlier_contigs_pc2)[1]

# how many unique contigs harbor outlier loci?
length(unique(outlier_contigs$chromo))
length(unique(outlier_contigs_pc2$chromo))

write.table(unique(outlier_contigs$chromo), # this will be used for GEA later
            "allRS_poly_PC1_outlier_contigs.txt", 
            sep=":",
            quote=F,
            row.names=F,
            col.names=F)

write.table(unique(outlier_contigs_pc2$chromo),
            "allRS_poly_PC2_outlier_contigs.txt", 
            sep=":",
            quote=F,
            row.names=F,
            col.names=F)


# selecting PC values that we'll be using as our covariates in the GEA
COV <- as.matrix(read.table("allRS_poly.cov"))

PCA <- eigen(COV)

data=as.data.frame(PCA$vectors)
data=data[,c(1:2)] # the second number here is the number of PC axes you want to keep

write.table(data,
            "allRS_poly_genPC1_2.txt",
            sep="\t",
            quote=F,
            row.names=F,
            col.names=F)

