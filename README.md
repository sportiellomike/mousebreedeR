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
To install, go to Rstudio or the R command line and run the following code.

`install.packages('devtools')`

`library(devtools)`

`install_github('sportiellomike/mousebreedeR',build_vignettes = T)`

`library(mousebreedeR)`


# Other
Any questions? Don't hesitate to reach out: michael_sportiello@urmc.rochester.edu.
