---
title: 'MousebreedeR: A novel software to assist in the design of mouse breeding schema for complex genotypes of experimental organisms'
tags:
  - breeding
  - mouse
  - experimental organism
  - colony management
authors:
  - name: Mike Sportiello, PhD
    orcid: 0000-0003-1690-8702
    corresponding: true
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
  - name: David J. Topham, MS/PhD
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

With the advent of gene editing playing a regular role to produce new experimental models, the need to get the appropriate allele at each respective locus in a model organism is now common. Instead of simple "knockout" vs "wildtype" mouse experiments, for example, it is common for there to be a gene of interest that is either floxed or not floxed depending on the experimental group, another gene to mark cells of a certain phenotype such as a fluorescent reporter, a cre expression cassette to flox the gene of interest out, and more. While it is often obvious how to efficiently breed experimental organisms to obtain one locus of interest, once three or more loci are involved this becomes difficult to assess. MousebreedeR is a free and open source command line R package that takes desired mouse genotypes as well as the genotypes of potential mouse breeders the user already has on hand as inputs, and delivers efficient breeding schema to the user. In addition, it supplies the user with the probability of producing each potential pup, the probability that no pups of interest are born of the desired genotype in a litter, and more. We have also supplied code that assists the user in plotting these tables to help them visualize crosses of interest to help them make decisions in their breeding.  

# Statement of need

Efficient breeding is a scientific imperative: with a limited period of fertility in experimental organisms, users may only have limited attempts with organisms of desired genotypes [@RN204] [@RN203] since the time of fertility is often the limiting factor in experimental organisms. An inefficient cross can set the user back months in the case of a female pregnant with the non-optimal male's offspring once both gestational time and the necessary time it takes to wean pups off their mother's milk. Furthermore, as most research centers pay per diem costs, inefficiency is a large direct cost for many experimentalists, with individual cages often costing hundreds of dollars per year just in maintenance fees, not even accounting for the cost of extra rounds of genotyping for which one must account for genotyping costs (PCR primers, PCR mastermix, gels, dye, etc) or for people's time, which may take the form of decreased data production and the cost of of actually paying employees to do this work. Ethical and animal welfare concerns also arise as inefficient breeding results in the mass euthanasia of non-desired animals as well as ear/tail-clipping required to genotype which may cause animals pain and distress.

While the breeding schema to obtain a litter of full knockout mice from one Wildtype/Wildtype parent and one knockout/knockout parent is straightforward, this is not the case for when one has 4 alleles at 4 loci in 4 separate mice that need to be in the same mouse for a given planned experiment, for example. Furthermore, no current software exists to our knowledge that can quantitatively assist the user in creating their breeding schema. Indeed, if there are 2 alleles at each locus, when attempting to make a genetically marked, inducible, cre-lox model with T cell specificity as our lab was doing, prompting us to create this software, 81 possible combinations exist (3 (AA, Aa, and aa) to the 4th power). With 81 possible males and 81 possible females to mate, 6561 possible pairings exist (81 * 81). Use of this mousebreedeR software to optimize that breeding schema resulted in the publication of a thesis project and manuscript being prepped for submission. 

# Installation

library(devtools)
install_github('sportiellomike/mousebreedeR',build_vignettes = T)
library(mousebreedeR)

# References