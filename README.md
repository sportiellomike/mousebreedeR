# mousebreedeR

## General Info
MousebreedeR was created by Mike Sportiello to assist scientists in developing the optimal breeding scheme for complex desired genotypes. This is free and open source. 

An acceptable citation follows: Sportiello M and Topham, D. MousebreedeR: A novel software to assist in the design of mouse breeding strategies for complex genotypes of experimental organisms. September 2022. https://github.com/sportiellomike/mousebreedeR.

# The problem
Often in science, complex genotypes are desired for a particular set of experiments. Especially when more than 2 loci are under consideration, the most efficient way to generate a desired mouse is not always obvious. 

# The solution
MousebreedeR takes into account the exact genotypes the user has available in their colony and calculates the most efficient way forward for the user by taking into account the sex and genotypes of the mice supplied, including when the user can't distinguish between between homozygous positive or heterozygote (or doesn't care which). MousebreedeR is also able to let the user know if they should start multiple pairings to decrease the amount of time to obtain a desired mouse if the genotype in question requires more than one cross. It does all of this by analyzing the desired mouse genotype and calculating its mousebreedeR score. Then, it permutes through all the possible pups. Finally, it calculates the probability of obtaining these pups for any given pairing. 

The attached vignette walks the user through all of mousebreedeR's functionality and visualiztion recommendations to make the best possible choice to conduct the most efficient science possible. 

# How to install
You don't __need__ to install anything. You can use the GUI found at https://sportiellomike.shinyapps.io/mousebreedeR/[https://sportiellomike.shinyapps.io/mousebreedeR/]. However, you can also download the package and vignette that comes with it as well.

To install, go to Rstudio or the R command line and run the following code.

`install.packages('devtools')`

`library(devtools)`

`install_github('sportiellomike/mousebreedeR',build_vignettes = T)`

`library(mousebreedeR)`

# How to actually run the software
Generally, I'd recommend just using the GUI unless you have a good reason not to (https://sportiellomike.shinyapps.io/mousebreedeR/[https://sportiellomike.shinyapps.io/mousebreedeR/]) since it can be used by true novices, and is the quickest way to get results.

This pacakge/vignette is built for people of intermediate R experience. Having said that, so long as you follow these instructions very carefully below, anyone should be able to use it. 

## Download what you need
* Download the vignette from this link: https://github.com/sportiellomike/mousebreedeR/blob/main/vignettes/Vignette.Rmd
* Open this file in Rstudio. The most up to date Rstudio can be downloaded here: https://posit.co/download/rstudio-desktop/

## Do what the vignette tells you to do
* You can always run the vignette by clicking the "Run" button on the top middle of the screen (top right of top left pane)
* You can test out the supplied example data by clicking "Run" and having done everything described in the "How to install" and "How to actually run the software" instructions on the ReadMe document you're actively rading right now.
* To use the program on your own data, supply your own dataframe in the correct format. 
	* The format should be in the same format as the CSV file supplied to you in this github called 'edit_this_CSV_with_breeder_mice.csv'. You can download this file at: https://github.com/sportiellomike/mousebreedeR/blob/JOSS_Edits/edit_this_CSV_with_breeder_mice.csv. 
	* You can directly edit this file and then re-save it named as something else. Then, in the vignette on line 52, just replace the file that's in quotes with the path of your file.
* Make sure to tell the program what your desired genotype is. You can do this on line 122. The length of this vector should be the same number of gene columns in your breeder column you described. Said another way, if you need 3 alleles to be homozygous positive, the dataframe of breeders should be 3 gene columns (and a sex column) and line 122 should be: `desiredvec<-c('homopos', 'homopos', 'homopos')`
* Once you're all set, click the "Run" button on the top middle of the screen (top right of top left pane). 
* Alternatively, you can click "Knit" near the middle of the top left pane and scroll through your output there. It is a little bit easier to read.

# Other
Any questions? Don't hesitate to reach out: michael_sportiello@urmc.rochester.edu.


<!-- badges: start -->
[![R-CMD-check](https://github.com/sportiellomike/mousebreedeR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/sportiellomike/mousebreedeR/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
