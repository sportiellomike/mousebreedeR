#mouseschemer
library(dqrng)
library(dplyr)
library(gtools)
library(tidyverse)
library(ggplot2)
library(reshape2)
library(viridis)
library(ggpubr)
`%!in%` <- Negate(`%in%`)
# make example df
mouse1 <- c(2, 1, 0, 2, 2, 1, 1, 1, 0)
mouse2 <- c(0, 1, 0, 2, 1, 0, 0, 2, 1)
mouse3 <- c(2, 1, 2, 0, 2, 1, 1, 1, 0)
mouse4 <- c(1, 1, 0, 2, 2, 2, 2, 0, 2)
mouse5 <- c('M', 'F', 'M', 'M', 'F', 'M', 'F', 'M', 'F')
df <- data.frame(mouse1, mouse2, mouse3, mouse4, mouse5)

str(df)
df
colnames(df) <- c(paste0('gene', 2:dim(df)[2] - 1), 'sex')
df
str(df)

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
theme_set(theme(axis.text = element_text(size=8),
                axis.title = element_text(size=8),
                strip.text = element_text(size=8),
                axis.text.x = element_text(angle=90),
                legend.position = 'none',
                # strip.text.x = element_text(size = 8,margin = margin(.1, 0, .1, 0, "cm")),
                legend.text = element_text(size=7),
                legend.title = element_text(size=7),
                # legend.position = 'bottom',panel.border=element_blank(),
                panel.background = element_blank(),
                panel.grid.major = element_line(color='light grey')
))
# write functions
addmouseID <- function(x) {
  x$mouseID <- paste0('mouse', 1:dim(x)[1])
  return(x)
}

engageinmeiosis <- function(x) {
  x <- addmouseID(x)
  colnumerics <- as.character(lapply(x, FUN = is.numeric))
  indexcolnumerics <- which(colnumerics == T)
  indexcolchar <- which(colnumerics == F)
  gametegenotypes <- x[indexcolnumerics]
  gametemetadata <- x[indexcolchar]

  indexhomopos <- which(gametegenotypes == homopos)
  indexhomoneg <- which(gametegenotypes == homoneg)
  indexhet <- which(gametegenotypes == het)

  meiosedgenotypes <- gametegenotypes / 2
  returndf <- cbind(meiosedgenotypes, gametemetadata)
  rownames(returndf) <- returndf$mouseID
  return(returndf)
}
engageinmeiosisdf <- engageinmeiosis(df)

compilegametes <- function(x) {
  my_list <- list()
  print('printingmylist')
  print(my_list)
  # rowsindf<-dim(x)[1]
  # colsindf<-dim(x)[2]
  dfforhets <- data.frame(which(x == 0.5, arr.ind = TRUE))
  indexofmouseidsthatarehets <- dfforhets$row
  micetoberepeated <- x$mouseID[indexofmouseidsthatarehets]

  tablemicetoberepeated <- table(micetoberepeated)
  orderedmicetoberepeated <- names(tablemicetoberepeated)
  numberofrepeatesmicetoberepeated <- as.vector(tablemicetoberepeated)
  twotothenumberofrepeatesmicetoberepeated <-
    2 ^ numberofrepeatesmicetoberepeated
  times = 2
  # replist<-rep(micetoberepeated, times)
  repeateddf <-
    x[rep(x = orderedmicetoberepeated, times = twotothenumberofrepeatesmicetoberepeated), ]

  numberofmouserepeatsinrepeateddf <- repeateddf %>% count(mouseID)
  uniquemouseIDs <- unique(numberofmouserepeatsinrepeateddf$mouseID)
  # blanklist<-list()

  # individualmousedf<-subset(repeateddf,repeateddf$mouseID=='mouse4')
  # length(which(individualmousedf==.5))
  # permutations(n=2,r=5,v=c(0,1),repeats.allowed=T)
  # i<-'mouse2'
  print('printingmylist')
  print(my_list)
  for (i in uniquemouseIDs) {
    print('printingmylist beginingof first for loop')
    print(my_list)
    print(uniquemouseIDs)
    individualmousedf <- subset(repeateddf, repeateddf$mouseID == i)

    indexof.5sinindividual <- which(individualmousedf == .5)
    numberofgenesthatarehet <- rowSums(individualmousedf == 0.5)[1]

    perms <-
      permutations(
        n = 2,
        r = numberofgenesthatarehet,
        v = c(0, 1),
        repeats.allowed = T
      )
    perms <- (as.data.frame(perms))

    colswith.5 <-
      as.data.frame(which(individualmousedf == .5, arr.ind = T))
    uniquecolswith.5 <- unique(colswith.5$col)
    print('printingmylist end of first for loop')
    print(my_list)
    for (k in uniquecolswith.5) {
      for (j in 1:dim(perms)[2]) {
        whichcoltosubset <- uniquecolswith.5[j]
        individualmousedf[whichcoltosubset] <- perms[j]
        my_list[[length(my_list) + 1]] <- individualmousedf
      }

    }
  }
  my_list <- bind_rows(my_list)
  my_list[my_list == 0.5] <- NA
  my_list <- na.omit(my_list)
  my_list <- rbind(my_list, subset(x, x$mouseID %!in% my_list$mouseID))
  my_list$longID <- rownames(my_list)
  return(my_list)
}

