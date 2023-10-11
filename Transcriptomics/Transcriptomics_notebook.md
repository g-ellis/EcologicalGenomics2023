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

