deltas <- seq(0.3,0.8,by = 0.1)
n      <- seq(10,100, by =   1)
alphas <- c(0.001,0.025,0.05,0.075,0.09,0.1)
data   <- data.frame(n=n)
for (ii in deltas){
  name <- paste('d',toString(ii),sep=' = ')
  data[,name] = power.t.test(delta = ii, n = data$n)$power
}
for (ii in 1:6){
  name <- paste('a',toString(alphas[ii]),sep=' = ')
  data[,name] = power.t.test(delta = deltas[ii],n=data$n,sig.level = alphas[ii])$power
}
library(tidyr)

data <- data %>% gather(key='interest',value = power,-n)

library(ggplot2)
data_b <- data[1:546,]
names(data_b)[2] <- "Cohen's Delta"
g <- ggplot(data_b) + geom_line(aes(x = n,y = power,color = `Cohen's Delta`)) + theme_bw()

g <- g + scale_y_continuous(label=c('25%','50%','75%','100%'),breaks = c(0.25,0.5,0.75,1.00))

data_c <- data[547:1092,]
names(data_c)[2] <- 'alpha'
h <- ggplot(data_c) + geom_line(aes(x = n,y = power,color = `alpha`)) + theme_bw()

h <- h + scale_y_continuous(label=c('25%','50%','75%','100%'),breaks = c(0.25,0.5,0.75,1.00))

library(cowplot)

plot_grid(g , h, labels = "AUTO")