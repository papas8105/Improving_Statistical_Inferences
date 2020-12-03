deltas <- seq(0.3,0.8,by = 0.1)
n      <- seq(10,100, by =   1)
data   <- data.frame(n=n)
for (ii in deltas){
  name <- paste('d',toString(ii),sep=' = ')
  data[,name] = power.t.test(delta = ii, n = data$n)$power
}
library(tidyr)

data <- data %>% gather(key='effect size',value = power,-n)

library(ggplot2)

g <- ggplot(data) + geom_line(aes(x=n,y=power,color = `effect size`)) + theme_bw()

g <- g + scale_y_continuous(label=c('25%','50%','75%','100%'),breaks = c(0.25,0.5,0.75,1.00))