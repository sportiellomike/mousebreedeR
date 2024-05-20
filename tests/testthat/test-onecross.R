test_that("one cross function works", {
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
  gene1 <- c(0, 0, 1, 0)
  gene2 <- c(2, 2, 1, 0)
  gene5 <- c('M', 'F')
  df <- data.frame(gene1, gene2, gene5)
  colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
  exampleData<-df

  meiosisoutput<-engage_in_meiosis(exampleData)
  compilegametesoutput<-compile_gametes(meiosisoutput)
  sperm_and_eggs(x = compilegametesoutput,sex = 'sex')
  fertilizeoutput<-fertilize(malegametes = sperm,
                             femalegametes = eggs)
  desiredvec<-c('homopos', 'homopos', 'homopos', 'homopos')

  expect_equal(canwegetalltheallelesfromonecross(x = fertilizeoutput,desiredvector = desiredvec), 'onecrossforonecopy')
})
