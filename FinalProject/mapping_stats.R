### comparing mapping statistics using Norway spruce reference and black spruce reference ###
# to note, RS here is meant to mean Norway spruce reference was used

BS_stats <- read.csv("BS.stats.csv") #from samtools mapping stats
RS_stats <- read.csv("RS.stats.csv") 

# What was the average sequencing coverage?
mean(BS_stats$Coverage_depth) # 2.667111
mean(RS_stats$Coverage_depth) # 4.203851


# What was the average mapping rate?
BS_stats$map_rate <- BS_stats$Num_Paired / BS_stats$Num_reads # adding column with each samples mapping rate
RS_stats$map_rate <- RS_stats$Num_Paired / RS_stats$Num_reads

mean(BS_stats$map_rate) # 0.6618776
mean(RS_stats$map_rate) # 0.6454636


# How many read pairs were mapped across different chromosomes?
mean(BS_stats$Num_MateMappedDiffChr) # 672164.7
mean(RS_stats$Num_MateMappedDiffChr) # 599994.2


# Now let's look at the specifics of the assembly itself to see why we're getting these differences in mapping
BS_contigs <- read.table("BS_contig_info.tsv") #from header of bam file using samtools
NS_contigs <- read.table("NS_contig_info.tsv")


# What is the average contig length (V2)?
mean(BS_contigs$V2) # 101115.6
mean(NS_contigs$V2) # 18869.3

#And then how many contigs does each reference have?
nrow(BS_contigs) # 28953
nrow(NS_contigs) # 30340