x<-engageinmeiosisdf
compilegametesoutput <- compilegametes(engageinmeiosisdf)

spermandeggs <- function(x, sex = 'sex') {
  sperm <- subset(x, x$sex %in% male)
  eggs <- subset(x, x$sex %in% female)
  sperm <<- sperm
  eggs <<- eggs
}

spermandeggs(compilegametesoutput, sex = 'sex')

fertilize <- function(malegametes = sperm,
                      femalegametes = eggs) {
  listofzygotes <- list()
  for (row1 in 1:nrow(sperm)) {
    for (row2 in 1:nrow(eggs)) {
      spermcolnumerics <- as.character(lapply(sperm, FUN = is.numeric))
      spermindexcolnumerics <- which(spermcolnumerics == T)
      eggscolnumerics <- as.character(lapply(eggs, FUN = is.numeric))
      eggsindexcolnumerics <- which(eggscolnumerics == T)
      spermnumeric <- sperm[spermindexcolnumerics]
      eggsnumeric <- eggs[eggsindexcolnumerics]


      spermindexcolcharacter <- which(spermcolnumerics == F)
      eggsindexcolcharacter <- which(eggscolnumerics == F)
      spermcharacter <- sperm[spermindexcolcharacter]
      eggscharacter <- eggs[eggsindexcolcharacter]

      newzygote <- spermnumeric[row1, ] + eggsnumeric[row2, ]
      momdad <-paste0(spermcharacter[row1, 'mouseID'], 'x', eggscharacter[row2, 'mouseID'])
      newzygote <- cbind(newzygote, momdad)
      listofzygotes[[length(listofzygotes) + 1]] <- newzygote

    }

  }
  listofzygotes <- bind_rows(listofzygotes)
  listofzygotes[listofzygotes == 0] <- 'homoneg'
  listofzygotes[listofzygotes == 1] <- 'het'
  listofzygotes[listofzygotes == 2] <- 'homopos'
  listofzygotes$mom <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 1))
  listofzygotes$dad <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 2))
  return(listofzygotes)
}
fertilizeoutput <- fertilize()
#
# ggplot(fertilizeoutput, aes(x = gene1)) +
#   geom_bar(aes(y = ..prop.., stat="count",position = 'stack')) +
#   scale_y_continuous(labels = scales::percent)+
#   facet_grid(rows=vars(mom),cols= vars(dad),scales='free_y')

x<-fertilizeoutput


