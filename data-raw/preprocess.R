# make example df
mouse1 <- c(2, 1, 0, 2, 2, 1, 1, 1, 0)
mouse2 <- c(0, 1, 0, 2, 1, 0, 0, 2, 1)
mouse3 <- c(2, 1, 2, 0, 2, 1, 1, 1, 0)
mouse4 <- c(1, 1, 0, 2, 2, 2, 2, 0, 2)
mouse5 <- c('M', 'F', 'M', 'M', 'F', 'M', 'F', 'M', 'F')
df <- data.frame(mouse1, mouse2, mouse3, mouse4, mouse5)

colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
exampleData<-df

usethis::use_data(exampleData,overwrite = T)
