# Population genomics noteook

## Author: Gwen Ellis

### Affiliation: University of Vermont, Dept. of Biology

### E-mail contact: [gwen.ellis\@uvm.edu](mailto:gwen.ellis@uvm.edu){.email}

### Start Date: 2023.09.11

### End Date: 2023.XX.XX

### Project Descriptions:

This notebook will be used to document my workflow during the population genomics module of the 2023 Ecological Genomics course.

# Table of Contents:

-   [Entry 1: 2023-09-11](#id-section1)
-   [Entry 2: 2023-09-13](#id-section2)
-   [Entry 3: 2023-09-18](#id-section3)
-   [Entry 4: 2023-09-20](#id-section4)
-   [Entry 5: 2023-09-25](#id-section5)

------    
<div id='id-section1'/>   


### Entry 1: 2023-09-11.   
- Reviewed red spruce (*Picea rubens*) study system and exome data
- set up working directories
- Fastqc of single sample in *P. rubens* data and analyzed quality


------    
<div id='id-section2'/>   


### Entry 2: 2023-09-13.  
- Reviewed fastqc output
- We saw good quality data for most of the read length, though the first 5bp had some variable base frequencies and the very end reads had slightly lower Q scores
- Using the our "fastp.sh" script, we mapped sequencing data from 2019 *P. rubens* population to genome using fastp
- comparison of pre and post trimming html files looked good! Removed the low quality bases at head and tail of sequence
- mapped sequences to Norway spruce (*P. rubias*) reference exome using bwa program in "mapping.sh" script



------    
<div id='id-section3'/>   


### Entry 3: 2023-09-18.
- Visualized .sam files and checked sam FLAGs
- Using sambamba and samtools, converted .sam files to .bam files, removed duplicate reads, and indexed files with our "process_bam.sh" script 


------    
<div id='id-section4'/>   


### Entry 4: 2023-09-20.
- calculating mapping stats using samtools with our population specific "bam_stats.sh" bash script
- output script 2019.stats.txt is organized in rows by each sample in the population with the following columns: Num_reads, Num_R1, Num_R2, Num_Paired, Num_MateMapped, Num_Singletons, Num_MateMappedDiffChr, Coverage_depth
- Coverage depth of this population is ~4x on average, which is low coverage but works for what we need since we're not going to be calling exact genotypes and instead will be estimating genotype likelihoods
- using ANGSD (Analyzing Next Generation Sequencing Data) program to calculate genotype likelihoods and allele frequencies for 2019 population with "ANGSD.sh" script with the following parameters:
* -nThreads 1 \ -remove_bads 1 \ -C 50 \ -baq 1 \ -minMapQ 20 \ -minQ 20 \ -GL 1 \ -doSaf 1
- output is site allele frequency (saf) likelihoods 


------    
<div id='id-section5'/>   


### Entry 5: 2023-09-25.
- estimating the site frequency spectrum (sfs) using saf likelihoods and our ANGSD_doTheta.sh, then using this to estimate nucleotide diversity and F_ST_ : mypop vs. black spruce
| - theta_w_ = segragating sites
| - theta_pi_ = pairwise diversity
| - Tajima's D = (theta_pi_ - theta_w_)/SD
- using an unfolded sfs since we don't know if the reference allele is the ancestral allele or not. 
- See Summary_diversity.R for diversity metric summary plots