summarizefertilization <- function(x) {
  summarylist <- list()
  momdadcol <- which(colnames(x) == 'momdad')
  lastgenecol <- momdadcol - 1
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    for (i in 1:lastgenecol) {
      tableydat <- table(y[i])
      tableydat$gene <- colnames(y[i])
      tableydat$momdad <- q
      summarylist[[length(summarylist) + 1]] <- tableydat
    }
  }
  summarylist <- bind_rows(summarylist)
  numericcolsindex <- which(sapply(summarylist, is.numeric))
  charactercolsindex <- which(sapply(summarylist, is.character))
  numericcols <- summarylist[numericcolsindex]

  # replace(numericcols,is.na(numericcols),0)
  numericcols[is.na(numericcols)] = 0
  numericcols$rowsum <- rowSums(numericcols)
  numericcols$freqhomoneg <- numericcols$homoneg / numericcols$rowsum
  numericcols$freqhet <- numericcols$het / numericcols$rowsum
  numericcols$freqhomopos <- numericcols$homopos / numericcols$rowsum
  numericcols$percenthomoneg <- (numericcols$homoneg / numericcols$rowsum)*100
  numericcols$percenthet <- (numericcols$het / numericcols$rowsum)*100
  numericcols$percenthomopos <- (numericcols$homopos / numericcols$rowsum)*100

  charactercols <- summarylist[charactercolsindex]
  summarylist <- cbind(numericcols, charactercols)

  summarylist <- as.data.frame(summarylist)


   return(summarylist)

}

x<-fertilizeoutput
sumfertouput<-summarizefertilization(fertilizeoutput)
dim(subset(x, x$gene1=='het' & x$gene2=='het' & x$gene3=='het' & x$gene4=='het' & x$momdad=='mouse1xmouse2'))

aggregate(list(numdup=rep(1,nrow(x))), x, length)

summarizepotentialpups <- function(x) {
  summaryduplicateslist <- list()
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    y$rowsub <- dim(y)[1]
    summarydf <-
      aggregate(list(numduplicates = rep(1, nrow(y))), y, length)
    summarydf$freqchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub)
    summarydf$percentchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub) * 100

    summarydf$notthatgenotypeonepup<-abs(1-summarydf$freqchanceonepup)
    summarydf$notthatgenotypetwopup<-(summarydf$notthatgenotypeonepup)^2
    summarydf$notthatgenotypethreepup<-(summarydf$notthatgenotypeonepup)^3
    summarydf$notthatgenotypefourpup<-(summarydf$notthatgenotypeonepup)^4
    summarydf$notthatgenotypefivepup<-(summarydf$notthatgenotypeonepup)^5
    summarydf$notthatgenotypesixpup<-(summarydf$notthatgenotypeonepup)^6
    summarydf$notthatgenotypesevenpup<-(summarydf$notthatgenotypeonepup)^7
    summarydf$notthatgenotypeeightpup<-(summarydf$notthatgenotypeonepup)^8
    summarydf$notthatgenotypeninepup<-(summarydf$notthatgenotypeonepup)^9
    summarydf$notthatgenotypetenpup<-(summarydf$notthatgenotypeonepup)^10

    summaryduplicateslist[[length(summaryduplicateslist) + 1]] <-
      summarydf
  }
  summaryduplicateslist <- bind_rows(summaryduplicateslist)
  return(summaryduplicateslist)
}
summarizepotentialpupoutput<-summarizepotentialpups(fertilizeoutput)

oddsofgenotypeperpupnumber<-function(x){

}


summarizefertoutput<-summarizefertilization(fertilizeoutput)

meltsummarizefertoutput<-melt(summarizefertoutput,
                    id.vars = c('gene','momdad'),
                    measure.vars = c('freqhomoneg','freqhet','freqhomopos'),
                    variable.name = 'genotype',
                    value.name = 'frequency'
                    )
meltsummarizefertoutput$percent<-(meltsummarizefertoutput$frequency)*100
uniquemeltgenes<-unique(meltsummarizefertoutput$gene)

