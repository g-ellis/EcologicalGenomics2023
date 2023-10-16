---
output:
  pdf_document: default
  html_document: default
---
#Transcriptomics noteook

## Author: Gwen Ellis

### Affiliation: University of Vermont, Dept. of Biology

### E-mail contact: [gwen.ellis\@uvm.edu](mailto:gwen.ellis@uvm.edu){.email}

### Start Date: 2023.10.09

### End Date: 2023.XX.XX

### Project Descriptions:

This notebook will be used to document my workflow during the population genomics module of the 2023 Ecological Genomics course.

# Table of Contents:

-   [Entry 1: 2023-10-09](#id-section1)
-   [Entry 2: 2023-10-11](#id-section2)
-   [Entry 3: 2023-10-16](#id-section3)


------    
<div id='id-section1'/>   


### Entry 1: 2023-10-09. 
- experimental set-up
   - Illumina RNAseq library prep protocols (TruSeq3)
   - (2 x 150bp) w/ the Illumina Novoseq 6000




<div id='id-section2'/>   


### Entry 2: 2023-10-11.  
- Acidification + Warming (HH)	F11  (HH_F11)
- fastp to clean data, not trimming beginning of sequence --> trying to preserve as much info as possible and we could be accidentally removing an important part of the sequence (fastp version 0.23.4)
  - phred >20, 6bp window, keeping reads >35bp
- 96.9% complete BUSCO score for assembly
<div id='id-section2'/>   


### Entry 3: 2023-10-16.  
- assessing read quality -> >20M reads/library is usually a good threshold for RNA-seq, on average we had 45.34M reads per library with 44.48M passing (98.14% passing)
- summary of reference assembly at ahud_Trinity_assembly_stats.txt
- BUSCO stats for assembly: 96.9% complete BUSCOs (7.1% single, 89.8% duplicate)
- prepping for mapping our sequencing reads to reference assembly outputs ahud_Trinity.fasta.gene_trans_map and ahud_Trinity.fasta.salmon.idx
- HH_F11_Rep1: 91.672% mapping rate

