# Define server logic required to draw a histogram
if(!require(pwr)){install.packages('pwr')}
library(pwr)
if(!require(ggplot2)){install.packages('ggplot2')}
library(ggplot2)
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    sims <- input$nSims
    M    <- input$M
    SD   <- input$s
    a    <- input$alpha
    p    <- numeric(sims) #set up empty variable to store all simulated p-values
    bars <- input$bars
    n    <- input$n
    #Run simulation
    for(i in 1:sims){ #for each simulated experiment
      x<-rnorm(n = n, mean = M, sd = SD) #Simulate data with specified mean, standard deviation, and sample size
      z<-t.test(x, mu=100,conf.level = 1 - a) #perform the t-test against mu (set to value you want to test against)
      p[i]<-z$p.value #get the p-value and store it
    }
    
    #Check power by summing significant p-values and dividing by number of simulations
    x <- sum((p < a)/sims) #power
    #Calculate power formally by power analysis
    power <-pwr.t.test(d=(M-100)/SD, n=n,sig.level= a,type="one.sample",alternative="two.sided")$power 
    power <- round(100*power,2)
    #determines M when power > 0. When power = 0, will set  M = 100.
    z <- input$zoom
    x_max <- 1
    y_max <- sims
    if( z ){
      x_max <-  0.05
      x_min <- -0.002
      y_max<-sims/4
    }
    g <- ggplot(data = as.data.frame(p),aes(p))
    g <- g + geom_histogram(binwidth=1/bars,fill='cyan',col='black',boundary=0)
    g <- g + xlab('p-values') + ylab('Frequency of p-values')
    g <- g + coord_cartesian(xlim=c(0,x_max),ylim=c(0,y_max)) + theme_minimal(base_size = 18)
    g <- g + ggtitle(paste("P-value distribution for ",format(sims, nsmall=0),
                           " one-sample two-sided t-tests with ",toString(power),"% power.",sep=""))
    g <- g + geom_hline(aes(yintercept = (0.05/a)*sims/bars,colour='Type I error rate'),
                        lwd = 0.8,lty=5)+theme(plot.title=
         element_text(hjust = 0.5), legend.title=element_blank(), legend.position = "top")
    output$text1    <- renderText(
      paste('The power we get from the simulations is',toString(100*x),'%,the theoritical power is written in 
the title of the plot.',sep = ' ')
    )
    g <- g + scale_colour_manual(values = c('Type I error rate' = "red"))
    
    output$text1 <- renderText(paste('The power we get from the simulations is',toString(100*x),
'%,the theoritical power is written in the title of the plot.',sep = ' '))
    g
  })
  
})
