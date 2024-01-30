test_that("one cross function works", {

  # first make the df
  # make example df
  gene1 <- c(0, 0, 1, 0)
  gene2 <- c(2, 2, 1, 0)
  gene5 <- c('M', 'F')
  df <- data.frame(gene1, gene2, gene5)
  colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
  exampleData<-df

  meiosisoutput<-engageinmeiosis(exampleData)
  compilegametesoutput<-compilegametes(meiosisoutput)
  spermandeggs(x = compilegametesoutput,sex = 'sex')
  fertilizeoutput<-fertilize(malegametes = sperm,
                             femalegametes = eggs)
  desiredvec<-c('homopos', 'homopos', 'homopos', 'homopos')

  expect_equal(canwegetalltheallelesfromonecross(x = fertilizeoutput,desiredvector = desiredvec), 'onecrossforonecopy')
})
