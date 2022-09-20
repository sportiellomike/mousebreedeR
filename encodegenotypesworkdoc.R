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
##########
#########
########
homonegchar <- c(
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

homoposchar <- c(
             'doublepos',
             'homopos',
             'homopositive',
             'homozygouspos',
             'homozygous positive',
             'AA','BB','CC','DD','EE','FF','GG','HH','II','JJ','KK',
             'LL','MM','NN','OO','PP','QQ','RR','SS','TT','UU','VV','WW','XX','YY','ZZ')
hetchar <- c(
         'pos',
         'het','heterozygote','heterozygous',
         'Aa','Bb','Cc','Dd','Ee','Ff','Gg','Hh','Ii','Jj','Kk',
         'Ll','Mm','Nn','Oo','Pp','Qq','Rr','Ss','Tt','Uu','Vv','Ww','Xx','Yy','Zz')

hetorhomopos<-c('hetorhomopos')
genotypevalschar<-c(homoposchar,homonegchar,hetchar,hetorhomopos)

use_data(homonegchar)
use_data(homoposchar)
use_data(hetchar)
use_data(genotypevalschar)








male <- c('M', 'Male', 'MALE')
female <- c('F', 'Female', 'FEMALE')
