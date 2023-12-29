---
title: 'MousebreedeR: A novel software to assist in the design of mouse breeding strategies for complex genotypes of experimental organisms'
tags:
  - breeding
  - mouse
  - experimental organism
  - colony management
authors:
  - name: Mike Sportiello PhD
    orcid: 0000-0003-1690-8702
    corresponding: true
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
  - name: David J. Topham MS/PhD
    orcid: 0000-0002-9435-8673
    affiliation: 1

affiliations:
 - name: Center for Vaccine Biology and Immunology, University of Rochester Medical Center, Rochester, NY 14642, USA
   index: 1
 - name: Medical Scientist Training Program, University of Rochester Medical Center, Rochester, NY 14642, USA
   index: 2

date: 28 December 2023

bibliography: paper.bib
---

# Summary

With the advent of gene editing playing a regular role in science, the need to get the appropriate allele at each respective locus in a model organism is now common. Instead of simple "knockout" vs "wildtype" mouse experiments for example, it is common for there to be a gene of interest, another gene to mark cells of a certain phenotype, a cre expression locus, and more. While it is often obvious how to efficiently breed experimental organisms to obtain one locus of interest, once three or more loci are involved this becomes difficult to assess. MousebreedeR is a free and open source command line R package that takes desired mouse genotypes and as well as the mouse genotypes the user already has on hand as inputs, and delivers efficient breeding schema to the user. In addition, it gives the user probabilities of each potential genotype along the way.

# Statement of need

While obtaining a litter of full knockout mice from one WT/WT parent and one knockout/knockout parent is straightforward, this is not the case for when one has 4 loci in 4 separate mice of a variety of sexes. Furthermore, no current software exists to our knowledge that can quantitatively assist the user in creating their breeding schema. Indeed, if there are three alleles at each locus, when attempting to make a genetically marked, inducible, cre-lox model with T cell specificity as our lab was doing prompting us to create this software, 81 possible combinations exist (3 to the 4th power). With 81 possible males and 81 possible females to mate, 6561 possible pairings exist (81 * 81). Even when users are limited to 4 females and 4 males, as our vignette that comes with our package demonstrates, tradeoffs may exist between the probability of getting the genotype of interest and the probability of producing a high percentage of "close" genotypes. Furthermore, we supply the user helpful information like what the probability would be that no pups are born of the desired genotype in a litter. Our software gives the user all of this information, and we have supplied code that assists user in plotting these tables to help them visualize crosses of interest to help them make decisions.  

Efficient breeding is a scientific imperative: with a limited period of fertility in experimental organisms, users may only have limited attempts with organisms of certain genotypes [@RN204] [@RN203]. Furthermore, as most research centers pay per diem costs, inefficiency is a large direct cost for many experimentalists, with individual cages often costing hundreds of dollars per year. 

# Installation

library(devtools)
install_github('sportiellomike/mousebreedeR',build_vignettes = T)
library(mousebreedeR)

# References
