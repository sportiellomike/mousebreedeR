#mousebreedeR
library(dqrng)
library(dplyr)
library(gtools)
library(tidyverse)
library(ggplot2)
library(reshape2)
library(viridis)
library(ggpubr)
Rfunctionstoload<-list.files(path = './R/',full.names = T)
lapply(Rfunctionstoload,source)
`%!in%` <- Negate(`%in%`)
# make example df
mouse1 <- c(2, 1, 0, 2, 2, 1, 1, 1, 0)
mouse2 <- c(0, 1, 0, 2, 1, 0, 0, 2, 1)
mouse3 <- c(2, 1, 2, 0, 2, 1, 1, 1, 0)
mouse4 <- c(1, 1, 0, 2, 2, 2, 2, 0, 2)
mouse5 <- c('M', 'F', 'M', 'M', 'F', 'M', 'F', 'M', 'F')
df <- data.frame(mouse1, mouse2, mouse3, mouse4, mouse5)

colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')

# encode definitions
homoneg <- c(
  0,
  NA,
  'homoneg',
  'neg',
  'doubleneg',
  'homoneg',
  'homonegative',
  'homozygousneg',
  'homozygous negative',
  'aa','bb','cc','dd','ee','ff','gg','hh','ii','jj','kk',
  'll','mm','nn','oo','pp','qq','rr','ss','tt','uu','vv','ww','xx','yy','zz'
)

homopos <- c(2,
             'doublepos',
             'homopos',
             'homopositive',
             'homozygouspos',
             'homozygous positive',
             'AA','BB','CC','DD','EE','FF','GG','HH','II','JJ','KK',
             'LL','MM','NN','OO','PP','QQ','RR','SS','TT','UU','VV','WW','XX','YY','ZZ')
het <- c(1,
         'pos',
         'Aa','Bb','Cc','Dd','Ee','Ff','Gg','Hh','Ii','Jj','Kk',
         'Ll','Mm','Nn','Oo','Pp','Qq','Rr','Ss','Tt','Uu','Vv','Ww','Xx','Yy','Zz')

male <- c('M', 'Male', 'MALE')
female <- c('F', 'Female', 'FEMALE')


males <- subset(df, df$sex %in% male)
females <- subset(df, df$sex %in% female)

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

# rename df
exampleData<-df
head(exampleData) # look at the top few rows

# first let's look at what happens when each mouse undergoes meiosis
meiosisoutput<-engageinmeiosis(exampleData)
head(meiosisoutput) # as you can see: some of these have an impossible number of alleles (0.5 copies). The next function will fix that by generating gametes that have either 0 or 1 copies of the allele like in real meiosis.

compilegametesousput<-compilegametes(meiosisoutput)
head(compilegametesousput)

# now we can separate them into sperm and eggs
spermandeggs(x = compilegametesousput,sex = 'sex')
head(sperm)
head(eggs)

# now we can actually have sex
fertilizeoutput<-fertilize(malegametes = sperm,
          femalegametes = eggs)

head(fertilizeoutput) # as you can see, we have genotypes, and we recorded who the mom and dad were. We also have a term called momdad that essentially saves that crossing (ie it pastes together the mom and the dad)

# next we have two ways of summarizing the outcome of the crossing.
# the first records the distribution of each genotype per momdad (ie per cross) and per gene
summarizefertilizationoutput<-summarizefertilization(fertilizeoutput)
head(summarizefertilizationoutput)

# the next way to summarize the data is probably more useful, and that's to generate the probability that each potential pup is actually born. Included in this summary are the probabilities a pup of that genotype is not born given a litter size from 1-10 pups. For example, "notthatgenotypefivepup" column gives the probability that, if 5 pups are born, what is the probability that none of them are that genotype? You can subtract those columns from 1 to get the probability that at least one pup is that genotype.
summarizepotentialpupoutput<-summarizepotentialpups(fertilizeoutput)
head(summarizepotentialpupoutput)

# it's likely that this last table will be the most useful to you. However, you may want to actually visualize this data, which you can do in some ways we recommend below

# first we wrangle the data a bit by melting it
meltsummarizefertoutput<-melt(summarizefertilizationoutput,
                              id.vars = c('gene','momdad'),
                              measure.vars = c('freqhomoneg','freqhet','freqhomopos'),
                              variable.name = 'genotype',
                              value.name = 'frequency'
)
meltsummarizefertoutput$percent<-(meltsummarizefertoutput$frequency)*100 # we calculate percent from the frequency
uniquemeltgenes<-unique(meltsummarizefertoutput$gene) # we look at the unique genes you gave earlier for plotting

rm(plotlist) # we remove this from your environment to make sure the list is empty before putting more things into it
plotlist<-list() # we make a new list

# this chunk of code will plot separate plots for each gene, and show you the distribution of each genotype (homoneg, het, or homopos) for each crossing
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
plotlist[1] # we can peek at the first gene by calling the first element of the list
ggarrange(plotlist = plotlist) # depending on your number of crosses, this plot may be huge, and it may make more sense to look at each element of the list individually as shown in one line above.

# this next plot will do the same thing as above plot, but instead of making separate plots per gene, you can make separate plots per cross, which may be easier to read.

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


### FIN ###
