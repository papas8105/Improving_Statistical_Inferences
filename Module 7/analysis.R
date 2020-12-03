## ANALYSIS SCRIPT 
## LOAD Libraries
if(!require('TOSTER')){install.packages('TOSTER')}
if(!require('dplyr')){install.packages('dplyr')}
if(!require('ggplot2')){install.packages('ggplot2')}
library('dplyr') #in case the package was not loaded
## LOAD THE DATA I ASSUME THAT YOU DOWNLOADED THE WHOLE PROJECT IN DESKTOP
setwd('~/Desktop')
data <- read.csv(
  'Replication Documentation/Processing and Analysis/Importable Data/data.csv')
## create a boxplot to get a glimpse of the data
g    <- ggplot(data) + geom_boxplot(aes(x = Actor,y = rank,fill=Actor)) 
## Sampling from the data
arnold <- data %>% filter(Actor == 'Arnold Schwarzenegger')
sly    <- data %>% filter(Actor == 'Sylvester Stallone')
#  We got the two groups
rm(data)
#  We are going to permute and sample from the two groups
powerTOSTtwo(alpha = 0.05,statistical_power = 0.9,low_eqbound_d = -0.8,
             high_eqbound_d = 0.8)
#  With the command above we see that we need 34 movies per group
#  Let us permute the rankings for each group using a seed for reproducibility
set.seed(1234)
group_arnie <- sample(arnold$rank)
group_sly   <- sample(sly$rank)
rm(sly,arnold)
## Now we are ready to sample 34 observations for each sample
group_arnie <- sample(group_arnie,34,replace = F)
group_sly   <- sample(group_sly  ,34,replace = F)
## We will conduct a TOSTtwo test (two independent samples)
TOSTtwo(mean(group_arnie),mean(group_sly),sd(group_arnie),sd(group_sly),
        n1=34,n2=34,
        low_eqbound_d = -0.8,high_eqbound_d = 0.8,alpha=0.05)
rm(group_arnie,group_sly)
## In order to see the boxplot for the whole data press in the command line g
## g (optional)
## with the boxplot it is obvious that sly have extreme ups and downs