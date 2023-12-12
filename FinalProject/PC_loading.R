
###################################
#  Selection scans for red spruce #
###################################

library(RcppCNPy) # for reading python numpy (.npy) files
library(tidyverse)
library(ggplot2) # plotting
library(ggpubr) # plotting
library(dplyr) # data manipulation
library(conStruct) #admixture mapping


### read in selection statistics (these are chi^2 distributed)
s<-npyLoad("RSBS_poly.selection.npy")

#read in PC loading weights
weights <- as.data.frame(npyLoad("RSBS_poly.weights.npy"))
names(weights) = c("PC1_loading","PC2_loading")

# convert test statistic to p-value
pval <- as.data.frame(1-pchisq(s,1))
names(pval) = c("p_PC1","p_PC2")

## read positions
p <- read.table("RSBS_poly_mafs.sites",sep="\t",header=T, stringsAsFactors=T)
dim(p) #680688      8

p_filtered = p[which(p$kept_sites==1),]
dim(p_filtered) # [1] 507966      8


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

# Add the PC loading weights to the associated positions
p_filtered <- cbind(p_filtered, weights) 

# get the contig with the lowest p-value for selection
sel_contig <- p_filtered[which(pval$p_PC1==min(pval$p_PC1)),c("chromo","position","PC1_loading","PC2_loading")]
sel_contig

# get all the outliers with p-values below some cutoff
cutoff=.0005   
outlier_contigs_PC1 <- p_filtered[which(pval$p_PC1<cutoff),c("chromo","position","PC1_loading","PC2_loading")]
outlier_contigs_PC2 <- p_filtered[which(pval$p_PC2<cutoff),c("chromo","position","PC1_loading","PC2_loading")]


# how many outlier loci < the cutoff?
dim(outlier_contigs_PC1)[1] #28
dim(outlier_contigs_PC2)[1] #1890

# how many unique contigs harbor outlier loci?
length(unique(outlier_contigs_PC2$chromo)) #1146
length(unique(outlier_contigs_PC1$chromo)) #24

# make tables of the outlier contigs for gene matching and GO enrichment
write.table(unique(outlier_contigs_PC1$chromo),
            "RSBS_poly_PC1_outlier_contigs.txt", 
            sep="\t",
            quote=F,
            row.names=F,
            col.names=F)

write.table(unique(outlier_contigs_PC2$chromo),
            "RSBS_poly_PC2_outlier_contigs.txt", 
            sep="\t",
            quote=F,
            row.names=F,
            col.names=F)


pc1_go <- read.csv("RSBS_PC1_GO_enrichment.csv")
pc1_pfam <- read.csv("RSBS_PC1_Pfam_enrichment.csv")
pc1_pfam_filter <- pc1_pfam[pc1_pfam$q.value <= 0.05,]


ggplot(data = pc1_pfam_filter, aes(x = mt.nt, y = Description, color = q.value, size = mt.nt)) + 
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_bw() + 
  ylab("") + 
  xlab("") + 
  ggtitle("Protein family enrichment")

ggplot(data = pc1_go, aes(x = Namespace, y = Description, color = q.value, size = mt.nt)) + 
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_bw() + 
  ylab("") + 
  xlab("") + 
  ggtitle("GO enrichment")


# ggscatter(outlier_contigs_PC1, x = "PC1_loading", y = "PC2_loading",
#      #     color = "Pop",
#           mean.point = FALSE,
#           star.plot = FALSE) +
#   theme_bw(base_size = 13, base_family = "Times") +
#   theme(panel.background = element_blank(), 
#         legend.background = element_blank(), 
#         panel.grid = element_blank(), 
#         plot.background = element_blank(), 
#         legend.text=element_text(size=rel(.7)), 
#         axis.text = element_text(size=13), 
#         legend.position = "bottom") +
#   labs(x = paste0("PC1: (",var[1]*100,"%)"), y = paste0("PC2: (",var[2]*100,"%)")) +
#   scale_color_manual(values=c(cols), name="Source population") +
#   guides(colour = guide_legend(nrow = 2))







