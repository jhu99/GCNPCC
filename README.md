# GCNPCC: Inferring gene co-expression networks from scRNA-seq data using partial correlation coefficients

![](https://img.shields.io/github/r-package/v/jhu99/GCNVDA)
![](https://img.shields.io/github/license/jhu99/GCNPCC)
[![](https://img.shields.io/github/downloads/jhu99/GCNPCC/latest/total)](https://github.com/jhu99/GCNPCC/graphs/traffic)
![](https://img.shields.io/github/stars/jhu99/GCNPCC?style=social)


&emsp;We propose a method, GCNPCC, based on partial correlation coefficient to reconstruct gene co-expression networks by measuring correlation relationships among genes through statistical inference. Besides the gene interaction network, GCNPCC can also identify correlation relationships for gene modules that are composed of functionally similar genes, and infer the functional roles each gene played in the modules. We applied it to several real data sets and compared it with several state-of-the-art methods. Results demonstrate that our method is superior to other existing methods in terms of both accuracy and specificity.

## Installation

For installation please use the following codes in R

```
install_github("jhu99/GCNPCC")
install.packages("scalreg")
```

## Example

```
library(gcnpcc)
library(scalreg)
load('tests/A.rda')
p <- nrow(A)
h <- 0.3
R <- corr(p, A, h)
```

### Input of GCNPCC

 <li type="disc">A&nbsp;:&nbsp; gene expression matrix of the studied genes, with dimensions p × n (p genes, n samples/cells)</li>

 <li type="disc">p&nbsp;:&nbsp; number of genes involved in the calculation (equals to the number of columns of the transposed matrix A)</li>

 <li type="disc">h&nbsp;:&nbsp;&nbsp;regularization parameter controlling sparsity and stability of the model coefficients</li>

### Output of GCNPCC

The output of GCNPCC is a p x p  correlation matrix R with the format :

```
 1.000000000  0.0419810149 -0.011164979 -0.0002113050  ...
 0.041981015  1.0000000000  0.040414493 -0.0324912437  ...
-0.011164979  0.0404144930  1.000000000  0.0516676750  ...
 . 
 .
 .
```

where R [&nbsp;i&nbsp;,&nbsp;j&nbsp;] represents the correlation between gene i and gene j.

## Applications

The experimental code implementation in the paper can be viewed in applications folder.

## Citation

Feifei Ran, Bin Lian, Xuequn Shang, Jie He, Jialu Hu，Inferring gene co-expression networks from scRNA-seq data using partial correlation coefficients (submitted)