rm(plotlist)
plotlist<-list()
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
plotlist[1]
ggarrange(plotlist = plotlist)




rm(plotlist)
plotlist<-list()
uniquemepairings<-unique(meltsummarizefertoutput$momdad)
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



encodegenevalues<-function(){
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
           'het','heterozygote','heterozygous',
           'Aa','Bb','Cc','Dd','Ee','Ff','Gg','Hh','Ii','Jj','Kk',
           'Ll','Mm','Nn','Oo','Pp','Qq','Rr','Ss','Tt','Uu','Vv','Ww','Xx','Yy','Zz')

  hetorhomopos<-c('hetorhomopos')
  genotypevals<-c(homopos,homoneg,het,hetorhomopos)
}



x<-fertilizeoutput
head(fertilizeoutput)
desiredvector<-c('het','het','het','homoneg')





canwemakeexactlywhatwewantwithonecross <-
  function(fertilizeoutput = x,
           desiredvector = desiredvec) {
    encodegenevalues()
    genotypevals <- c(homopos, homoneg, het)
    # genotypevals %in% x[1]
    # x$gene1 %in% genotypevals
    # any(x[t]==genotypevals)

    genecols <- c()

    for (t in colnames(x)) {
      if (isTRUE(any(x[t] == genotypevals))) {
        genecols <- c(genecols, t)
      }
    }
    subsettedfertoutput <- x
    # for (q in genecols) {
    #   for (v in desiredvector) {
    #     # subsetcol <- genecols[q]
    #     print(v)
    #     subsettedfertoutput<-subset(subsettedfertoutput, subsettedfertoutput[q] == v)
    #   }
    # }

    for (q in genecols) {
      index <- which(genecols %in% q)
      subsettedfertoutput <-
        subset(subsettedfertoutput,
               subsettedfertoutput[q] == desiredvector[index])
    }
    if (dim(subsettedfertoutput)[1] == 0) {
      print(
        'With the genotypees you provided, it is impossible to make the mouse you want with one cross.'
      )
      return('notonecross')
    }
    if (dim(subsettedfertoutput)[1] > 0) {
      print('You can make the mouse you want with one cross.')
      return('onecross')
    }
  }

# x<-x[3,]
x<-fertilizeoutput
test<-canwemakeexactlywhatwewantwithonecross(x,desiredvector = desiredvec)

canwegetalltheallelesfromonecross <-
  function(x, desiredvector = desiredvec) {
    encodegenevalues()
    newdesiredvector <- c()
    for (v in desiredvector) {
      ifelse(
        v %in% homopos |
          v %in% het,
        newdesiredvector <-
          c(newdesiredvector, 'pos'),
        newdesiredvector <- c(newdesiredvector, 'neg')
      )
    }
    genecols <- c()
    for (t in colnames(x)) {
      if (isTRUE(any(x[t] == genotypevals))) {
        genecols <- c(genecols, t)
      }
    }
    genecolx<-x[genecols]
    genecolx[genecolx=='homopos']<-'pos'
    genecolx[genecolx=='het']<-'pos'
    genecolx[genecolx=='homoneg']<-'neg'
    subsettedforoutput <- genecolx
    for (q in genecols) {
      index <- which(genecols %in% q)
      subsettedforoutput <-
        subset(subsettedforoutput,
               subsettedforoutput[q] == newdesiredvector[index])
    }
    if (dim(subsettedforoutput)[1] == 0) {
      print(
        'With the genotypees you provided, it is impossible to put at least one copy in every position in one cross.'
      )
      return('notonecrossforonecopy')
    }
    if (dim(subsettedforoutput)[1] > 0) {
      print('You can make a mouse with at least one copy of each allele you want with one cross.')
      return('onecrossforonecopy')
    }

  }

allelesfromonecross<-canwegetalltheallelesfromonecross(x,desiredvector = desiredvec)

