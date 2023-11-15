---
output:
  pdf_document: default
  html_document: default
---
#Structural variants notebook

## Author: Gwen Ellis

### Affiliation: University of Vermont, Dept. of Biology

### E-mail contact: [gwen.ellis\@uvm.edu](mailto:gwen.ellis@uvm.edu){.email}

### Start Date: 2023.11.06

### End Date: 2023.11.14

### Project Descriptions:

This notebook will be used to document my workflow during the structural variants module of the 2023 Ecological Genomics course.

# Table of Contents:

-   [Entry 1: 2023-11-06](#id-section1)
-   [Entry 2: 2023-11-09](#id-section2)



------    
<div id='id-section1'/>   

### Entry 1: 2023-11-06.
- SV identification: splitting genome into windows, and then plotting PCA of these windows, windows that are similar to each other will cluster closer together in the MDS. These similar windows will then be joined together and classified as a single window and another PCA will be made from one of those clustered windows where the patterns of it reveal what kind of SVs may be present
- variants called for each scaffold (21)
- window size: every 1000 SNP
- NW_022145597.1 bcf to vcf
- using bcftools (version 1.10.2) to filter runs associated with each chromosome
  - phred > 40
  


<div id='id-section2'/>   

### Entry 2: 2023-11-09.
- considering the top 5% outliers as belonging to each of the three corners
- local PCA: Rscript ~/myscripts/run_lostruct.R -i ~/mydata/str_data -t snp -s 1000 -I /netfiles/ecogen/structural_variation/sample_info.tsv where to change window size
- GO Enrichment using the Gene Ontology Resource database.











