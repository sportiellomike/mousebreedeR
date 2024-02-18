## ----message=FALSE, warning=FALSE---------------------------------------------------------------------------------------------------
library(mousebreedeR)
library(dqrng)
library(dplyr)
library(gtools)
# library(tidyverse)
library(ggplot2)
library(reshape2)
library(viridis)
library(ggpubr)
`%!in%` <- Negate(`%in%`)


## -----------------------------------------------------------------------------------------------------------------------------------
# make example df
gene1 <- c(0, 0, 0, 1, 0, 0, 0, 1)
gene2 <- c(0, 0, 1, 0, 0, 0, 1, 0)
gene3 <- c(0, 1, 0, 0, 0, 1, 0, 0)
gene4 <- c(1, 0, 0, 0, 1, 0, 0, 0)
gene5 <- c('M', 'M', 'M', 'M','F', 'F', 'F', 'F')
df <- data.frame(gene1, gene2, gene3, gene4, gene5)
colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
head(df)

# df<- SAVE YOUR DATAFRAME OF AVAILABLE MICE TO THE VARIABLE df. DON'T FORGET TO UPDATED desiredvec BELOW.

# rename df
exampleData<-df


## -----------------------------------------------------------------------------------------------------------------------------------
# set ggplothemes
theme_set(
  theme(
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 8),
    strip.text = element_text(size = 8),
    axis.text.x = element_text(angle = 90),
    legend.position = 'none',
    # strip.text.x = element_text(size = 8,margin = margin(.1, 0, .1, 0, "cm")),
    legend.text = element_text(size = 7),
    legend.title = element_text(size = 7),
    # legend.position = 'bottom',panel.border=element_blank(),
    panel.background = element_blank(),
    panel.grid.major = element_line(color = 'light grey')
  )
)


## -----------------------------------------------------------------------------------------------------------------------------------
meiosisoutput<-engageinmeiosis(exampleData)
# head(meiosisoutput) # as you can see: some of these have an impossible number of alleles (0.5 copies). The next function will fix that by generating gametes that have either 0 or 1 copies of the allele like in real meiosis.

compilegametesoutput<-compilegametes(meiosisoutput)
head(compilegametesoutput)


## -----------------------------------------------------------------------------------------------------------------------------------
# now we can separate them into sperm and eggs
spermandeggs(x = compilegametesoutput,sex = 'sex')
head(sperm)
head(eggs)


## -----------------------------------------------------------------------------------------------------------------------------------
fertilizeoutput<-fertilize(malegametes = sperm,
          femalegametes = eggs)

head(fertilizeoutput)


## -----------------------------------------------------------------------------------------------------------------------------------
summarizefertilizationoutput<-summarizefertilization(fertilizeoutput)
head(summarizefertilizationoutput)


## -----------------------------------------------------------------------------------------------------------------------------------
summarizepotentialpupoutput<-summarizepotentialpups(fertilizeoutput)
head(summarizepotentialpupoutput)


## -----------------------------------------------------------------------------------------------------------------------------------
desiredvec<-c('homopos', 'homopos', 'homopos', 'homopos')  # UPDATE THIS desiredvec APPROPRIATELY FOR YOUR NEEDS


## -----------------------------------------------------------------------------------------------------------------------------------
canwegetalltheallelesfromonecross(x = fertilizeoutput,desiredvector = desiredvec)


## -----------------------------------------------------------------------------------------------------------------------------------
pointsperpupoutput<-pointsperpup(x = summarizepotentialpupoutput,desiredvector = desiredvec)
head(pointsperpupoutput)


## -----------------------------------------------------------------------------------------------------------------------------------
whichpairstobreed<-whichpairsshouldibreed(x=pointsperpupoutput,desiredvector = desiredvec)


## -----------------------------------------------------------------------------------------------------------------------------------
meltsummarizefertoutput<-melt(summarizefertilizationoutput,
                              id.vars = c('gene','momdad'),
                              measure.vars = c('freqhomoneg','freqhet','freqhomopos'),
                              variable.name = 'genotype',
                              value.name = 'frequency'
)
meltsummarizefertoutput$percent<-(meltsummarizefertoutput$frequency)*100 # we calculate percent from the frequency
uniquemeltgenes<-unique(meltsummarizefertoutput$gene) # we look at the unique genes you gave earlier for plotting

plotlist<-list() # we make a new list


## -----------------------------------------------------------------------------------------------------------------------------------
for (w in uniquemeltgenes) {
  subsetmelt<-subset(meltsummarizefertoutput,meltsummarizefertoutput$gene==w)
  print(subsetmelt)
  plot<-ggplot(subsetmelt)+geom_col(aes(y=percent,x=genotype,fill=genotype))+
    facet_wrap(~momdad)+
    scale_fill_viridis(labels=c("freqhomoneg" = "HomozygousNeg", "freqhet" = "Heterozygous",
                                "freqhomopos" = "HomozygousPos"),discrete = T,end=.8)+
    ggtitle(w)+
    theme(axis.text.x = element_text(angle=90),
          plot.title = element_text(hjust = 0.5))

  plotlist[[length(plotlist) + 1]] <- plot

}


## -----------------------------------------------------------------------------------------------------------------------------------
# plotlist[1] # we can peek at the first gene by calling the first element of the list
ggarrange(plotlist = plotlist)


## -----------------------------------------------------------------------------------------------------------------------------------
rm(plotlist) # we remove this from your environment to make sure the list is empty before putting more things into it
plotlist<-list() # we make a new list
uniquemepairings<-unique(meltsummarizefertoutput$momdad) # pull the unique pairings we have
for (w in uniquemepairings) {
  subsetmelt<-subset(meltsummarizefertoutput,meltsummarizefertoutput$momdad==w)
  print(subsetmelt)
  plot<-ggplot(subsetmelt)+geom_col(aes(y=percent,x=genotype,fill=genotype))+
    facet_wrap(~gene)+
    scale_x_discrete(labels=c("freqhomoneg" = "HomozygousNeg", "freqhet" = "Heterozygous",
                              "freqhomopos" = "HomozygousPos"))+
    scale_fill_viridis(discrete = T,end=.8)+
    ggtitle(w)+
    theme(axis.text.x = element_text(angle=90),
          plot.title = element_text(hjust = 0.5))

  plotlist[[length(plotlist) + 1]] <- plot

}
ggarrange(plotlist = plotlist)


## -----------------------------------------------------------------------------------------------------------------------------------
sessionInfo()


## -----------------------------------------------------------------------------------------------------------------------------------

# Here we can save all the data for minimally reproducible examples for documentation purposes.

usethis::use_data(exampleData)

usethis::use_data(meiosisoutput)

usethis::use_data(compilegametesoutput)

usethis::use_data(sperm)

usethis::use_data(eggs)

usethis::use_data(fertilizeoutput)

usethis::use_data(summarizefertilizationoutput)

usethis::use_data(summarizepotentialpupoutput)

usethis::use_data(desiredvec)

usethis::use_data(canwegetalltheallelesfromonecross)

usethis::use_data(pointsperpupoutput)

usethis::use_data(whichpairstobreed)



### FIN ###