possiblepointsfromdesiredoutcome<-function(desiredvector = desiredvec){
  possiblepoints<-length(desiredvector)*100
    return(possiblepoints)
  }

possiblepointsfromdesiredoutcome(desiredvector)

x<-fertilizeoutput
head(x)



desiredvector<-c('het','het','het','homoneg')

addpoints<-function(x,desiredvec=desiredvector){
  desiredvector[desiredvector=='homopos']<-2
  desiredvector[desiredvector=='het']<-1
  desiredvector[desiredvector=='homoneg']<-0
  desiredvector<-as.numeric(desiredvector)
  length(desiredvector)
  pointsvector<-c()
  for (k in 1:length(desiredvector)) {
    if (x[k]==desiredvector[k]) {
      pointstoaddtovector<-100
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (x[k]-desiredvector[k]==-1) {
      pointstoaddtovector<-50
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (x[k]-desiredvector[k]==1) {
      pointstoaddtovector<-50
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (abs(x[k]-desiredvector[k])==2) {
      pointstoaddtovector<-0
      pointsvector <- c(pointsvector, pointstoaddtovector)

    }

  }
  sumpointsvector<-sum(pointsvector)
  return(sumpointsvector)
}
test<-apply(X=genecolx,MARGIN = 1,addpoints)

test<-(apply(X=genecolx,MARGIN = 1,addpoints))


x<-fertilizeoutput
head(x)

pointsperpup<-function(x,desiredvector=desiredvector){
  encodegenevalues()
  genecols <- c()
  for (t in colnames(x)) {
    if (isTRUE(any(x[t] == genotypevals))) {
      genecols <- c(genecols, t)
    }
  }
  genecolx<-x[genecols]
  genecolx[genecolx=='homopos']<-2
  genecolx[genecolx=='het']<-1
  genecolx[genecolx=='homoneg']<-0
  genecolx <- as.data.frame(lapply(genecolx,as.numeric))
  genecolx$points <- apply(X=genecolx,MARGIN = 1,addpoints)
  genecolx$possiblepoints<- apply(X=genecolx,MARGIN = 1,possiblepointsfromdesiredoutcome)
  genecolx$normalizedpoints<- genecolx$points / genecolx$possiblepoints
  y<-cbind(genecolx,x[,!names(x)%in%genecols])
  return(y)


}

pointsperpup<-pointsperpup(x)

x<-pointsperpupoutput
whichpairsshouldibreed<-function(x=pointsperpupoutput,desiredvector){
  maxpoints<-(max(x$points))
  maxpointindex<-which(x$points==maxpoints)
  maxpointsub<-subset(x,x$points==maxpoints)
  maxpercent<-(max(maxpointsub$percentchanceonepup))
  maxpercentindex<-which(maxpointsub$percentchanceonepup==maxpercent)

  crosseswithmaxpoints<-unique(maxpointsub$momdad[maxpointindex])
  crosseswithmaxpointsmaxpercent<-unique(maxpointsub$momdad[maxpercentindex])
  print('These following cross(es) get you closest to your desired mouse, and may even give you your desired mouse:')
  print(crosseswithmaxpoints)
  print('The cross(es) that gives you the highest percentage of pups with that closest genotype is:')
  print(crosseswithmaxpointsmaxpercent)
  print('which gives you the following percent chance of making that pup:')
  print(maxpercent)
  if (canwegetalltheallelesfromonecross(x = fertilizeoutput,desiredvector)=='notonecrossforonecopy') {
    print('You cannot get all the alleles you want into one mouse with one cross (even as a heterozygote), so you should make crosses from the list above that get as many alleles into the pup same pup as possible, and eventually cross those pups together.')
  }
  return(crosseswithmaxpointsmaxpercent)
}

canwegetalltheallelesfromonecross(fertilizeoutput)
test<-whichpairsshouldibreed(pointsperpupoutput,desiredvector = desiredvec)






df

### FIN ###
