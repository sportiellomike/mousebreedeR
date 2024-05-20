test_that("gametes compile", {
  library(mousebreedeR)
  library(dqrng)
  library(dplyr)
  library(gtools)
  library(tidyverse)
  library(ggplot2)
  library(reshape2)
  library(viridis)
  library(ggpubr)
  `%!in%` <- Negate(`%in%`)
  # first make the df
  # make example df
  gene1 <- c(0, 0, 0, 1, 0, 0, 0, 1)
  gene2 <- c(0, 0, 1, 0, 0, 0, 1, 0)
  gene3 <- c(0, 1, 0, 0, 0, 1, 0, 0)
  gene4 <- c(1, 0, 0, 0, 1, 0, 0, 0)
  gene5 <- c('M', 'M', 'M', 'M','F', 'F', 'F', 'F')
  df <- data.frame(gene1, gene2, gene3, gene4, gene5)
  colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
  exampleData<-df

  meiosisoutput<-engage_in_meiosis(exampleData)
  compilegametesoutput<-compile_gametes(meiosisoutput)
  compilegametesoutput_list<-as.list(compilegametesoutput[1:4])
  lapply(compilegametesoutput_list, floor)

  # the gametes should all have whole numbers, so rounding should have no effect, and it would be expected to be equal to the rounded version of itself.
  expect_equal(lapply(compilegametesoutput_list, floor), compilegametesoutput_list)
})
