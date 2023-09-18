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
- mapped sequences to *P. rubens* reference exome using bwa program in "mapping.sh" script



------    
<div id='id-section3'/>   


### Entry 3: 2023-09-18.



