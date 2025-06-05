# GCNPCC: Inferring gene co-expression networks from scRNA-seq data using partial correlation coefficients

![](https://img.shields.io/github/r-package/v/jhu99/GCNPCC)
![](https://img.shields.io/github/license/jhu99/GCNPCC)
[![](https://img.shields.io/github/downloads/jhu99/GCNPCC/latest/total)](https://github.com/jhu99/GCNPCC/graphs/traffic)
![](https://img.shields.io/github/stars/jhu99/GCNPCC?style=social)


&emsp;&emsp;We propose a method, GCNPCC, based on partial correlation coefficient to reconstruct gene co-expression networks by measuring correlation relationships among genes through statistical inference. Besides the gene interaction network, GCNPCC can also identify correlation relationships for gene modules that are composed of functionally similar genes, and infer the functional roles each gene played in the modules. We applied it to several real data sets and compared it with several state-of-the-art methods. Results demonstrate that our method is superior to other existing methods in terms of both accuracy and specificity.

## Installation

For installation please use the following codes in R:

```R
install_github("jhu99/GCNPCC")
install.packages("scalreg")
```

## Example

This example calculates partial correlation coefficients for a set of $100$ genes across $421$ single cells using gene expression data from mouse embryonic stem cells:
```R
library(gcnpcc)
library(scalreg)
load('data/expressionData.rda')
p <- 100
h <- 4
res<-gcnpcc(A,100,4)
R <- res[[1]]      # partial correlation matrix
adj <- res[[2]]    # binary adjacency matrix
```
The output includes a partial correlation matrix and a binary adjacency matrix representing the gene co-expression network edges.

### Input of GCNPCC

`A` : A $p \times n$ matrix of gene expression data, where $p$ is the number of genes (here, $100$) and $n$ is the number of cells (here, $421$).

`p` : The number of genes involved in the calculation.

`h` : A regularization parameter controlling the sparsity and stability of the model coefficients (here, $h = 4$).

### Output of GCNPCC

The output of GCNPCC consists of a $p \times p$ correlation matrix $R$ with the format:
```
 1.0000000000 -0.024134294 -6.447580e-02  0.0414261210  ...
-0.0241342944  1.000000000  1.771790e-01  0.0129375893  ...
-0.0644757959  0.177178995  1.000000e+00  0.0562895332  ...
 . 
 .
 .
```
where $R\[i,j\]$ represents the partial correlation between gene $i$ and gene $j$.

Based on adaptive thresholding, this correlation matrix can be further transformed into a binary adjacency matrix $adj$, where each entry indicates the presence ($1$) or absence ($0$) of an edge between two genes in the inferred co-expression network:
```
1  0  0  0 ...
0  1  1  0 ...
0  1  1  0 ...
. 
.
.
```

## Applications

The experimental code implementation in the paper can be viewed in applications folder.

## Citation

Feifei Ran, Ying Liu, Bin Lian, Xuequn Shang, Jie He*, Jialu Hu*，Inferring gene co-expression networks from scRNA-seq data using partial correlation coefficients (submitted)
