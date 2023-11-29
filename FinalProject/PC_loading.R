
###################################
#  Selection scans for red spruce #
###################################

library(RcppCNPy) # for reading python numpy (.npy) files


### read in selection statistics (these are chi^2 distributed)

s<-npyLoad("RSBS_poly.selection.npy")

# convert test statistic to p-value
pval <- as.data.frame(1-pchisq(s,1))
names(pval) = c("p_PC1","p_PC2")

## read positions
p <- read.table("RSBS_poly_mafs.sites",sep="\t",header=T, stringsAsFactors=T)
dim(p) #680688      8

p_filtered = p[which(p$kept_sites==1),]
dim(p_filtered) # [1] 507966      8

# How many sites got filtered out when testing for selection? Why?

## make manhattan plot
plot(-log10(pval$p_PC1),
     col=p_filtered$chromo,
     xlab="Position",
     ylab="-log10(p-value)",
     main="Selection outliers: pcANGSD e=2 (K3)",
     cex=0.3)

# We can zoom in if there's something interesting near a position...

plot(-log10(pval$p_PC1[2e05:2.01e05]),
     col=p_filtered$chromo, 
     xlab="Position", 
     ylab="-log10(p-value)", 
     main="Selection outliers: pcANGSD e=2 (K3)")

# get the contig with the lowest p-value for selection
sel_contig <- p_filtered[which(pval$p_PC1==min(pval$p_PC1)),c("chromo","position")]
sel_contig

# get all the outliers with p-values below some cutoff
cutoff=1e-4   # equals a 1 in 5,000 probability
outlier_contigs_PC1 <- p_filtered[which(pval$p_PC1<cutoff),c("chromo","position")]
outlier_contigs_PC2 <- p_filtered[which(pval$p_PC2<cutoff),c("chromo","position")]


# how many outlier loci < the cutoff?
dim(outlier_contigs)[1]

# how many unique contigs harbor outlier loci?
length(unique(outlier_contigs_PC2$chromo)) #506



