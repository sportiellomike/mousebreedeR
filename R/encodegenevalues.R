#' fluximplied
#'
#' @description Pathway analysis of DESeq2 result or character vector of differentially expressed genes which also plots results.
#' @param inputdat what you are using as your input data, either a dataframe with genes as the rownames, a column for LFC, and a column for padj values
#' @param species either mus or hsa
#' @param geneformat either ENTREZ or symbol
#' @param inputformat either df or vector
#' @param padjcolname the name of the column in your dataframe, if applicable, that stores the padj values
#' @param pcutoff the alpha threshold for your padjustadjust
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
#' @export
#'
#' @examples
#' encodegenevalues()

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
